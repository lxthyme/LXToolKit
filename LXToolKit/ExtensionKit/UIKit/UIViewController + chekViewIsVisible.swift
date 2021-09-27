//
//  UIViewController + checkViewIsVisible.swift
//  Alamofire
//
//  Created by LXThyme Jason on 2020/8/10.
//

import Foundation

// MARK: - 👀检测 ViewController 是否可见
public extension Swifty where Base: UIViewController {
    /// 检测 ViewController 是否可见
    /// - Returns: boolean
    func checkViewIsVisible() ->Bool {
        if #available(iOS 7, *) {
            return base.isViewLoaded && base.view.window != nil
        } else {
            return base.viewIfLoaded?.window != nil
        }
    }
}
