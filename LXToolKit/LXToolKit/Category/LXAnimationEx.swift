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
    func dismissAnimation(duration: CFTimeInterval = 0.2, timingFunction: CAMediaTimingFunctionName = .easeInEaseOut, key: String = "key.dismissAnimation") {
        self.opacityAnimation(from: 1, to: 0, duration: duration, timingFunction: timingFunction, key: key)
        self.scaleAnimation(from: 1, to: 0, duration: duration, timingFunction: timingFunction, key: key)
    }
    func showAnimation(duration: CFTimeInterval = 0.2, timingFunction: CAMediaTimingFunctionName = .easeInEaseOut, key: String = "key.showAnimation") {
        self.opacityAnimation(from: 0, to: 1, duration: duration, timingFunction: timingFunction, key: key)
        self.scaleAnimation(from: 0, to: 1, duration: duration, timingFunction: timingFunction, key: key)
    }
    func flipFromBottomAnimation(from: Float, to: Float, duration: CFTimeInterval = 0.2, timingFunction: CAMediaTimingFunctionName = .easeInEaseOut, key: String = "key.flipFromBottomAnimation") {
        let anim = CABasicAnimation(keyPath: "position.y")
        anim.fromValue = from
        anim.toValue = to
        anim.duration = duration
//        anim.fillMode = .forwards
//        anim.isRemovedOnCompletion = false
        anim.timingFunction = CAMediaTimingFunction(name: timingFunction)
        self.layer.add(anim, forKey: key)
    }
    func opacityAnimation(from: Float, to: Float, duration: CFTimeInterval = 0.2, timingFunction: CAMediaTimingFunctionName = .easeInEaseOut, key: String = "key.opacity") {
        let anim = CABasicAnimation(keyPath: "opacity")
        anim.fromValue = from
        anim.toValue = to
        anim.duration = duration
//        anim.fillMode = .forwards
//        anim.isRemovedOnCompletion = true
        anim.timingFunction = CAMediaTimingFunction(name: timingFunction)
        self.layer.add(anim, forKey: key)
    }
    func scaleAnimation(from: Float, to: Float, duration: CFTimeInterval = 0.2, timingFunction: CAMediaTimingFunctionName = .easeInEaseOut, key: String = "key.transform.scale") {
        let anim = CABasicAnimation(keyPath: "transform.scale")
        anim.fromValue = from
        anim.toValue = to
        anim.duration = duration
        anim.fillMode = .forwards
        anim.isRemovedOnCompletion = false
        anim.timingFunction = CAMediaTimingFunction(name: timingFunction)
        self.layer.add(anim, forKey: key)
    }
}
