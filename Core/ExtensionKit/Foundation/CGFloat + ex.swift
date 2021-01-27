//
//  CGFloat + ex.swift
//  LXToolKit
//
//  Created by LXThyme Jason on 2021/1/16.
//

import Foundation

// MARK: - 👀
public extension Swifty where Base == CGFloat {
    var toPi: CGFloat {
        return base / 180 * .pi
    }
}
