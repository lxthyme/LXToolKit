//
//  Int + ex.swift
//  LXToolKit
//
//  Created by LXThyme Jason on 2021/1/16.
//

import Foundation

// MARK: - 👀
public extension Swifty where Base == Int {
    init(xl_bool bool: Bool) {
        base = bool ? 1 : 0
    }
}
