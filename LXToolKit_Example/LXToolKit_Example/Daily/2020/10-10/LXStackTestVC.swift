//
//  LXStackTestVC.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2020/10/10.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class LXStackTestVC: LXBaseVC {
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

        t.delegate = self
        t.dataSource = self

        t.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.XL.reuseIdentifier)

        return t
    }()
    private lazy var btnTitle: UIButton = {
        let btn = UIButton(type: .custom)

        btn.setTitle("Next", for: .normal)
        btn.setTitleColor(.white, for: .normal)

//        btn.setBackgroundColor(.hex("#0092fe"), forState: .normal)
        btn.backgroundColor = UIColor.XL.hexString("#0092fe")

//        btn.titleLabel?.font = UIFont.systemFont(ofSize: <#T##CGFloat#>)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 4

//        <#btn.addTarget(self, action: #selector(btnSigninAction(sender:)), for: .touchUpInside)#>
//        <#@objc func btnSigninAction(sender: UIButton) {}#>
        return btn
    }()
    private lazy var labTitle1: UILabel = {
        let lab = UILabel()
        lab.text = "Title1"
        lab.font = .systemFont(ofSize: 14)
        lab.textColor = .black
        lab.backgroundColor = .cyan
        lab.numberOfLines = 1
        lab.lineBreakMode = .byTruncatingTail
        lab.textAlignment = .center
        return lab
    }()
    private lazy var labTitle2: UILabel = {
        let lab = UILabel()
        lab.text = "Title2"
        lab.font = .systemFont(ofSize: 14)
        lab.textColor = .black
        lab.backgroundColor = .cyan
        lab.numberOfLines = 1
        lab.lineBreakMode = .byTruncatingTail
        lab.textAlignment = .center
        return lab
    }()
    lazy var dataList: [String] = {
        let ds = Array(repeating: "", count: 10)
        return ds
    }()
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
        prepareVM()
        self.navigationController?.navigationBar.barTintColor = .darkGray
        self.navigationController?.navigationBar.tintColor = .red
        self.navigationController?.navigationItem.title = "Location"
        self.title = "Location233"
        table.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.XL.reuseIdentifier)
    }

}

// MARK: 🌎LoadData
extension LXStackTestVC {}

// MARK: 👀Public Actions
extension LXStackTestVC {}

// MARK: 🔐Private Actions
private extension LXStackTestVC {}

// MARK: - ✈️UITableViewDataSource
extension LXStackTestVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.XL.reuseIdentifier, for: indexPath)
        cell.textLabel?.text = "\(indexPath.row + 1)"
        return cell
    }
}
// MARK: - ✈️UITableViewDelegate
extension LXStackTestVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
// MARK: - 🍺UI Prepare & Masonry
extension LXStackTestVC {
    override func prepareVM() {
        super.prepareVM()
        var idx = 0
        btnTitle.rx
            .controlEvent(.touchUpInside)
            .throttle(.microseconds(300), scheduler: MainScheduler.instance)
            .subscribe { _ in
                if idx % 4 == 0 {
                    self.labTitle1.isHidden = true;
                    self.labTitle2.isHidden = false;
                } else if idx % 4 == 1 {
                    self.labTitle1.isHidden = false;
                    self.labTitle2.isHidden = true;
                } else if idx % 4 == 2 {
                    self.labTitle1.isHidden = true;
                    self.labTitle2.isHidden = true;
                } else if idx % 4 == 3 {
                    self.labTitle1.isHidden = false;
                    self.labTitle2.isHidden = false;
                }
                idx += 1
            }
            .disposed(by: rx.disposeBag)
    }
    override func prepareUI() {
        super.prepareUI()
        self.view.backgroundColor = .white
        contentStackView.backgroundColor = .red
        contentStackView.spacing = 10
        // self.title = "<#title#>"

        [contentStackView].forEach(self.view.addSubview)
        btnTitle.frame = CGRect(x: 0, y: 0, width: 320, height: 60)
        [table, labTitle1, labTitle2, btnTitle].forEach(contentStackView.addArrangedSubview)
        masonry()
        contentStackView.setCustomSpacing(20, after: labTitle1)
    }

    override func masonry() {
        super.masonry()
        // contentStackView.snp.makeConstraints {
        //     $0.top.equalTo(self.view.snp.topMargin)
        //     $0.left.right.equalToSuperview()
        //     $0.bottom.equalTo(self.view.snp.bottomMargin)
        // }
        // table.snp.makeConstraints {
        //     $0.top.left.right.equalToSuperview()
        // }
        btnTitle.snp.makeConstraints {
            // $0.top.equalTo(table.snp.bottom)
            // $0.left.right.equalTo(table)
            // $0.bottom.equalToSuperview()
            $0.height.equalTo(50)
        }
        labTitle1.snp.makeConstraints {
            $0.height.equalTo(44)
        }
        labTitle2.snp.makeConstraints {
            $0.height.equalTo(44)
        }
    }
}
