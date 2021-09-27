//
//  AppDelegate.swift
//  LXToolKit
//
//  Created by LX314 on 11/12/2019.
//  Copyright (c) 2019 LX314. All rights reserved.
//

import UIKit
import LXToolKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var notificationDelegate: SampleNotificationDelegate?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        configureNotification()
        LibraryManager.shared.setupLibs(with: window)
        return true
    }
    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        dlog("-->shouldRestoreApplicationState")
        return true
    }
    func application(_ application: UIApplication, shouldRestoreSecureApplicationState coder: NSCoder) -> Bool {
        dlog("-->shouldRestoreSecureApplicationState")
        return true
    }
    func application(_ application: UIApplication, didDecodeRestorableStateWith coder: NSCoder) {
        dlog("-->didDecodeRestorableStateWith")
    }
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        dlog("-->restorationHandler")
        return true
    }
    func application(_ application: UIApplication, viewControllerWithRestorationIdentifierPath identifierComponents: [String], coder: NSCoder) -> UIViewController? {
        dlog("-->viewControllerWithRestorationIdentifierPath")
        return UIViewController()
    }
    // MARK: 📌Save UI State
    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        dlog("shouldSaveApplicationState")
        return true
    }
    func application(_ application: UIApplication, shouldSaveSecureApplicationState coder: NSCoder) -> Bool {
        dlog("shouldSaveSecureApplicationState")
        return true
    }
    func application(_ application: UIApplication, willEncodeRestorableStateWith coder: NSCoder) {
        dlog("-->willEncodeRestorableStateWith")
    }
}
