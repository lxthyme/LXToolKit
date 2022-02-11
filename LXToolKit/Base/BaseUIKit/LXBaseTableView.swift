//
//  LXBaseTableView.swift
//  AcknowList
//
//  Created by lxthyme on 2022/2/10.
//

import UIKit

class LXBaseTableView: UITableView {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareUI()
     }
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        // TODO:「lxthyme」💊这里测试继承的 tableView 不主动调用prepareUI方法时, 是否会触发子类的prepareUI
        prepareUI()
    }

}

// MARK: 👀Public Actions
extension LXBaseTableView {}

// MARK: 🔐Private Actions
private extension LXBaseTableView {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXBaseTableView {
    func prepareUI() {
        self.backgroundColor = UIColor.white
        self.rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = 0
        self.estimatedSectionHeaderHeight = 0
        self.estimatedSectionFooterHeight = 0
        self.sectionHeaderHeight = 0
        self.sectionFooterHeight = 0

        self.backgroundColor = .white
        self.separatorStyle = .none
        self.keyboardDismissMode = .onDrag
        self.cellLayoutMarginsFollowReadableWidth = false
        self.separatorColor = .clear
        self.separatorInset = .zero
        self.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        self.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))

        // self.xl.adapterWith(parentVC: self)
    }
}
