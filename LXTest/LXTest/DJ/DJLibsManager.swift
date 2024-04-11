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
    case firstMedicine
    case goodsDetail

    var title: String {
        var tmp = ""
        switch self {
        case .getMain: tmp = "指定进店"
        case .goodsDetail: tmp = "商详"
        case .firstMedicine: tmp = "第一医药"
        }
        return "👉\(tmp)"
    }
    static func from(_ title: String?) -> DJRouterPath? {
        guard let title else { return nil }
        switch title {
        case DJRouterPath.getMain.title:
            return DJRouterPath.getMain
        case DJRouterPath.firstMedicine.title:
            return DJRouterPath.firstMedicine;
        case DJRouterPath.goodsDetail.title:
            return DJRouterPath.goodsDetail;
        default: return nil
        }
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
