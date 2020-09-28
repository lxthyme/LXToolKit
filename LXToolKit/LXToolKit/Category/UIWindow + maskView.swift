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
extension UIWindow {
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
        bgView.backgroundColor = UIColor(hex: "#000")
        bgView.layer.opacity = 0.5
        return bgView
    }
}
