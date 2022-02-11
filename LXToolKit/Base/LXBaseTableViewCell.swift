//
//  LXBaseTableViewCell.swift
//  Vaffle_demo
//
//  Created by DamonJow on 2018/11/2.
//  Copyright © 2018 DamonJow. All rights reserved.
//

import UIKit
import SnapKit

open class LXBaseTableViewCell: UITableViewCell {
    deinit {
        dlog("---------- >>>TableViewCell: \(self.xl.xl_typeName)\t\tdeinit <<<----------")
    }
    // MARK: 📌UI
    lazy var contentStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.alignment = .center
        return v
    }()
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    public var baseModel: LXAnyModel? {
        didSet {
            if let m = baseModel {
                dataFill(model: m)
            }
        }
    }
}
// MARK: 🌎LoadData
extension LXBaseTableViewCell {
    func dataFill(model: LXAnyModel) { }
}

// MARK: 👀Public Actions
extension LXBaseTableViewCell {}

// MARK: 🔐Private Actions
private extension LXBaseTableViewCell {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXBaseTableViewCell {
    func prepareUI() {
        self.contentView.backgroundColor = .white

        // [<#table#>].forEach(self.<#contentView#>.addSubview)

        masonry()
    }

    func masonry() {
        contentStackView.snp.setLabel("\(self.xl.xl_typeName).contentStackView")
    }
}
