//
//  LXBaseObject.swift
//  Alamofire
//
//  Created by LXThyme Jason on 2020/9/25.
//

import UIKit

open class LXBaseObject: NSObject {
    deinit {
        dlog("---------- >>>Model: \(self.xl.xl_typeName)\t\tdeinit <<<----------")
    }
    // MARK: 📌UI
    // MARK: 🔗Vaiables
}

public protocol LXBase {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
}
// MARK: - 👀
public extension LXBase {
//    deinit {
//        dlog("---------- >>>Model: \(self.xl_typeName)\t\tdeinit <<<----------")
//    }
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
