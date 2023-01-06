//
//  AppDelegate.swift
//  LXToolKit
//
//  Created by LX314 on 11/12/2019.
//  Copyright (c) 2019 LX314. All rights reserved.
//

import UIKit
import Toast_Swift
import LXToolKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var notificationDelegate: SampleNotificationDelegate?
    static var shared: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        window?.bounds = UIScreen.main.bounds
        window?.backgroundColor = UIColor.white

        let vc = LXViewController()
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = nav

        let libsManager = LibsManager.shared
        libsManager.setupLibs(with: window)

        if Configs.Network.useStaging == true {
            // Logout
            User.removeCurrentUser()
            AuthManager.removeToken()

            // Use Green Dark theme
            var theme = ThemeType.currentTheme()
            if theme.isDark != true {
                theme = theme.toggled()
            }
            theme = theme.withColor(color: .green)
            themeService.switch(theme)

            // Disable banners
            libsManager.bannersEnabled.accept(false)
        } else {
            connectedToInternet().skip(1).subscribe(onNext: { [weak self] (connected) in
                var style = ToastManager.shared.style
                style.backgroundColor = connected ? UIColor.Material.green: UIColor.Material.red
                let message = connected ? R.string.localizable.toastConnectionBackMessage(): R.string.localizable.toastConnectionLostMessage()
                let image = connected ? R.image.icon_toast_success(): R.image.icon_toast_warning()
                if let view = self?.window?.rootViewController?.view {
                    view.makeToast(message, position: .bottom, image: image, style: style)
                }
            }).disposed(by: rx.disposeBag)
        }

        // Show initial screen
        Application.shared.presentInitialScreen(in: window!)

        // configureNotification()

        window?.makeKeyAndVisible()
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
