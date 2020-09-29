//
//  AppDelegate.swift
//  LXToolKit
//
//  Created by LX314 on 11/12/2019.
//  Copyright (c) 2019 LX314. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let notificationDelegate = SampleNotificationDelegate()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
//            granted, error in
//            if granted {
//                // 用户允许进行通知
//            }
//        }
//        configureNotification()
        window = UIWindow()
        window?.bounds = UIScreen.main.bounds
        window?.backgroundColor = UIColor.white

        let vc = ViewController()
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = nav

        configureNotification2()

        window?.makeKeyAndVisible()
        return true
    }
}

// MARK: - 👀
extension AppDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//            let str = deviceToken.map { String(format: "%02hhx", $0) }.joined()
        let str = deviceToken.hexString
        print("current deviceToken = \(str)")
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("error: ", error)
    }
    func configureNotification() {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
        }
        if #available(iOS 11.0, *) {
            let openAction = UNNotificationAction(identifier: "OpenNotification", title: "OpenNotification-title", options: .foreground)
            let defaultCategory = UNNotificationCategory(identifier: "CustomSamplePush", actions: [openAction], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "CategoryIdentifier-placeholder", options: [])
            UNUserNotificationCenter.current().setNotificationCategories(Set([defaultCategory]))
        } else {
            // Fallback on earlier versions
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
    func configureNotification2() {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
            center.delegate = notificationDelegate
            let openAction = UNNotificationAction(identifier: "OpenNotification", title: NSLocalizedString("Abrir", comment: ""), options: UNNotificationActionOptions.foreground)
            let deafultCategory = UNNotificationCategory(identifier: "CustomSamplePush", actions: [openAction], intentIdentifiers: [], options: [])
            center.setNotificationCategories(Set([deafultCategory]))
        } else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
}
