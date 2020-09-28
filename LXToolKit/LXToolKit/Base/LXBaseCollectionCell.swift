//
//  LXBaseCollectionCell.swift
//  Alamofire
//
//  Created by LXThyme Jason on 2020/9/27.
//

import UIKit

open class LXBaseCollectionCell: UICollectionViewCell {
    deinit {
        dlog("---------- >>>TableViewCell: \(self.xl_typeName)\t\tdeinit <<<----------")
    }
    // MARK: 📌UI
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")
//        dlog("---------- >>>TableViewCell: \(self.xl_typeName)\t\tinit <<<----------")
    }
    // MARK: 🔗Vaiables
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    open override func prepareForReuse() {
        super.prepareForReuse()
    }
}

open class LXBaseGenericCollectionCell<T>: LXBaseCollectionCell {
    public var baseModel: T? {
        willSet {
            if let nv = newValue {
                dataFill(model: nv)
            }
        }
//        didSet {
//            if let ov = oldValue {
//                dataFill(model: ov)
//            }
//        }
    }
    public func dataFill(model: T) { }

}
