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

open class FlutterManager {
    // MARK: 🔗Vaiables
    static let shared = FlutterManager()
    public static let channelName = "com.lx.flutter_cookbook"
    lazy var flutterEngine = FlutterEngine(name: "flutter_cookbook")
    lazy var flutterEngineGroup = FlutterEngineGroup(name: "", project: nil)
    // MARK: 🛠Life Cycle
    private init() {}
}

// MARK: - 👀
extension FlutterManager {
    public func register() {
        flutterEngine.run()
        GeneratedPluginRegistrant.register(with: flutterEngine)

        registerRouter()
    }
    public func registerFromGroup(withEntryPoint entryPoint: String?) -> FlutterEngine {
        let newEngine = flutterEngineGroup.makeEngine(withEntrypoint: entryPoint, libraryURI: nil)
        GeneratedPluginRegistrant.register(with: newEngine)
        return newEngine
    }
}
// MARK: - 🔐
private extension FlutterManager {
    func registerRouter() {
        let channel = FlutterMethodChannel(name: FlutterManager.channelName, binaryMessenger: flutterEngine.binaryMessenger)
        channel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
            dlog("-->[Flutter]call: \(call.method)-\(call.arguments)")
            if call.method == "flutter_dismiss" {
                UIViewController.top().dismiss(animated: true)
                result(true)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
    }
}
