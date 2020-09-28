//
//  UIStackView + customSpacing.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/23.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

extension UIStackView {
    // How can I create UIStackView with variable spacing between views?
    func x_addCustomSpacing(_ spacing: CGFloat, after arrangedSubview: UIView) {
        if #available(iOS 11.0, *) {
            self.setCustomSpacing(spacing, after: arrangedSubview)
        } else {
            let separatorView = UIView(frame: .zero)
            separatorView.translatesAutoresizingMaskIntoConstraints = false
            switch axis {
                case .horizontal:
                    separatorView.widthAnchor.constraint(equalToConstant: spacing).isActive = true
                case .vertical:
                    separatorView.heightAnchor.constraint(equalToConstant: spacing).isActive = true
                @unknown default:
                    fatalError()
            }
            if let index = self.arrangedSubviews.firstIndex(of: arrangedSubview) {
                insertArrangedSubview(separatorView, at: index + 1)
            }
        }
    }
}
