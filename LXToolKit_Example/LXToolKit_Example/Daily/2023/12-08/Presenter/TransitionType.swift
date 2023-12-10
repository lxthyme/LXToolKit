//
//  TransitionType.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/12/10.
//

import Foundation

enum TransitionType {
    case crossDissolve, 
         coverVertical, coverVerticalFromTop,
    coverHorizontalFromRight, coverHorizontalFromLeft,
    flipHorizontal, coverFromCorner(Corner),
    custom(PresentrAnimation)

    func animation() -> PresentrAnimation {
        switch self {
        case .crossDissolve:
            return CrossDissolveAnimation()
        case .coverVertical:
            return CoverVerticalAnimation()
        case .coverVerticalFromTop:
            return CoverVerticalFromTopAnimation()
        case .coverHorizontalFromRight:
            return CoverHorizontalAnimation(fromRight: true)
        case .coverHorizontalFromLeft:
            return CoverHorizontalAnimation(fromRight: false)
        case .flipHorizontal:
            return FlipHorizontalAnimation()
        case .coverFromCorner(let corner):
            return CoverFromCornerAnimation(corner: corner)
        case .custom(let presentrAnimation):
            return presentrAnimation
        }
    }
}

// MARK: - ✈️Equatable
extension TransitionType: Equatable {}

// MARK: - ✈️CustomStringConvertible
extension TransitionType: CustomStringConvertible {
    var description: String {
        switch self {
        case .crossDissolve:
            return ".crossDissolve"
        case .coverVertical:
            return ".coverVertical"
        case .coverVerticalFromTop:
            return ".coverVerticalFromTop"
        case .coverHorizontalFromRight:
            return ".coverHorizontalFromRight"
        case .coverHorizontalFromLeft:
            return ".coverHorizontalFromLeft"
        case .flipHorizontal:
            return ".flipHorizontal"
        case .coverFromCorner(let corner):
            return ".coverFromCorner(\(corner))"
        case .custom(let presentrAnimation):
            return ".custom(\(presentrAnimation))"
        }
    }
}
