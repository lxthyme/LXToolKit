//
//  Int + ex.swift
//  LXToolKit
//
//  Created by LXThyme Jason on 2021/1/16.
//

import Foundation

// MARK: - 👀
public extension Swifty where Base == Int {
    static func toInt(from bool: Bool) ->Int {
        return bool ? 1 : 0
    }
}
