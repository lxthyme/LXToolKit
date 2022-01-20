//
//  LXNestedCollectionCell.swift
//  test
//
//  Created by lxthyme on 2021/9/26.
//

import UIKit

class LXNestedCollectionCell: UICollectionViewCell {
    // MARK: 📌UI
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareUI()
     }
    // MARK: 🔗Vaiables
    override init(frame: CGRect) {
        super.init(frame: frame)

        prepareUI()
    }
    open override func prepareForReuse() {
        super.prepareForReuse()
    }
}

// MARK: 👀Public Actions
extension LXNestedCollectionCell {}

// MARK: 🔐Private Actions
private extension LXNestedCollectionCell {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXNestedCollectionCell {
    func prepareUI() {
        self.contentView.backgroundColor = .cyan
        //[<#table#>].forEach(self.contentView.addSubview)
        masonry()
    }

    func masonry() {}
}
