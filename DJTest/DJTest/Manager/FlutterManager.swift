//
//  FlutterManager.swift
//  DJTest
//
//  Created by lxthyme on 2023/12/26.
//

import Foundation
import Flutter
import FlutterPluginRegistrant
import LXToolKit
import LXToolKit_Example

// typealias LXFlutterMethod = FlutterManager.DefaultMethod
typealias LXFlutterChannel = FlutterManager.ChannelName

enum FlutterrError: Error {
    /// flutter engine 启动失败
    case engineRunFailure
}

let defaultChannel: FlutterManager.Channel = FlutterManager.Channel(entrypoint: .default, channelName: .default)
let topMainChannel: FlutterManager.Channel = FlutterManager.Channel(entrypoint: .topMain, channelName: .multiCounter)
let bottomMainChannel: FlutterManager.Channel = FlutterManager.Channel(entrypoint: .bottomMain, channelName: .multiCounter)

// MARK: - 👀
extension FlutterManager {
    public enum EntryPoint: String {
        case `default` = "FlutterDefaultDartEntrypoint"
        case topMain = "topMain"
        case bottomMain = "bottomMain"
        case galleryApp = "galleryApp"

        var value: String? {
            switch self {
            case .default: return nil
            default: return self.rawValue
            }
        }
    }
    public enum ChannelName: String {
        case `default` = "com.lx.flutter_cookbook"
        case multiCounter = "multiple-counter"
        // case channel(entrypoint: String?, engine: FlutterEngine, channel: FlutterMethodChannel)
        var name: String {
            return "\(FlutterManager.PrefixFlutter)\(self.rawValue)"
        }
    }
    open class Channel {
        var entrypoint: EntryPoint
        var channelName: ChannelName
        lazy var engine: FlutterEngine = {
            return FlutterManager.shared.registerFromGroup(withEntryPoint: entrypoint.value)
        }()
        lazy var methodChannel: FlutterMethodChannel = {
            return FlutterMethodChannel(name: channelName.name, binaryMessenger: engine.binaryMessenger)
        }()

        init(entrypoint: EntryPoint, channelName: ChannelName) {
            self.entrypoint = entrypoint
            self.channelName = channelName
        }
    }
}

// MARK: - 👀
public extension FlutterManager.Channel {
    func registerDefaultMethodChannel() {
        guard case .default = channelName else { return }
        dlog("-->channel: \(channelName.name)\tentrypoint: \(entrypoint.value ?? "nil")")
        methodChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
            dlog("-->[Flutter]call: \(call.method)-\(String(describing: call.arguments))")
            if call.method == LXFlutterMethod.DefaultScene.dismiss.methodName {
                UIViewController.top().dismiss(animated: true)
                result(nil)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
    }
}

// MARK: - 👀
public extension FlutterMethodChannel {
    func xl_invokeMethod(method: SceneFlutterProtocol, with arguments: Any?) {
        invokeMethod(method.methodName, arguments: arguments)
    }
}
/// flutter -> swift
public protocol SceneSwiftProtocol {
    var methodName: String { get }
}
/// swift -> flutter
public protocol SceneFlutterProtocol {
    var methodName: String { get }
}

struct LXFlutterMethod {}
// MARK: - 👀channel: default
extension LXFlutterMethod {
    enum DefaultScene: String, SceneSwiftProtocol {
        case dismiss
        var methodName: String {
            return "\(FlutterManager.PrefixSwift)\(self.rawValue)"
        }
    }
    enum MultiCounterScene: String, SceneSwiftProtocol {
        case incrementCount
        case next
        var methodName: String {
            return "\(FlutterManager.PrefixSwift)\(self.rawValue)"
        }
    }
    enum MultiCounterFlutterScene: String, SceneFlutterProtocol {
        case setCount
        var methodName: String {
            return "\(FlutterManager.PrefixFlutter)\(self.rawValue)"
        }
    }
}

open class FlutterManager {
    // MARK: 🔗Vaiables
    static let shared = FlutterManager()
    public static let identifier = "com.lx.flutter_cookbook"
    fileprivate static let PrefixFlutter = "flutter_"
    fileprivate static let PrefixSwift = "swift_"
    var flutterEngine: FlutterEngine?
    lazy var flutterEngineGroup = FlutterEngineGroup(name: FlutterManager.identifier, project: nil)
    // MARK: 🛠Life Cycle
    private init() {}
}

// MARK: - 👀
extension FlutterManager {
    public func register() {
        let flutterEngine = FlutterEngine(name: FlutterManager.identifier)
        guard flutterEngine.run() else {
            CrashlyticsManager.record(error: FlutterrError.engineRunFailure)
            return
        }
        GeneratedPluginRegistrant.register(with: flutterEngine)

        self.flutterEngine = flutterEngine
        registerRouter()
    }
    private func registerFromGroup(withEntryPoint entryPoint: String?) -> FlutterEngine {
        let newEngine = flutterEngineGroup.makeEngine(withEntrypoint: entryPoint, libraryURI: nil)
        GeneratedPluginRegistrant.register(with: newEngine)
        return newEngine
    }
}
// MARK: - 🔐
private extension FlutterManager {
    @discardableResult
    func registerRouter() -> FlutterMethodChannel? {
        guard let flutterEngine else { return nil }
        let channel = FlutterMethodChannel(name: LXFlutterChannel.default.rawValue, binaryMessenger: flutterEngine.binaryMessenger)
        channel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
            dlog("-->[Flutter]call: \(call.method)-\(String(describing: call.arguments))")
            if call.method == LXFlutterMethod.DefaultScene.dismiss.methodName {
                UIViewController.top().dismiss(animated: true)
                result(nil)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
        return channel
    }
}
