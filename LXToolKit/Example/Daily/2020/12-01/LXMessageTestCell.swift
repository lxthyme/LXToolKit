//
//  LXMessageTestCell.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2020/12/1.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class LXMessageTestCell: UITableViewCell {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        prepareUI()
    }
    open override func prepareForReuse() {
        super.prepareForReuse()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// MARK: 👀Public Actions
extension LXMessageTestCell {}

// MARK: 🔐Private Actions
private extension LXMessageTestCell {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXMessageTestCell {
    func prepareUI() {}
}
