//
//  Dictionary + ex.swift
//  LXToolKit
//
//  Created by lxthyme on 2024/3/4.
//

import Foundation

public extension Dictionary {
    subscript(key: Key, default defaultValue: @autoclosure () -> Value) -> Value {
        guard self.keys.contains(key) else { return defaultValue() }
        guard let v = self[key] else { return defaultValue() }
        return v
    }
}
