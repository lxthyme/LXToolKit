//
//  LibraryManager.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/25.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Toast_Swift
import IQKeyboardManagerSwift
import KafkaRefresh
import NVActivityIndicatorView
import Kingfisher
import CocoaLumberjack
import FLEX
import Firebase
import FirebaseAnalytics
import Mixpanel

class LibraryManager {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    static let shared = LibraryManager()
    private init() {}

}

// MARK: 👀Public Actions
extension LibraryManager {
    func setupLibs(with window: UIWindow? = nil) {
        setupCocoaLumberjack()
//        setupAnalytics()
//        setupAds()
//        setupTheme()
        setupKafkaRefresh()
        setupFLEX()
        setupKeyboardManager()
        setupActivityView()
//        setupDropDown()
        setupToast()
    }
}

// MARK: 🔐Private Actions
private extension LibraryManager {
    func setupCocoaLumberjack() {
        DDLog.add(DDOSLogger.sharedInstance)
        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = TimeInterval(60*60*24)  // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        
        DDLog.add(fileLogger)
    }
    func setupToast() {
        ToastManager.shared.isTapToDismissEnabled = true
        ToastManager.shared.position = .top
        var style = ToastStyle()
        style.backgroundColor = UIColor.Material.red
        style.messageColor = UIColor.Material.white
        style.imageSize = CGSize(width: 20, height: 20)
        ToastManager.shared.style = style
    }
    func setupKafkaRefresh() {
        if let defaults = KafkaRefreshDefaults.standard() {
            defaults.headDefaultStyle = .replicatorAllen
            defaults.footDefaultStyle = .replicatorDot
        }
    }

    func setupActivityView() {
        NVActivityIndicatorView.DEFAULT_TYPE = .ballRotateChase
//        NVActivityIndicatorView.DEFAULT_COLOR = .secondary()
    }

    func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
    }
    func setupKingfisher() {
        // Set maximum disk cache size for default cache. Default value is 0, which means no limit.
        ImageCache.default.diskStorage.config.sizeLimit = UInt(500 * 1024 * 1024) // 500 MB

        // Set longest time duration of the cache being stored in disk. Default value is 1 week
        ImageCache.default.diskStorage.config.expiration = .days(7) // 1 week

        // Set timeout duration for default image downloader. Default value is 15 sec.
        ImageDownloader.default.downloadTimeout = 15.0 // 15 sec
    }
    func setupFLEX() {
        #if DEBUG
        FLEXManager.shared.isNetworkDebuggingEnabled = true
        #endif
    }

    func setupAnalytics() {
        FirebaseApp.configure()
//        Mixpanel.initialize(token: Keys.mixpanel.apiKey)
        FirebaseConfiguration.shared.setLoggerLevel(.min)
    }
}
