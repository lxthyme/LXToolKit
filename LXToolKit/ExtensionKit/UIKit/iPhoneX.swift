//
//  iPhoneX.swift
//  LXToolKit
//
//  Created by lxthyme on 2021/10/25.
//

import Foundation

struct iPhoneX {
    var isIphoneX: Bool {
        guard #available(iOS 11.0, *) else {
            return false
        }
        return UIApplication.shared.keyWindow?.safeAreaInsets != UIEdgeInsets.zero
    }
    var safeareaInsets: UIEdgeInsets {
        guard #available(iOS 11.0, *) else {
            return .zero
        }
        return UIApplication.shared.keyWindow?.safeAreaInsets ?? .zero
    }
}
