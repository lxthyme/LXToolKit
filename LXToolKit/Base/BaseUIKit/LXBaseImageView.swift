//
//  LXBaseImageView.swift
//  LXToolKit
//
//  Created by lxthyme on 2022/3/2.
//

import UIKit

class LXBaseImageView: UIImageView {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)

        prepareUI()
    }

}

// MARK: 👀Public Actions
extension LXBaseImageView {}

// MARK: 🔐Private Actions
private extension LXBaseImageView {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXBaseImageView {
    func prepareUI() {
        self.backgroundColor = UIColor.white
        // self.title = "<#title#>"

        // [<#table#>].forEach(self.addSubview)

        masonry()
    }

    func masonry() {}
}
