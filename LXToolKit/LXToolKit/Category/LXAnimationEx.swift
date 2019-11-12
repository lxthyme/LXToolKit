//
//  LXAnimationEx.swift
//  Vaffle_demo
//
//  Created by LXThyme on 2018/11/16.
//  Copyright © 2018 DamonJow. All rights reserved.
//
import UIKit
import Foundation

public extension UIView {
    func dismissAnimation(duration: CFTimeInterval = 0.2) {
        self.opacityAnimation(from: 1, to: 0, duration: duration)
        self.scaleAnimation(from: 1, to: 0, duration: duration)
    }
    func showAnimation(duration: CFTimeInterval = 0.2) {
        self.opacityAnimation(from: 0, to: 1, duration: duration)
        self.scaleAnimation(from: 0, to: 1, duration: duration)
    }
    func opacityAnimation(from: Float, to: Float,duration: CFTimeInterval = 0.2, key: String = "key.opacity") {
        let anim = CABasicAnimation(keyPath: "opacity")
        anim.fromValue = from
        anim.toValue = to
        anim.duration = duration
        anim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.layer.add(anim, forKey: key)
    }
    func scaleAnimation(from: Float, to: Float,duration: CFTimeInterval = 0.2, key: String = "key.transform.scale") {
        let anim = CABasicAnimation(keyPath: "transform.scale")
        anim.fromValue = from
        anim.toValue = to
        anim.duration = duration
        anim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.layer.add(anim, forKey: key)
    }
}
