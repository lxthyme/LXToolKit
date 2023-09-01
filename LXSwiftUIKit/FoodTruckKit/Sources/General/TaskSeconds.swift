//
//  File.swift
//  
//
//  Created by lxthyme on 2023/9/1.
//

import Foundation

// MARK: - 👀
public extension UInt64 {
    static func secondsToNanoseconds(_ seconds: Double) -> UInt64 {
        UInt64(seconds * 1_000_000_000)
    }
}
