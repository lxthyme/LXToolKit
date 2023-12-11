//
//  PresentrShadow.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/12/10.
//

import Foundation

struct PresentrShadow {
    public let shadowColor: UIColor?

    public let shadowOpacity: Float?

    public let shadowOffset: CGSize?

    public let shadowRadius: CGFloat?

    public init(shadowColor: UIColor?, shadowOpacity: Float?, shadowOffset: CGSize?, shadowRadius: CGFloat?) {
        self.shadowColor = shadowColor
        self.shadowOpacity = shadowOpacity
        self.shadowOffset = shadowOffset
        self.shadowRadius = shadowRadius
    }
}
