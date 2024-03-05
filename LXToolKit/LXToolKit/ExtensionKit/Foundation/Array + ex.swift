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
public extension Collection {
    /// SwifterSwift: Safe protects the array from out of bounds by use of optional.
    ///
    ///        let arr = [1, 2, 3, 4, 5]
    ///        arr[safe: 1] -> 2
    ///        arr[safe: 10] -> nil
    ///
    /// - Parameter index: index of element to access element.
    subscript(xl_safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
