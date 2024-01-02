//
//  Array + ex.swift
//  LXToolKit
//
//  Created by LXThyme Jason on 2021/1/16.
//

import Foundation

// public extension Swifty where Base: Array<Any>, Base.Element: Equatabledo {
//    typealias Element = Base.Element
// }

// MARK: - 👀
extension Array where Element: Equatable {
    func xl_removeDuplicate() -> Array {
        return self.enumerated().filter { (index, value) -> Bool in
            return self.firstIndex(of: value) == index
        }.map { (_, value) in
            return value
        }
    }
}

// MARK: - 👀
public extension Array {
    /// 检查一个索引值是否在数组边界内
    ///
    /// eg: array[guarded: 5] ?? 0
    ///
    /// - Parameter idx: idx
    subscript(xl_guarded idx: Int) -> Element? {
        guard (startIndex..<endIndex).contains(idx) else {
            return nil
        }
        return self[idx]
    }
}
