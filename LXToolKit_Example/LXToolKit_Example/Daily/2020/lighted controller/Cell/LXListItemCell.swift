//
//  LXListItemCell.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/8/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class LXListItemCell: UITableViewCell {
    // MARK: UI
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    // MARK: Vaiables
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        prepareUI()
    }

}

// MARK: Public Actions
extension LXListItemCell {}

// MARK: Private Actions
private extension LXListItemCell {}

// MARK: - UI Prepare & Masonry
private extension LXListItemCell {
    func prepareUI() {
        // [<#table#>].forEach(self.contentView.addSubview)
        masonry()
    }

    func masonry() {}
}
