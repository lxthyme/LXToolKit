//
//  iPhoneX.swift
//  LXToolKit
//
//  Created by lxthyme on 2021/10/25.
//

import Foundation

public struct iPhoneX {
    public var isIphoneX: Bool {
        guard #available(iOS 11.0, *) else {
            return false
        }
        return UIApplication.XL.keyWindow?.safeAreaInsets != UIEdgeInsets.zero
    }
    public var safeareaInsets: UIEdgeInsets {
        guard #available(iOS 11.0, *) else {
            return .zero
        }
        return UIApplication.XL.keyWindow?.safeAreaInsets ?? .zero
    }
}
