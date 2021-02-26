//
//  UIStackView + customSpacing.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/23.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

public extension Swifty where Base: UIStackView {
    // How can I create UIStackView with variable spacing between views?
    func addCustomSpacing(_ spacing: CGFloat, after arrangedSubview: UIView) {
        if #available(iOS 11.0, *) {
            self.base.setCustomSpacing(spacing, after: arrangedSubview)
        } else {
            let separatorView = UIView(frame: .zero)
            separatorView.translatesAutoresizingMaskIntoConstraints = false
            switch base.axis {
                case .horizontal:
                    separatorView.widthAnchor.constraint(equalToConstant: spacing).isActive = true
                case .vertical:
                    separatorView.heightAnchor.constraint(equalToConstant: spacing).isActive = true
                @unknown default:
                    fatalError()
            }
            if let index = self.base.arrangedSubviews.firstIndex(of: arrangedSubview) {
                base.insertArrangedSubview(separatorView, at: index + 1)
            }
        }
    }
}
