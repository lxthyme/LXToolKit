//
//  LXNestedTableVC.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2021/9/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import LXToolKit

class LXNestedTableVC: UIViewController {
    // MARK: 📌UI
    private lazy var table: LXNestedTableView = {
        let t = LXNestedTableView(frame: .zero, style: .plain)
        t.rowHeight = 240
        t.estimatedRowHeight = 240
        t.estimatedSectionHeaderHeight = 0
        t.estimatedSectionFooterHeight = 0
        t.sectionHeaderHeight = 0
        t.sectionFooterHeight = 0
//        t.delaysContentTouches = false
//        t.canCancelContentTouches = false

        t.backgroundColor = .white
        t.separatorStyle = .none
        t.keyboardDismissMode = .onDrag
        t.cellLayoutMarginsFollowReadableWidth = false
        t.separatorColor = .clear
        t.separatorInset = .zero
        t.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.01))
        t.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.01))

        t.delegate = self
        t.dataSource = self

        t.register(LXNestedCell.self, forCellReuseIdentifier: "LXNestedCell")

        return t
    }()
    lazy var dataList: [String] = {
        let ds = Array(repeating: "", count: 20)
        return ds
    }()
    // MARK: 🔗Vaiables
    private var previousContentOffset: CGPoint = .zero
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LXNestedTableVC {}

// MARK: 👀Public Actions
extension LXNestedTableVC {}

// MARK: 🔐Private Actions
private extension LXNestedTableVC {}

    // MARK: - ✈️UITableViewDataSource
extension LXNestedTableVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LXNestedCell", for: indexPath)
        return cell
    }
}
    // MARK: - ✈️UITableViewDelegate
extension LXNestedTableVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - ✈️UIScrollViewDelegate
extension LXNestedTableVC: UIScrollViewDelegate {
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        if scrollView == table {
//            previousContentOffset = scrollView.contentOffset
//        }
//    }
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView == table {
//            dlog("---table")
//
//        } else {
//            dlog("---ELSE")
//        }
//    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXNestedTableVC {
    func prepareUI() {
        self.view.backgroundColor = UIColor.white
        // self.title = "<#title#>"
        [table].forEach(self.view.addSubview)
        masonry()
    }

    func masonry() {
        table.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
