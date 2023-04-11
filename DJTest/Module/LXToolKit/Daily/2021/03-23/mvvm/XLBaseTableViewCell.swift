//
//  LXBaseTableViewCell.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/23.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Rswift
import SwifterSwift

open class XLBaseTableViewCell: UITableViewCell {
    // MARK: 📌UI
    lazy var contentStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.alignment = .center
        return v
    }()
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    // MARK: 🔗Vaiables
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        basePrepareUI()
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    open override func prepareForReuse() {
        super.prepareForReuse()
    }
    open override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// MARK: 👀Public Actions
extension XLBaseTableViewCell {}

// MARK: 🔐Private Actions
private extension XLBaseTableViewCell {}

// MARK: - ✈️LXMVVMConfig
@objc extension XLBaseTableViewCell {
    func bind(to viewModel: XLBaseTableViewCellVM) {}
}

// MARK: - 🍺UI Prepare & Masonry
private extension XLBaseTableViewCell {
    func basePrepareUI() {
        selectionStyle = .none
        backgroundColor = .white
        self.snp.setLabel("LXBaseTableViewCell")
        self.contentView.snp.setLabel("LXBaseTableViewCell.contentView")
        self.contentStackView.snp.setLabel("LXBaseTableViewCell.contentStackView")
        self.contentView.addSubview(contentStackView)
        baseMasonry()
    }
    func baseMasonry() {
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
