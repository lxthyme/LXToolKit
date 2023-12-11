//
//  CoverVerticalFromTopAnimation.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/12/10.
//

import Foundation

public class CoverVerticalFromTopAnimation: PresentrAnimation {

    override public func transform(containerFrame: CGRect, finalFrame: CGRect) -> CGRect {
        var initialFrame = finalFrame
        initialFrame.origin.y = 0 - initialFrame.size.height
        return initialFrame
    }

}
