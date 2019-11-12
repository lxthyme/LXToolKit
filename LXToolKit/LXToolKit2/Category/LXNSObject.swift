//
//  LXNSObject.swift
//  LXToolKit
//
//  Created by LXThyme Jason on 2019/11/12.
//  Copyright © 2019 LXThyme Jason. All rights reserved.
//

import Foundation

public extension NSProxy {
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
    class var xl_identifier: String {
        return String(format: "%@_identifier", self.xl_typeName)
    }
}
public extension NSObject {
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
    class var xl_identifier: String {
        return String(format: "%@_identifier", self.xl_typeName)
    }

}
