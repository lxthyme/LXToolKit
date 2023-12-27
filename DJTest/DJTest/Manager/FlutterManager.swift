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
    fileprivate static let Prefix = "flutter_"
    public enum EntryPoint: String {
        case `default` = "default"
        case topMain = "topMain"
        case bottomMain = "bottomMain"

        var channel: FlutterManager.Channel {
            switch self {
            case .default:
                return defaultChannel
            case .topMain:
                return topMainChannel
            case .bottomMain:
                return bottomMainChannel
            }
        }
    }
    enum ChannelName: String {
        case `default` = "FlutterDefaultDartEntrypoint"
        case multiCounter = "multiple-counter"
        // case channel(entrypoint: String?, engine: FlutterEngine, channel: FlutterMethodChannel)
        var name: String {
            return "\(FlutterManager.Prefix)\(self.rawValue)"
        }
    }
    class Channel {
        var entrypoint: EntryPoint
        var channelName: ChannelName
        lazy var engine: FlutterEngine = {
            let point: String? = if case .default = entrypoint {
                nil
            } else {
                entrypoint.rawValue
            }
            return FlutterManager.shared.registerFromGroup(withEntryPoint: point)
        }()
        lazy var channel: FlutterMethodChannel = {
            return FlutterMethodChannel(name: channelName.name, binaryMessenger: engine.binaryMessenger)
        }()

        init(entrypoint: EntryPoint, channelName: ChannelName) {
            self.entrypoint = entrypoint
            self.channelName = channelName
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
            return "\(FlutterManager.Prefix)\(self.rawValue)"
        }
    }
    // enum DefaultFlutter: String, MethodProtocol {
    //     case dismiss
    //     var methodName: String {
    //         return "\(FlutterManager.Prefix)\(self.rawValue)"
    //     }
    // }
    enum MultiCounterScene: String, SceneSwiftProtocol {
        case incrementCount
        case next
        var methodName: String {
            return "\(FlutterManager.Prefix)\(self.rawValue)"
        }
    }
    enum MultiCounterFlutterScene: String, SceneFlutterProtocol {
        case setCount
        var methodName: String {
            return "\(FlutterManager.Prefix)\(self.rawValue)"
        }
    }
}

open class FlutterManager {
    // MARK: 🔗Vaiables
    static let shared = FlutterManager()
    public static let identifier = "com.lx.flutter_cookbook"
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
                result(true)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
        return channel
    }
}
