//
//  LXTable0120VC.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/1/20.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import LXToolKit

class LXTable0120VC: UIViewController {
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

        t.delegate = self
        t.dataSource = self
        // t.xl.adapter(withParentVC: self)

        t.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")

        return t
    }()
    lazy var dataList: [String] = {
        let ds = Array(repeating: "", count: 20)
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
extension LXTable0120VC {}

// MARK: 👀Public Actions
extension LXTable0120VC {}

// MARK: 🔐Private Actions
private extension LXTable0120VC {}

// MARK: - ✈️UITableViewDataSource
extension LXTable0120VC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell") as! UITableViewCell
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}
// MARK: - ✈️UITableViewDelegate
extension LXTable0120VC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXTable0120VC {
    func prepareUI() {
        self.view.backgroundColor = UIColor.white

        [self.table].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {
        table.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
