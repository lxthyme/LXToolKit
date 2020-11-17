//
//  LXStackTestVC.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2020/10/10.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class LXStackTestVC: UIViewController {
    // MARK: 📌UI
    @IBOutlet weak var tableView: UITableView!
    private lazy var contentStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.alignment = .fill
        return v
    }()
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

        t.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.xl_identifier)

        return t
    }()
    private lazy var btnTitle: UIButton = {
        let btn = UIButton(type: .custom)

        btn.setTitle("Next", for: .normal)
        btn.setTitleColor(.white, for: .normal)

//        btn.setBackgroundColor(.hex("#0092fe"), forState: .normal)
        btn.backgroundColor = .hex("#0092fe")

//        btn.titleLabel?.font = UIFont.systemFont(ofSize: <#T##CGFloat#>)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 4

//        <#btn.addTarget(self, action: #selector(btnSigninAction(sender:)), for: .touchUpInside)#>
//        <#@objc func btnSigninAction(sender: UIButton) {}#>
        return btn
    }()
    lazy var dataList: [String] = {
        let ds = Array(repeating: "", count: 10)
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
        self.view.backgroundColor = .white
//        prepareUI()
        self.navigationController?.navigationBar.barTintColor = .darkGray
        self.navigationController?.navigationBar.tintColor = .red
        self.navigationController?.navigationItem.title = "Location"
        self.title = "Location233"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.xl_identifier)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.xl_identifier, for: indexPath)
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
private extension LXStackTestVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        // self.title = "<#title#>"

        [contentStackView].forEach(self.view.addSubview)
        btnTitle.frame = CGRect(x: 0, y: 0, width: 320, height: 60)
        [table, btnTitle].forEach(contentStackView.addArrangedSubview)
        masonry()
    }

    func masonry() {
        contentStackView.snp.makeConstraints {
            $0.edges.equalTo(self.view)
        }
        table.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        btnTitle.snp.makeConstraints {
            $0.top.equalTo(table.snp.bottom)
            $0.left.right.equalTo(table)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
}
