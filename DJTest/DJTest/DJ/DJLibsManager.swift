//
//  LibsManager.swift
//  DaoJia_Example
//
//  Created by lxthyme on 2024/1/8.
//  Copyright © 2024 CocoaPods. All rights reserved.
//
import UIKit
// import AvoidCrash
// import SensorsAnalyticsSDK
// import AMapFoundationKit
// import AMapSearchKit
// import AMapLocationKit
// import MAMapKit

enum DJRouterPath {
    case getMain

    var title: String {
        var tmp = ""
        switch self {
        case .getMain: tmp = "指定进店"
        }
        return "👉\(tmp)"
    }
}

class DJLibsManager: NSObject {
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    static let shared = DJLibsManager()
}

// MARK: 👀Public Actions
extension DJLibsManager {
    func registerApp(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        // DJRouter.registerApp(launchOptions)
        // AvoidCrash.becomeEffective()
        // 
        // let sensorUrl = "https://sensorsdata.bl.com/sa?project=default"
        // let options = SAConfigOptions(serverURL: sensorUrl, launchOptions: launchOptions)
        // options.autoTrackEventType = [.eventTypeAppStart, .eventTypeAppEnd, .eventTypeAppViewScreen, .eventTypeAppClick]
        // SensorsAnalyticsSDK.start(configOptions: options)
        // 
        // AMapServices.shared().enableHTTPS = true // 开启 HTTPS 功能
        // AMapServices.shared().apiKey = "e20b8e6e9aec8627532584e762ddd71e"
        // AMapLocationManager.updatePrivacyAgree(.didAgree)
        // AMapLocationManager.updatePrivacyShow(.didShow, privacyInfo: .didContain)
        // MAMapView.updatePrivacyShow(.didShow, privacyInfo: .didContain)
        // MAMapView.updatePrivacyAgree(.didAgree)
        // AMapSearchAPI.updatePrivacyShow(.didShow, privacyInfo: .didContain)
        // AMapSearchAPI.updatePrivacyAgree(.didAgree)
    }
}

// MARK: 🔐Private Actions
private extension DJLibsManager {}

enum DJEnv: String {
    case sit = "sit"
    case prd = "prd"
    case gray = "gray"
}

// MARK: - 👀
extension DJEnv {
    static func getCurrentEnv() -> DJEnv {
        let env = DJRouterObjc.getCurrentEnv()
        switch env {
        case .develop: return .sit
        case .preRelease: return .gray
        case .release, .notSetted: return .prd
        @unknown default:
            return .prd
        }
    }
}
