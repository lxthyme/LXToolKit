//
//  ToolKit.swift
//  SwiftPro
//
//  Created by DamonJow on 2018/10/15.
//  Copyright © 2018 DamonJow. All rights reserved.
//

import UIKit

//let dlog = print

/// remove switch case warning temporary
///
/// - Returns: Never
public func unimplemented() -> Never {
    fatalError("TODO")
}

public extension Array {

    /// 检查一个索引值是否在数组边界内
    ///
    /// eg: array[guarded: 5] ?? 0
    ///
    /// - Parameter idx: idx
    subscript(guarded idx: Int) -> Element? {
        guard (startIndex..<endIndex).contains(idx) else {
            return nil
        }
        return self[idx]
    }
}
