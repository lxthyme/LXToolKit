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
