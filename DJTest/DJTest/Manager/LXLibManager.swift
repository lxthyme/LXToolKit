//
//  LXLibManager.swift
//  DJTest
//
//  Created by lxthyme on 2023/10/31.
//

import Foundation
// import AMapFoundationKit
// import AMapLocationKit
// import AMapSearchKit
// import MAMapKit
import Firebase

class LXLibManager {
    static func setup() {
        LXLibManager.prepareAMap()
        LXLibManager.prepareFirebase()
    }
}

// MARK: - 👀
extension LXLibManager {
    /// Firebase 配置
    static func prepareFirebase() {
        FirebaseApp.configure()
    }
    /// 高德地图配置
    static func prepareAMap() {
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
