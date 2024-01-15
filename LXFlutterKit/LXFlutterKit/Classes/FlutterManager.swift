//
//  FlutterManager.swift
//  DJTest
//
//  Created by lxthyme on 2023/12/26.
//

import Foundation
import Flutter
// import FlutterPluginRegistrant
import LXToolKit
import Toast_Swift

// typealias LXFlutterMethod = FlutterManager.DefaultMethod
typealias LXFlutterChannel = FlutterManager.ChannelName

enum FlutterrError: Error {
    /// flutter engine 启动失败
    case engineRunFailure
    case FlutterMethodNotImplemented
    case callSwiftMethodFailure
    case callSwiftMethodMissing
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
        case daily_MyScaffold = "daily_MyScaffold"
        case daily_TutorialHome = "daily_TutorialHome"
        case daily_MyButton = "daily_MyButton"
        case daily_Counter = "daily_Counter"
        case daily_MultiCounter = "daily_MultiCounter"
        case demo_app_bar = "demo_app_bar"
        case demo_cupertino_activity_indicator = "demo_cupertino_activity_indicator"
        case demo_cupertino_alert = "demo_cupertino_alert"
        case demo_two_pane = "demo_two_pane"

        case gsyHome = "gsyHome"
        case gsyLogin = "gsyLogin"

        public var value: String? {
            switch self {
            case .default: return nil
            default: return self.rawValue
            }
        }
    }
    public enum ChannelName: String {
        case `default` = "com.lx.flutter_cookbook"
        case multiCounter = "multiple-counter"
        public var name: String {
            return "\(FlutterManager.PrefixFlutter)\(self.rawValue)"
        }
    }
    open class Channel {
        public var entrypoint: EntryPoint
        public var channelName: ChannelName
        private lazy var extraChannel: [FlutterMethodChannel] = {
            guard let engine else { return [] }
            return extraChannelName.map { FlutterMethodChannel(name: $0.name, binaryMessenger: engine.binaryMessenger) }
        }()
        public var extraChannelName: [ChannelName] = []
        public var engine: FlutterEngine?
        // public lazy var engine: FlutterEngine = {
        //     return FlutterManager.shared.registerFromGroup(withEntryPoint: entrypoint.value)
        // }()
        public lazy var methodChannel: FlutterMethodChannel? = {
            guard let engine else { return nil }
            return FlutterMethodChannel(name: channelName.name, binaryMessenger: engine.binaryMessenger)
        }()

        public init(entrypoint: EntryPoint, channelName: ChannelName) {
            self.entrypoint = entrypoint
            self.channelName = channelName
        }
    }
}

