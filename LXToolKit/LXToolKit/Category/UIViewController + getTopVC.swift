//
//  UIViewController + getTopVC.swift
//  Alamofire
//
//  Created by LXThyme Jason on 2020/9/7.
//

import Foundation


// MARK: - <#Title...#>
public extension UIViewController {
    func getCurrentVC() ->UIViewController? {
        let rootVC = UIApplication.shared.keyWindow?.rootViewController
        return getCurrentVCFrom(rootVC: rootVC)
    }
    func getCurrentVCFrom(rootVC rootVC_t: UIViewController?) ->UIViewController? {
        guard let rootVC = rootVC_t else { return nil }

        var currentVC: UIViewController?
        if let presentedVC = rootVC.presentedViewController {
            // 视图是被presented出来的
            currentVC = presentedVC
        }
        if let tabbarVC = rootVC as? UITabBarController {
            // 根视图为UITabBarController
            currentVC = getCurrentVCFrom(rootVC: tabbarVC.selectedViewController)
        } else if let navVC = rootVC as? UINavigationController {
            // 根视图为UINavigationController
            currentVC = getCurrentVCFrom(rootVC: navVC.visibleViewController)
        } else {
            // 根视图为非导航类
            currentVC = rootVC
        }

        return currentVC
    }
}
