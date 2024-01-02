//
//  UIView + findVC.swift
//  Vaffle_demo
//
//  Created by DamonJow on 2018/11/1.
//  Copyright © 2018 DamonJow. All rights reserved.
//
import UIKit
import Foundation

public extension Swifty where Base: UIView {
// public extension UIView {
    /// 通过view获取控制器
    func findVC() -> UIViewController? {
        var target: UIResponder? = base as UIResponder
        while target != nil {
            target = target?.next
            guard let _ = target else { break }
        }
        return target as? UIViewController
    }

    /// 获取当前控制器
    static func findVC() -> UIViewController? {
        guard let window = UIApplication.shared.windows.first else { return nil}

        var tempView: UIView?
        for subView in window.subviews {
            if subView.classForCoder.description() == "UILayoutContainerView" {
                tempView = subView
                break
            }
        }

        if tempView == nil {
            tempView = window.subviews.last
        }

        var nextResponder = tempView?.next

        while let nr = nextResponder, !nr.isKind(of: UIViewController.self) || nr.isKind(of: UINavigationController.self) || nr.isKind(of: UITabBarController.self) {
            tempView = tempView?.subviews.first

            guard let _ = tempView else { return nil }

            nextResponder = tempView?.next
        }
        return nextResponder as? UIViewController
    }
}
