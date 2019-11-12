//
//  LXBaseTableViewCell.swift
//  Vaffle_demo
//
//  Created by DamonJow on 2018/11/2.
//  Copyright © 2018 DamonJow. All rights reserved.
//

import UIKit

open class LXBaseTableViewCell<T>: UITableViewCell {
    deinit {
        dlog("---------- >>>TableViewCell: \(self.xl_typeName)\t\tdeinit <<<----------")
    }
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
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
//        dlog("---------- >>>TableViewCell: \(self.xl_typeName)\t\tdeinit <<<----------")
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        dlog("---------- >>>TableViewCell: \(self.xl_typeName)\t\tdeinit <<<----------")
        self.selectionStyle = .none
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func dataFill(model: T) { }

}

//extension LXBaseTableViewCell { }
