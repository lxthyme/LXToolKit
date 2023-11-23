//
//  UIWindow + maskView.swift
//  Vape-Ex
//
//  Created by LXThyme Jason on 2020/9/17.
//  Copyright © 2020 LXThyme. All rights reserved.
//

import Foundation

private let kMaskView_Tag = 1233212334

// MARK: - 👀common maskView
public extension Swifty where Base: UIWindow {
    static func getCurrentMaskView() ->UIView? {
        return UIApplication
            .shared
            .keyWindow?
            .viewWithTag(kMaskView_Tag)
    }
    static func maskView() ->UIView {
        var bgView: UIView
        if let tmp = getCurrentMaskView() {
            bgView = tmp
        } else {
            bgView = UIView()
            bgView.tag = kMaskView_Tag
        }
        bgView.frame = UIScreen.main.bounds
        bgView.backgroundColor = UIColor.XL.hex("#000")
        bgView.layer.opacity = 0.5
        return bgView
    }
}

// MARK: - 👀
public extension Swifty where Base: UIWindow {
    /// Returns the currently visible view controller if any reachable within the window.
    var visibleViewController: UIViewController? {
        return Base.XL.visibleViewController(from: base.rootViewController)
    }

    /// Recursively follows navigation controllers, tab bar controllers and modal presented view controllers starting
    /// from the given view controller to find the currently visible view controller.
    ///
    /// - Parameters:
    ///   - viewController: The view controller to start the recursive search from.
    /// - Returns: The view controller that is most probably visible on screen right now.
    static func visibleViewController(from viewController: UIViewController?) -> UIViewController? {
        switch viewController {
            /// 根视图为UINavigationController
        case let navigationController as UINavigationController:
            return Base.XL.visibleViewController(from: navigationController.visibleViewController ?? navigationController.topViewController)
            /// 根视图为UITabBarController
        case let tabBarController as UITabBarController:
            return Base.XL.visibleViewController(from: tabBarController.selectedViewController)
            /// 视图是被presented出来的
        case let presentingViewController where viewController?.presentedViewController != nil:
            return Base.XL.visibleViewController(from: presentingViewController?.presentedViewController)

        default:
            /// 根视图为非导航类
            return viewController
        }
    }
}
