//
//  LX0117VC.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/1/17.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class LX0117VC: LXBaseVMVC2 {
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

//        t.delegate = self
//        t.dataSource = self

        UITableViewCell.xl.register(t)

        return t
    }()
    lazy var dataList: [String] = {
        let ds = Array(repeating: "", count: 3)
        return ds
    }()
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LX0117VC {}

// MARK: 👀Public Actions
extension LX0117VC {}

// MARK: 🔐Private Actions
private extension LX0117VC {}

// MARK: - 🍺UI Prepare & Masonry
private extension LX0117VC {
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
