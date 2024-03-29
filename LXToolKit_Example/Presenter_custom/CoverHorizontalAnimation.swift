//
//  CoverHorizontalAnimation.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/12/10.
//

import Foundation

public class CoverHorizontalAnimation: PresentrAnimation {

    private var fromRight: Bool

    public init(fromRight: Bool = true) {
        self.fromRight = fromRight
    }

    override public func transform(containerFrame: CGRect, finalFrame: CGRect) -> CGRect {
        var initialFrame = finalFrame
        if fromRight {
            initialFrame.origin.x = containerFrame.size.width + initialFrame.size.width
        } else {
            initialFrame.origin.x = 0 - initialFrame.size.width
        }
        return initialFrame
    }

}
