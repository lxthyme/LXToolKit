//
//  UIView + animation.swift
//  Vaffle_demo
//
//  Created by LXThyme on 2018/11/16.
//  Copyright © 2018 DamonJow. All rights reserved.
//
import UIKit
import Foundation

// MARK: - 👀显式动画
public extension Swifty where Base: UIView {
    func dismissAnimation(duration: CFTimeInterval = 0.2, timingFunction: CAMediaTimingFunctionName = .easeInEaseOut, key: String = "key.dismissAnimation") {
        self.opacityAnimation(from: 1, to: 0, duration: duration, timingFunction: timingFunction, key: key)
        self.scaleAnimation(from: 1, to: 0, duration: duration, timingFunction: timingFunction, key: key)
    }
    func showAnimation(duration: CFTimeInterval = 0.2, timingFunction: CAMediaTimingFunctionName = .easeInEaseOut, key: String = "key.showAnimation") {
        self.opacityAnimation(from: 0, to: 1, duration: duration, timingFunction: timingFunction, key: key)
        self.scaleAnimation(from: 0, to: 1, duration: duration, timingFunction: timingFunction, key: key)
    }
    func flipFromBottomAnimation(from: Float, to: Float, duration: CFTimeInterval = 0.2, timingFunction: CAMediaTimingFunctionName = .easeInEaseOut, key: String = "key.flipFromBottomAnimation") {
        if let tmp = base.layer.animation(forKey: key) {
            base.layer.removeAnimation(forKey: key)
        }
        let anim = CABasicAnimation(keyPath: "position.y")
        anim.fromValue = from
        anim.toValue = to
        anim.duration = duration
//        anim.fillMode = .forwards
//        anim.isRemovedOnCompletion = false
        anim.timingFunction = CAMediaTimingFunction(name: timingFunction)
        base.layer.add(anim, forKey: key)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration + 0.1) {
            base.layer.removeAnimation(forKey: key)
        }
    }
    func opacityAnimation(from: Float, to: Float, duration: CFTimeInterval = 0.2, timingFunction: CAMediaTimingFunctionName = .easeInEaseOut, key: String = "key.opacity") {
        if let tmp = base.layer.animation(forKey: key) {
            base.layer.removeAnimation(forKey: key)
        }
        let anim = CABasicAnimation(keyPath: "opacity")
        anim.fromValue = from
        anim.toValue = to
        anim.duration = duration
//        anim.fillMode = .forwards
//        anim.isRemovedOnCompletion = true
        anim.timingFunction = CAMediaTimingFunction(name: timingFunction)
        base.layer.add(anim, forKey: key)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration + 0.1) {
            base.layer.removeAnimation(forKey: key)
        }
    }
    func scaleAnimation(from: Float, to: Float, duration: CFTimeInterval = 0.2, timingFunction: CAMediaTimingFunctionName = .easeInEaseOut, key: String = "key.transform.scale") {
        if let tmp = base.layer.animation(forKey: key) {
            base.layer.removeAnimation(forKey: key)
        }
        let anim = CABasicAnimation(keyPath: "transform.scale")
        anim.fromValue = from
        anim.toValue = to
        anim.duration = duration
        anim.fillMode = .forwards
        anim.isRemovedOnCompletion = false
        anim.timingFunction = CAMediaTimingFunction(name: timingFunction)
        base.layer.add(anim, forKey: key)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration + 0.1) {
            base.layer.removeAnimation(forKey: key)
        }
    }
    /// 旋转
    /// - Parameters:
    ///   - angle: 旋转角度
    ///   - duration: 动画时长
    ///   - timingFunction: <#timingFunction description#>
    ///   - key: <#key description#>
    func rotationAnimation(angle: CGFloat, duration: TimeInterval = 0.25, timingFunction: CAMediaTimingFunctionName = .easeInEaseOut, key: String = "transform.rotation.z") {
        if let tmp = base.layer.animation(forKey: key) {
            base.layer.removeAnimation(forKey: key)
        }
        let anim = CABasicAnimation(keyPath: "transform.rotation.z")
        anim.toValue = angle
        anim.duration = duration
        anim.isCumulative = true
        anim.repeatCount = 1
        anim.timingFunction = CAMediaTimingFunction(name: timingFunction)
        base.layer.add(anim, forKey: key)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration + 0.1) {
            base.layer.removeAnimation(forKey: key)
        }
    }
}
