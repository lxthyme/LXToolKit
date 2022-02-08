//
//  LXTable0120VC.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/1/20.
//  Copyright © 2022 CocoaPods. All rights reserved.
//
/// 测试 sectionHeaderTopPadding 偏移的场景
///     1. `.plain`
///     2. 有 section title

import UIKit
import LXToolKit

class LXTable0120VC: LXBaseTableViewVC {
    // MARK: 📌UI
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
        cell.textLabel?.text = "\(indexPath.section) - \(indexPath.row)"
        return cell
    }
}
// MARK: - ✈️UITableViewDelegate
extension LXTable0120VC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section - \(section)"
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXTable0120VC {
    func prepareTableView() {
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
    func prepareUI() {
        self.view.backgroundColor = .cyan
        self.table.backgroundColor = .random
        prepareTableView()

        [self.table].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {
        table.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
