//
//  LX0324EventsVC.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import MJRefresh

class LX0324EventsVC: UIViewController {
    // MARK: 📌UI
    private lazy var table: UITableView = {
        let t = UITableView(frame: .zero, style: .plain)
        t.rowHeight = UITableView.automaticDimension
        t.estimatedRowHeight = 0
        t.estimatedSectionHeaderHeight = 0
        t.estimatedSectionFooterHeight = 0
        t.sectionHeaderHeight = 0
        t.sectionFooterHeight = 0

        t.backgroundColor = .white
        t.separatorStyle = .none
        t.keyboardDismissMode = .onDrag
        t.cellLayoutMarginsFollowReadableWidth = false
        t.separatorColor = .clear
        t.separatorInset = .zero
        t.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.01))
        t.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.01))

//        t.delegate = self
//        t.dataSource = self

        return t
    }()
    lazy var dataList: [String] = {
        let ds = Array(repeating: "", count: 20)
        return ds
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LX0324EventsVC {}

// MARK: 👀Public Actions
extension LX0324EventsVC {}

// MARK: 🔐Private Actions
private extension LX0324EventsVC {}

// MARK: - 🍺UI Prepare & Masonry
private extension LX0324EventsVC {
    func prepareUI() {
        self.view.backgroundColor = UIColor.white
        // self.title = "<#title#>"

        // [<#table#>].forEach(self.view.addSubview)
        masonry()
    }

    func masonry() {}
}
