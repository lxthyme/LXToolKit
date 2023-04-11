//
//  LXBaseCollectionCell.swift
//  Alamofire
//
//  Created by LXThyme Jason on 2020/9/27.
//

import UIKit

open class LXBaseCollectionCell: UICollectionViewCell {
    deinit {
        dlog("---------- >>>TableViewCell: \(self.xl.xl_typeName)\t\tdeinit <<<----------")
    }
    // MARK: 📌UI
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")
//        dlog("---------- >>>TableViewCell: \(self.xl_typeName)\t\tinit <<<----------")
    }
    // MARK: 🔗Vaiables
    public var baseModel: LXAnyModel? {
        didSet {
            if let m = baseModel {
                dataFill(model: m)
            }
        }
    }
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    open override func prepareForReuse() {
        super.prepareForReuse()
    }
}
// MARK: - 👀dataFill
public extension LXBaseCollectionCell {
    func dataFill(model: LXAnyModel) { }
}
