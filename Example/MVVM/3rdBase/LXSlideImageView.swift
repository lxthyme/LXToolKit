//
//  LXSlideImageView.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/2/18.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class LXSlideImageView: UIView {
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
extension LXSlideImageView {}

// MARK: 🔐Private Actions
private extension LXSlideImageView {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXSlideImageView {
    func prepareUI() {
        self.backgroundColor = UIColor.white
        // self.title = "<#title#>"

        // [<#table#>].forEach(self.addSubview)

        masonry()
    }

    func masonry() {}
}
