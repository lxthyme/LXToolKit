//
//  LXBaseObject.swift
//  Alamofire
//
//  Created by LXThyme Jason on 2020/9/25.
//

import UIKit

@objc(LXBaseKitObject)
open class LXBaseObject: NSObject {
    deinit {
        LogKit.traceLifeCycle(.NSObject, typeName: xl.typeNameString, type: .deinit)
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
   // deinit {
   //     LogKit.traceLifeCycle(.model, typeName: xl.typeNameString, type: .deinit)
   // }
    // Instance Level
    var xl_typeNameString: String {
        let type_t = type(of: self)
        return String(describing: type_t)
    }
    // Type Level
    static var xl_typeNameString: String {
        return String(describing: self)
    }
    /// The class's identifier, for UITableView，UICollectionView register its cell
    static var xl_reuseIdentifier: String {
        return String(format: "%@_identifier", self.xl_typeNameString)
    }
}
