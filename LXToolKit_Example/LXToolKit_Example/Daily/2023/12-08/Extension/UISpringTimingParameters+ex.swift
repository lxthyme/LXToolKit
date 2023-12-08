//
//  UISpringTimingParameters+ex.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/12/8.
//

import Foundation

extension UISpringTimingParameters {
    public convenience init(decelerationRate: CGFloat, frequencyResponse: CGFloat, initialVelocity: CGVector = .zero) {
        let dampingRatio = CoreGraphics.log(decelerationRate) / (-4 * .pi * 0.001)
        self.init(dampingRatio: dampingRatio, frequencyResponse: frequencyResponse, initialVelocity: initialVelocity)
    }

    public convenience init(dampingRatio: CGFloat, frequencyResponse: CGFloat, initialVelocity: CGVector = .zero) {
        let mass = 1 as CGFloat
        let stiffness = pow(2 * .pi / frequencyResponse, 2) * mass
        let damp = 4 * .pi * dampingRatio * mass / frequencyResponse
        self.init(mass: mass, stiffness: stiffness, damping: damp, initialVelocity: initialVelocity)
    }
}
