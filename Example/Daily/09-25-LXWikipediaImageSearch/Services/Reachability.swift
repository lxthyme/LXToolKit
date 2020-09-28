//
//  Reachability.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
import SystemConfiguration
import Foundation

enum ReachabilityError: Error {
    case failedToCreateWithAddress(sockaddr_in)
    case failedToCreateWithHostname(String)
    case unableToSetCallback
    case unableToSetDispatchQueue
}

let ReachabilityChangedNotification = Notification.Name("ReachabilityChangedNotification")

func callback(reachability: SCNetworkReachability, flags: SCNetworkReachabilityFlags, info: UnsafeMutableRawPointer?) {
    guard let info = info else { return }

    let reachability = Unmanaged<Reachability>.fromOpaque(info).takeUnretainedValue()
    DispatchQueue.main.async {
        reachability.reachabilityChanged()
    }
}

class Reachability {
    typealias NetworkReachable = (Reachability) ->Void
    typealias NetworkUnreachable = (Reachability) ->Void

    enum NetworkStatus: CustomStringConvertible {
        case notReachable, reachableViaWifi, reachableViaWWAN

        var description: String {
            switch self {
                case .reachableViaWWAN: return "Cellular"
                case .reachableViaWifi: return "Wifi"
                case .notReachable: return "No Connection"
            }
        }
    }

    var whenReachable: NetworkReachable?
    var whenUnreachable: NetworkUnreachable?
    var reachableOnWWAN: Bool

    /// The notification center on which "reachability changed" events are being posted
    var notifictionCenter = NotificationCenter.default

    var currentReachabilityString: String {
        return "\(currentReachabilityStatus)"
    }

    var currentReachabilityStatus: NetworkStatus {
        guard isReachable else { return .notReachable }

        if isReachableViaWifi {
            return .reachableViaWifi
        }

        if isRunningOnDevice {
            return .reachableViaWWAN
        }

        return .notReachable
    }

    private var previousFlags: SCNetworkReachabilityFlags?

    private var isRunningOnDevice: Bool = {
        #if targetEnvironment(simulator)
        return false
        #else
        return true
        #endif
    }()

    private var notifierRunning = false
    private var reachabilityRef: SCNetworkReachability?

    private let reachabilitySerialQueue = DispatchQueue(label: "com.lx.reachability.test")

    required init(reachabilityRef: SCNetworkReachability) {
        reachableOnWWAN = true
        self.reachabilityRef = reachabilityRef
    }

    convenience init?(hostname: String) {
        guard let ref = SCNetworkReachabilityCreateWithName(nil, hostname) else { return nil }

        self.init(reachabilityRef: ref)
    }

    convenience init?() {
        var zeroAddress = sockaddr()
        zeroAddress.sa_len = UInt8(MemoryLayout<sockaddr>.size)
        zeroAddress.sa_family = sa_family_t(AF_INET)

        guard let ref = withUnsafePointer(to: &zeroAddress, {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }) else { return nil }

        self.init(reachabilityRef: ref)
    }

    deinit {
        stopNotifier()

        reachabilityRef = nil
        whenReachable = nil
        whenUnreachable = nil
    }
}

// MARK: - 👀
extension Reachability {
    // MARK: - 🔥*** Notifier methods ***
    func startNotifier() throws {
        guard let reachabilityRef = reachabilityRef, !notifierRunning else { return }

        var ctx = SCNetworkReachabilityContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil)
        ctx.info = UnsafeMutableRawPointer(Unmanaged<Reachability>.passUnretained(self).toOpaque())
        if !SCNetworkReachabilitySetCallback(reachabilityRef, callback, &ctx) {
            stopNotifier()
            throw ReachabilityError.unableToSetCallback
        }

        if !SCNetworkReachabilitySetDispatchQueue(reachabilityRef, reachabilitySerialQueue) {
            stopNotifier()
            throw ReachabilityError.unableToSetDispatchQueue
        }

        /// Perform an initial check
        reachabilitySerialQueue.async {
            self.reachabilityChanged()
        }

