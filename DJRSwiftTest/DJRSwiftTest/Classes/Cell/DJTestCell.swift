//
//  DJTestCell.swift
//  DJRSwiftTest
//
//  Created by lxthyme on 2023/4/1.
//
import UIKit

class DJTestCell: UITableViewCell {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
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
extension DJTestCell {}

// MARK: 🔐Private Actions
private extension DJTestCell {}

// MARK: - 🍺UI Prepare & Masonry
private extension DJTestCell {
    func prepareUI() {
        self.contentView.backgroundColor = .white

        // [<#table#>].forEach(self.contentView.addSubview)

        masonry()
    }

    func masonry() {}
}
