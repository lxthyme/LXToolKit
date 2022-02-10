//
//  LXBaseLabel.swift
//  AcknowList
//
//  Created by lxthyme on 2022/2/10.
//

import UIKit

class LXBaseLabel: UILabel {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareUI()
     }
    override init(frame: CGRect) {
        super.init(frame: frame)

        prepareUI()
    }

}

// MARK: 👀Public Actions
extension LXBaseLabel {}

// MARK: 🔐Private Actions
private extension LXBaseLabel {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXBaseLabel {
    func prepareUI() {
        self.backgroundColor = UIColor.white
        // self.title = "<#title#>"

        // [<#table#>].forEach(self.addSubview)

        masonry()
    }

    func masonry() {}
}