        notifierRunning = true
    }
    func stopNotifier() {
        defer { notifierRunning = false }
        guard let reachabilityRef = reachabilityRef else { return }

        SCNetworkReachabilitySetCallback(reachabilityRef, nil, nil)
        SCNetworkReachabilitySetDispatchQueue(reachabilityRef, nil)
    }

    // MARK: - 🔥*** Connection test methods ***
    var isReachable: Bool {
        guard isReachableFlagSet else { return false }

        if isConnectionRequiredAndTransientFlagSet {
            return false
        }

        if isRunningOnDevice {
            if isOnWWANFlagSet && !reachableOnWWAN {
                // We don't want to connect when on 3G.
                return false
            }
        }
        return true
    }

    var isReachableViaWWAN: Bool {
        /// Check we're not on the simulator, we're REACHABLE and check we're on WWAN
        return isRunningOnDevice && isReachableFlagSet && isOnWWANFlagSet
    }

    var isReachableViaWifi: Bool {
        /// Check we're reachable
        guard isReachableFlagSet else { return false }
        /// If reachable we're reachable, but not on an iOS device (i.e. simulator), we must be on WiFi
        guard isRunningOnDevice else { return true }

        /// Check we're NOT on WWAN
        return !isOnWWANFlagSet
    }
}
// MARK: - 👀
extension Reachability: CustomStringConvertible {
    var description: String {
        let W = isRunningOnDevice ? (isOnWWANFlagSet ? "W" : "-") : "X"
        let R = isReachableFlagSet ? "R" : "-"
        let c = isConnectionRequiredFlagSet ? "c" : "-"
        let t = isTransientConnectionFlagSet ? "t" : "-"
        let i = isInterventionRequiredFlagSet ? "i" : "-"
        let C = isConnectionOnTrafficFlagSet ? "C" : "-"
        let D = isConnectionOnDemandFlagSet ? "D" : "-"
        let l = isLocalAddressFlagSet ? "l" : "-"
        let d = isDirectFlagSet ? "d" : "-"

        return "\(W)\(R) \(c)\(t)\(i)\(C)\(D)\(l)\(d)"
    }
}
// MARK: - 🔐
private extension Reachability {
    func reachabilityChanged() {
        let flags = reachabilityFlags

        guard previousFlags != flags else { return }

        let block = isReachable ? whenReachable : whenUnreachable
        block?(self)

        self.notifictionCenter.post(name: ReachabilityChangedNotification, object: self)

        previousFlags = flags
    }
    var isOnWWANFlagSet: Bool {
        return reachabilityFlags.contains(.isWWAN)
    }
    var isReachableFlagSet: Bool {
        return reachabilityFlags.contains(.reachable)
    }
    var isConnectionRequiredFlagSet: Bool {
        return reachabilityFlags.contains(.connectionRequired)
    }
    var isInterventionRequiredFlagSet: Bool {
        return reachabilityFlags.contains(.interventionRequired)
    }
    var isConnectionOnTrafficFlagSet: Bool {
        return reachabilityFlags.contains(.connectionOnTraffic)
    }
    var isConnectionOnDemandFlagSet: Bool {
        return reachabilityFlags.contains(.connectionOnDemand)
    }
    var isConnectionOnTrafficOrDemandFlagSet: Bool {
        return !reachabilityFlags.intersection([.connectionOnTraffic, .connectionOnDemand]).isEmpty
    }
    var isTransientConnectionFlagSet: Bool {
        return reachabilityFlags.contains(.transientConnection)
    }
    var isLocalAddressFlagSet: Bool {
        return reachabilityFlags.contains(.isLocalAddress)
    }
    var isDirectFlagSet: Bool {
        return reachabilityFlags.contains(.isDirect)
    }
    var isConnectionRequiredAndTransientFlagSet: Bool {
        return reachabilityFlags.intersection([.connectionRequired, .transientConnection]) == [.connectionRequired, .transientConnection]
    }

    var reachabilityFlags: SCNetworkReachabilityFlags {
        guard let reachabilityRef = reachabilityRef else { return SCNetworkReachabilityFlags() }

        var flags = SCNetworkReachabilityFlags()
        let gotFlags = withUnsafeMutablePointer(to: &flags) {
            SCNetworkReachabilityGetFlags(reachabilityRef, UnsafeMutablePointer($0))
        }

        return gotFlags ? flags : SCNetworkReachabilityFlags()
    }
}