// MARK: - 👀
public extension FlutterManager.Channel {
    func tryRegisterExtraDefaultMethodChannel() {
        guard extraChannelName.isNotEmpty else { return }
        zip(self.extraChannelName, self.extraChannel).forEach {[weak self] (channelName, methodChannel)
            in
            guard let self else { return }
            if case .default = channelName {
                dlog("-->channel[Extera]: \(channelName.name)\tentrypoint: \(entrypoint.value ?? "nil")")
                registerDefaultMethodChannel(methodChannel: methodChannel)
            }
        }
    }
    func tryRegisterDefaultMethodChannel() {
        guard case .default = channelName else { return }
        dlog("-->channel: \(channelName.name)\tentrypoint: \(entrypoint.value ?? "nil")")
        registerDefaultMethodChannel(methodChannel: methodChannel)
    }
    func registerDefaultMethodChannel(methodChannel: FlutterMethodChannel?) {
        methodChannel?.setMethodCallHandler {[weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            guard let self else { return }
            dlog("-->[Flutter]call: \(call.method)-\(String(describing: call.arguments))")
            guard let scene = LXFlutterMethod.DefaultScene.sceneFrom(title: call.method, arguments: call.arguments) else {
                FlutterManager.reportError(error: .FlutterMethodNotImplemented,
                                           call: call,
                                           channelName: channelName,
                                           entryPoint: entrypoint)
                result(FlutterMethodNotImplemented)
                return
            }
            switch scene {
            case .dismiss(let animated):
                if let topVC = UIViewController.topViewController() {
                    topVC.dismiss(animated: animated)
                    result(true)
                }
            case .push(let vcName, let animated):
                if let nav = UIViewController.topViewController()?.navigationController,
                   let vc = vcName.xl.getVCInstance() {
                    nav.pushViewController(vc, animated: animated)
                    result(true)
                }
            case .pop(let animated):
                if let nav = UIViewController.topViewController()?.navigationController {
                    nav.popViewController(animated: animated)
                    result(true)
                }
            case .popTo(let vcName, let animated):
                if let nav = UIViewController.topViewController()?.navigationController,
                   let vc = vcName.xl.getVCInstance() {
                    nav.popToViewController(vc, animated: animated)
                    result(true)
                }
            case .popToRoot(let animated):
                if let nav = UIViewController.topViewController()?.navigationController {
                    nav.popToRootViewController(animated: animated)
                    result(true)
                }
            case .setNavHidden(let isHidden, let animated):
                if let nav = UIViewController.topViewController()?.navigationController {
                    nav.setNavigationBarHidden(isHidden, animated: animated)
                    result(true)
                }
            case .toast(let title, let message, let imageNamed, let duration, let position, let completion):
                let image: UIImage? = if let imageNamed, imageNamed.isNotEmpty {
                    UIImage(named: imageNamed)
                } else {
                    nil
                }
                UIApplication.XL.keyWindow?.makeToast(message, duration: duration, position: position, title: title, image: image, completion: completion)
                result(true)
            case let .resultFailureTest(storeCode, storeType, comSid):
                result(false)
            }
            FlutterManager.reportError(error: .callSwiftMethodFailure,
                                       call: call,
                                       channelName: channelName,
                                       entryPoint: entrypoint)
            result(false)
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

public struct LXFlutterMethod {}
// MARK: - 👀channel: default
public extension LXFlutterMethod {
    enum DefaultScene: SceneSwiftProtocol {
        case dismiss(animated: Bool)
        case push(vcName: String, animated: Bool)
        case pop(animated: Bool)
        case popTo(vcName: String, animated: Bool)
        case popToRoot(animated: Bool)
        case setNavHidden(isHidden: Bool, animated: Bool)
        // UIApplication.XL.keyWindow?.makeToast(<#T##message: String?##String?#>, duration: <#T##TimeInterval#>, position: <#T##ToastPosition#>, title: <#T##String?#>, imageNamed: <#T##UIImage?#>, style: <#T##ToastStyle#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(_ didTap: Bool) -> Void#>)
        case toast(message: String, title: String?, imageNamed: String?, duration: TimeInterval = 2, position: ToastPosition = .bottom, completion: ((_ didTap: Bool) -> Void)?)
        case resultFailureTest(storeCode: String, storeType: String, comSid: String)

        public var methodName: String {
            return "\(FlutterManager.PrefixSwift)\(title)"
        }
        var title: String {
            switch self {
            case .dismiss: return "dismiss"
            case .push: return "push"
            case .pop: return "pop"
            case .popTo: return "popTo"
            case .popToRoot: return "popToRoot"
            case .setNavHidden: return "setNavHidden"
            case .toast: return "toast"
            case .resultFailureTest: return "resultFailureTest"
            }
        }
        static func sceneFrom(title: String, arguments: Any?) -> DefaultScene? {
            let params = arguments as? [String: Any]
            switch title.removingPrefix(FlutterManager.PrefixSwift) {
            case "dismiss":
                let animated = params?["animated"] as? Bool
                return .dismiss(animated: animated ?? true)
            case "push":
                if let vcName = params?["vcName"] as? String {
                    let animated = params?["animated"] as? Bool
                    return .push(vcName: vcName, animated: animated ?? true)
                }
            case "pop":
                let animated = params?["animated"] as? Bool
                return .pop(animated: animated ?? true)
            case "popTo":
                if let vcName = params?["vcName"] as? String {
                    let animated = params?["animated"] as? Bool
                    return .popTo(vcName: vcName, animated: animated ?? true)
                }
            case "popToRoot":
                let animated = params?["animated"] as? Bool
                return .popToRoot(animated: animated ?? true)
            case "setNavHidden":
                if let isHidden = params?["isHidden"] as? Bool {
                    let animated = params?["animated"] as? Bool
                    return .setNavHidden(isHidden: isHidden, animated: animated ?? true)
                }
            case "toast":
                if let message = params?["message"] as? String {
                    let title = params?["title"] as? String
                    let imageNamed = params?["imageNamed"] as? String
                    let duration = params?["duration"] as? TimeInterval
                    let position = params?["position"] as? String
                    let completion = params?["completion"] as? (Bool) -> Void
                    var pos: ToastPosition?
                    switch position {
                    case "top": pos = .top
                    case "bottom": pos = .bottom
                    case "center": pos = .center
                    default: break
                    }
                    return .toast(message: message, title: title, imageNamed: imageNamed, duration: duration ?? 2, position: pos ?? .bottom, completion: completion)
                }
            case "resultFailureTest":
                if let storeCode = params?["storeCode"] as? String,
                   let storeType = params?["storeType"] as? String,
                   let comSid = params?["comSid"] as? String {
                    return .resultFailureTest(storeCode: storeCode, storeType: storeType, comSid: comSid)
                }
            default: break
            }
            CrashlyticsManager.record(error: FlutterrError.callSwiftMethodMissing, userInfo: [
                "method": title,
                "prefix": FlutterManager.PrefixSwift,
                "arguments": String(describing: arguments)
            ])
            return nil
        }
    }
    enum MultiCounterScene: String, SceneSwiftProtocol {
        case incrementCount
        case next
        public var methodName: String {
            return "\(FlutterManager.PrefixSwift)\(self.rawValue)"
        }
    }
    enum MultiCounterFlutterScene: String, SceneFlutterProtocol {
        case setCount
        public var methodName: String {
            return "\(FlutterManager.PrefixFlutter)\(self.rawValue)"
        }
    }
}

open class FlutterManager {
    // MARK: 🔗Vaiables
    public static let shared = FlutterManager()
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
        // GeneratedPluginRegistrant.register(with: flutterEngine)

        self.flutterEngine = flutterEngine
        registerRouter()
    }
    public func registerFromGroup(withEntryPoint entryPoint: String?) -> FlutterEngine {
        let newEngine = flutterEngineGroup.makeEngine(withEntrypoint: entryPoint, libraryURI: nil)
        // GeneratedPluginRegistrant.register(with: newEngine)
        return newEngine
    }
}
// MARK: - 🔐
private extension FlutterManager {
    @discardableResult
    func registerRouter() -> FlutterMethodChannel? {
        guard let flutterEngine else { return nil }
        let channel = FlutterMethodChannel(name: LXFlutterChannel.default.rawValue, binaryMessenger: flutterEngine.binaryMessenger)
        // channel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
        //     dlog("-->[Flutter]call: \(call.method)-\(String(describing: call.arguments))")
        //     if call.method == LXFlutterMethod.DefaultScene.dismiss.methodName {
        //         UIViewController.topViewController()?.dismiss(animated: true)
        //         result(nil)
        //     } else {
        //         result(FlutterMethodNotImplemented)
        //     }
        // }
        return channel
    }
}

// MARK: - 👀
extension FlutterManager {
    static func reportError(error: FlutterrError,
                            call: FlutterMethodCall,
                            channelName: ChannelName,
                            entryPoint: EntryPoint) {
        var userInfo: [String: Any] = [
            "method": call.method,
            "channel": channelName.name,
            "entrypoint": entryPoint.value ?? "nil",
            "date": Date().string()
        ]
        if let arguments = call.arguments {
            userInfo["arguments"] = String(describing: call.arguments)
        }
        CrashlyticsManager.record(error: error, userInfo: userInfo)
    }
}
