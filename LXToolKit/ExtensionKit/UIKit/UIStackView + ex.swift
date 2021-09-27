//
//  UIStackView + ex.swift
//  LXToolKit
//
//  Created by LXThyme Jason on 2021/1/9.
//

import Foundation

// MARK: - 👀
public extension Swifty where Base: UIStackView {
    func addArrangedSubviews(_ subviews: UIView...) {
        subviews.forEach(self.base.addArrangedSubview)
    }
}
