//
//  LXBaseTableViewCell.swift
//  Vaffle_demo
//
//  Created by DamonJow on 2018/11/2.
//  Copyright © 2018 DamonJow. All rights reserved.
//

import UIKit

open class LXBaseTableViewCell: UITableViewCell {
    deinit {
        dlog("---------- >>>TableViewCell: \(self.xl_typeName)\t\tdeinit <<<----------")
    }
    public var baseModel: LXAnyModel? {
        didSet {
            if let m = baseModel {
                dataFill(model: m)
            }
        }
    }
}
// MARK: - 👀dataFill
public extension LXBaseTableViewCell {
    func dataFill(model: LXAnyModel) { }
}
