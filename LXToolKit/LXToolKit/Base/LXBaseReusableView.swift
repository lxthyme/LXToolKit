//
//  LXBaseReusableView.swift
//  SwiftPro
//
//  Created by DamonJow on 2018/11/6.
//  Copyright © 2018 DamonJow. All rights reserved.
//
import UIKit
import Foundation

//protocol LXBaseReusableView { }

open class LXBaseReusableView: UICollectionReusableView {
    deinit {
        dlog("---------- >>>CollectionReusableView: \(self.xl_typeName)\t\tdeinit <<<----------")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
//        dlog("---------->>>CollectionReusableView \(self.xl_typeName)\t\tinit ----------")
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override open func prepareForReuse() {
        super.prepareForReuse()
    }
}

//extension LXBaseReusableView {
//    // Instance Level
//    private var typeName: String {
//        let type_t = type(of: self)
//        return String(describing: type_t)
//    }
//    // Type Level
//    private static var typeName: String {
//        return String(describing: self)
//    }
//}
//extension LXBaseReusableView {
//    static var reuseIdentifier: String {
//        return self.typeName + ".identifier"
//    }
//    static var nib: UINib {
//        return UINib(nibName: self.typeName, bundle: Bundle.main)
//    }
//}

//extension UITableView {
//    func registerNib<T: UITableViewCell>(_ nibName: T.Type) where T: LXBaseReusableView {
//        self.register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
//    }
//    func registerClass<T: UITableViewCell>(_ clsName: T.Type) where T: LXBaseReusableView {
//        self.register(NSClassFromString(T.typeName), forCellReuseIdentifier: T.reuseIdentifier)
//    }
//}

//extension UITableView {
//    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) ->T where T: LXBaseReusableView {
////        guard  else { assert(false, "Could not dequeue cell with identifier: \(T.reuseIdentifier)") }
//        let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath)
//        return cell as! T
//    }
//}
