//
//  UIView+ex.swift
//  test
//
//  Created by lxthyme on 2023/3/26.
//

import Foundation

extension UIView {
    func setPriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) {
        self.setContentHuggingPriority(priority, for: axis)
        self.setContentCompressionResistancePriority(priority, for: axis)
    }
}
