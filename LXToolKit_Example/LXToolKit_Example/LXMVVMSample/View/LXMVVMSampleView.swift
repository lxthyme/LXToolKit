//
//  LXMVVMSampleView.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class LXMVVMSampleView: UIView {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)

        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LXMVVMSampleView {}

// MARK: 👀Public Actions
extension LXMVVMSampleView {}

// MARK: 🔐Private Actions
private extension LXMVVMSampleView {}

// MARK: - 🍺UI Prepare & Masonryry
private extension LXMVVMSampleView {
    func prepareUI() {
        self.backgroundColor = .white
        // self.title = "<#title#>"

        // [<#table#>].forEach(self.addSubview)
        masonry()
    }

    func masonry() {}
}
