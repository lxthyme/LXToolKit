//
//  BackgroundView.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/12/10.
//

import Foundation

class PassthroughView: UIView {
    var shouldPassthrough = true
    var passthroughViews: [UIView] = []
}

// MARK: - 👀
extension PassthroughView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var view = super.hitTest(point, with: event)

        if view == self && shouldPassthrough {
            for passthroughView in passthroughViews {
                view = passthroughView.hitTest(convert(point, to: passthroughView), with: event)
                if view != nil {
                    break
                }
            }
        }

        return view
    }
}
