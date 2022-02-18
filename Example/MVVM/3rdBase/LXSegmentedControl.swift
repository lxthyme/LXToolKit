//
//  LXSegmentedControl.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/2/18.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class LXSegmentedControl: HMSegmentedControl {
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
extension LXSegmentedControl {}

// MARK: 🔐Private Actions
private extension LXSegmentedControl {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXSegmentedControl {
    func prepareUI() {
        self.backgroundColor = UIColor.white
        // self.title = "<#title#>"

        // [<#table#>].forEach(self.addSubview)

        masonry()
    }

    func masonry() {}
}
