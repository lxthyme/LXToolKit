//
//  NSObject + ex.swift
//  LXToolKit
//
//  Created by LXThyme Jason on 2019/11/12.
//  Copyright © 2019 LXThyme Jason. All rights reserved.
//

import Foundation

// MARK: - 👀
public extension Swifty where Base: NSProxy {
    // Instance Level
    var xl_typeName: String {
        let type_t = type(of: self)
        return String(describing: type_t)
    }
    // Type Level
    static var xl_typeName: String {
        return String(describing: self)
    }

    /// The class's identifier, for UITableView，UICollectionView register its cell
    static var xl_identifier: String {
        return String(format: "%@_identifier", self.xl_typeName)
    }
}
// MARK: - 👀
public extension Swifty where Base: NSObject {
    // Instance Level
    var xl_typeName: String {
        let type_t = type(of: self)
        return String(describing: type_t)
    }
    // Type Level
    static var xl_typeName: String {
        return String(describing: self)
    }

    /// The class's identifier, for UITableView，UICollectionView register its cell
    static var xl_identifier: String {
        return String(format: "%@_identifier", self.xl_typeName)
    }

}

// MARK: - 👀
public extension Swifty where Base: NSObject {
    func getAssociatedObject<T>(_ object: Any, _ key: UnsafeRawPointer) -> T? {
        return objc_getAssociatedObject(object, key) as? T
    }
    func setRetainedAssociatedObject<T>(_ object: Any, _ key: UnsafeRawPointer, _ value: T) {
        objc_setAssociatedObject(object, key, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
