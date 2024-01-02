//
//  LXEmptyView.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/1/17.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

@objc enum EmptyType: Int {
    case normal
    case unReachability
    case nocontent
    case serverbusy
}

class LXEmptyView: UIView {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    var retryBlock: (() -> Void)?
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)

        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LXEmptyView {}

// MARK: 👀Public Actions
extension LXEmptyView {}

// MARK: 🔐Private Actions
private extension LXEmptyView {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXEmptyView {
    func prepareUI() {
        self.backgroundColor = UIColor.white
        // self.title = "<#title#>"

        // [<#table#>].forEach(self.addSubview)
        masonry()
    }

    func masonry() {}
}
