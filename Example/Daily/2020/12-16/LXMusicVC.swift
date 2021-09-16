//
//  LXMusicVC.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2020/12/16.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import LXToolKit
import RxSwift
import RxCocoa

class LXMusicVC: UIViewController {
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

        t.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.xl.xl_identifier)

        return t
    }()
    lazy var musicVM: LXMusicVM = {
        return LXMusicVM()
    }()
    // MARK: 🔗Vaiables
    var disposeBag = DisposeBag()
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
        prepareVM()
    }

}

// MARK: 🌎LoadData
extension LXMusicVC {}

// MARK: 👀Public Actions
extension LXMusicVC {}

// MARK: 🔐Private Actions
private extension LXMusicVC {}

// MARK: - ✈️UITableViewDataSource
//extension LXMusicVC: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return musicVM.dataList.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.xl_identifier, for: indexPath)
//        let model = musicVM.dataList[indexPath.row]
//        cell.textLabel?.text = model?.name
//        cell.detailTextLabel?.text = model?.singer
//        return cell
//    }
//}
// MARK: - ✈️UITableViewDelegate
//extension LXMusicVC: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        dlog("Selected: ", musicVM.dataList[indexPath.row])
//    }
//}

// MARK: - 🍺UI Prepare & Masonry
private extension LXMusicVC {
    func prepareVM() {
        table.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.xl.xl_identifier)
        self.musicVM
            .dataList
            .bind(to: table.rx.items(cellIdentifier: UITableViewCell.xl.xl_identifier)) { _, model, cell in
                cell.textLabel?.text = model?.name
                cell.detailTextLabel?.text = model?.singer
            }
            .disposed(by: disposeBag)
        table
            .rx
            .modelSelected(LXMusicModel.self).subscribe { model in
                dlog("Selected: ", model.element?.description)
            }
            .disposed(by: disposeBag)
    }
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
