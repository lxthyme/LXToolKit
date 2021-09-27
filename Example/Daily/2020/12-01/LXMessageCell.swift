//
//  LXMessageCell.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2020/12/1.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class LXMessageCell: UITableViewCell {
    // MARK: 📌UI
    @IBOutlet weak var imgViewLogo: UIImageView!
    @IBOutlet weak var logoStackView: UIStackView!
    @IBOutlet weak var textViewContent: UITextView!
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var bottomStackView: UIStackView!
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
extension LXMessageCell {}

// MARK: 🔐Private Actions
private extension LXMessageCell {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXMessageCell {
    func prepareUI() {}
}
