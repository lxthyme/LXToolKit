//
//  LXEventCell.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/2/17.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class LXEventCell: DefaultTableViewCell {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareUI()
     }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        prepareUI()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    open override func prepareForReuse() {
        super.prepareForReuse()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func bind(to viewModel: LXBaseMVVMTableCellVM) {
        super.bind(to: viewModel)
        // guard let vm = viewModel as?  else { return }
    }

}

// MARK: 👀Public Actions
extension LXEventCell {}

// MARK: 🔐Private Actions
private extension LXEventCell {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXEventCell {
    func prepareUI() {
        titleLabel.numberOfLines = 2
        secondDetailLabel.numberOfLines = 2

        // [<#table#>].forEach(self.contentView.addSubview)

        masonry()
    }

    func masonry() {}
}
