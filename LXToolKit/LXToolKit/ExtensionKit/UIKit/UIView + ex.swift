//
//  UIView + ex.swift
//  Vaffle_demo
//
//  Created by LXThyme on 2018/11/19.
//  Copyright © 2018 DamonJow. All rights reserved.
//
import UIKit
import Foundation

//public extension TypeWrapperProtocol where WrappedType == UIView {
public extension Swifty where Base: UIView {
    var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return self.base.safeAreaInsets
        } else {
            return .zero
        }
    }
    var safeAreaLayoutGuide: UILayoutGuide {
        if #available(iOS 11.0, *) {
            return self.base.safeAreaLayoutGuide
        } else {
            return UILayoutGuide()
        }
    }

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(self.base.addSubview)
    }
}

