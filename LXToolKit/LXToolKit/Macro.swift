//
//  Macro.swift
//  Vaffle_demo
//
//  Created by DamonJow on 2018/10/26.
//  Copyright © 2018 DamonJow. All rights reserved.
//

import UIKit

// 是否是iPhone X系列
public let XL_IS_iPhoneX: Bool = (
    (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode))
        ? CGSize(width: 375, height: 812).equalTo(UIScreen.main.bounds.size)
        : false)
        || (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode))
            ? CGSize(width: 812, height: 375).equalTo(UIScreen.main.bounds.size)
            : false)
        || (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode))
            ? CGSize(width: 414, height: 896).equalTo(UIScreen.main.bounds.size)
            : false)
        || (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode))
            ? CGSize(width: 896, height: 414).equalTo(UIScreen.main.bounds.size)
            : false))

// 导航栏+状态栏高度
public let XL_NavBar_Height: CGFloat = XL_IS_iPhoneX ? 88.0 : 64.0

public struct Macro {
    public static let screen = UIScreen.main.bounds
    public static let screen_Width = Macro.screen.size.width
    public static let screen_Height = Macro.screen.size.height
}

public let kScreenHeight: CGFloat = UIScreen.main.bounds.size.height
public let kScreenWidth: CGFloat = UIScreen.main.bounds.size.width
