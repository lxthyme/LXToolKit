//
//  LXLibManager.swift
//  LXTest
//
//  Created by lxthyme on 2023/10/31.
//

import Foundation
import LXToolKit_Example
// import AMapFoundationKit
// import AMapLocationKit
// import AMapSearchKit
// import MAMapKit
// import Firebase
import Toast_Swift
import IQKeyboardManagerSwift

class LXLibManager {
    static func setupLibs() {
        LibsManager.shared.setupLibs()
        // setupAMap()
        // setupBugly()
        // setupUMeng()
        // setupTingYun()
        setupIQKeyboardManager()
    }
}

// MARK: - 👀
private extension LXLibManager {
    // static func setupTingYun() {
    //     NBSAppAgent.start(withAppID: AppConfig.TingYun.AppKey)
    // }
    static func setupIQKeyboardManager() {
        // IQKeyboardManager.shared.enable = true
    }
    static func setupUMeng() {
        // UMLaunch.setRootVCCls(ViewController.self)
        // let config = UMAPMConfig.default()
        // UMConfigure.setLogEnabled(true)
        // UMCrashConfigure.setAPMConfig(config)
        // UMConfigure.initWithAppkey("655eb7c158a9eb5b0a0ef8b9", channel: "iOS")
        // URLProtocol.registerClass(UMURLProtocol)
    }
    static func setupBugly() {
        // Bugly.start(withAppId: "6c86961c5c")
        // Bugly.start(withAppId: <#T##String?#>, developmentDevice: <#T##Bool#>, config: <#T##BuglyConfig?#>)
    }
    /// 高德地图配置
    static func setupAMap() {
        // let mapService = AMapServices.shared()
        // /// com.bailian.ibl
        // mapService?.apiKey = "e20b8e6e9aec8627532584e762ddd71e"
        // /// com.blo2o.ibl
        // mapService?.apiKey = "d400c8229a07afd3a1ae6165c504712d"
        // mapService?.enableHTTPS = true
        // AMapLocationManager.updatePrivacyShow(.didShow, privacyInfo: .didContain)
        // AMapLocationManager.updatePrivacyAgree(.didAgree)
        // MAMapView.updatePrivacyShow(.didShow, privacyInfo: .didContain)
        // MAMapView.updatePrivacyAgree(.didAgree)
        // AMapSearchAPI.updatePrivacyShow(.didShow, privacyInfo: .didContain)
        // AMapSearchAPI.updatePrivacyAgree(.didAgree)
    }
}
