//
//  LXBaseTableView.swift
//  test
//
//  Created by lxthyme on 2023/3/27.
//
import UIKit

@objc(LXBaseSwiftTableView)
open class LXBaseTableView: UITableView {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    // required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    // override init(frame: CGRect) {
    //     super.init(frame: frame)
    //
    //     prepareUI()
    // }
}

// MARK: 👀Public Actions
extension LXBaseTableView {}

// MARK: 🔐Private Actions
private extension LXBaseTableView {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXBaseTableView {
    func prepareUI() {
        self.backgroundColor = UIColor.white
        // self.title = "<#title#>"

        // [<#table#>].forEach(self.addSubview)

        masonry()
    }

    func masonry() {}
}
