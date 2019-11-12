//
//  LXUIViewEx.swift
//  Vaffle_demo
//
//  Created by LXThyme on 2018/11/19.
//  Copyright © 2018 DamonJow. All rights reserved.
//
import UIKit
import Foundation

public extension UIView {
    var xl_safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return self.safeAreaInsets
        } else {
            return .zero
        }
    }
    var xl_safeAreaLayoutGuide: UILayoutGuide {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide
        } else {
            return UILayoutGuide()
        }
    }
}
