//
//  LXiOS15VC.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/2/7.
//  Copyright © 2022 CocoaPods. All rights reserved.
//
// iOS15 适配

import UIKit
import CoreLocationUI
import LXToolKit

private enum IOS15FitType {
case UISheetPresentationController
}

// MARK: - 🔐iOS15FitType
private extension IOS15FitType {
    func action() {
        switch self {
            case .UISheetPresentationController:
                break
        }
    }
}

class LXiOS15VC: LXBaseMVVMTableVC {
    // MARK: 📌UI
    lazy var dataList: [String] = {
        let ds = Array(repeating: "", count: 20)
        return ds
    }()
    // MARK: 🔗Vaiables
    @available(iOS 14.0, *)
    private lazy var dataSource: UITableViewDiffableDataSource<String, NSInteger> = {
        let dataSource = UITableViewDiffableDataSource<String, NSInteger>(tableView: table) { tableView, indexPath, idx in
            let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.xl.xl_identifier, for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.text = "\(idx)_"
            cell.contentConfiguration = content
            return cell
        }
        // dataSource.did
        dataSource.defaultRowAnimation = .fade
        return dataSource
    }()
    @available(iOS 13.0, *)
    private lazy var dataSnapshot: NSDiffableDataSourceSnapshot<String, NSInteger> = {
        var snapshot = NSDiffableDataSourceSnapshot<String, NSInteger>()
        snapshot.appendSections(["1", "3", "5"])
        snapshot.appendItems([11, 13, 15], toSection: "1")
        snapshot.appendItems([31, 33, 35], toSection: "3")
        snapshot.appendItems([51, 53, 55], toSection: "5")
        return snapshot
    }()
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
        prepareTableView()
    }

}

// MARK: 🌎LoadData
extension LXiOS15VC {}

// MARK: 👀Public Actions
extension LXiOS15VC {}

// MARK: 🔐Private Actions
private extension LXiOS15VC {}

// MARK: 🔐iOS 15 适配
@available(iOS 15.0.0, *)
private extension LXiOS15VC {
    func fitUIButton() -> UIButton {
        var config = UIButton.Configuration.plain()
        config.buttonSize = .large
        config.cornerStyle = .large
        config.macIdiomStyle = .borderlessTinted
        config.titleAlignment = .center
        let btnPlain = UIButton(configuration: config, primaryAction: UIAction(handler: { action in
            dlog("clicked!")
        }))
        return btnPlain
    }
    func fitCLLocationButton() -> CLLocationButton {
        let btnLocation = CLLocationButton()
        btnLocation.label = .currentLocation
        btnLocation.fontSize = 20
        btnLocation.icon = .arrowFilled
        // btnLocation.cornerRadius = 10
        btnLocation.tintColor = .systemPink
        btnLocation.backgroundColor = .xl.random
        btnLocation.addAction(UIAction(handler: { action in
            dlog("clicked!")
        }), for: .touchUpInside)
        return btnLocation
    }
    func asyncAwait() async throws {
        let session = URLSession.shared
        let url = URL(string: "http://0.0.0.0:3003/api/dj-api/kdj/pay/account.html")!
        /// 请求数据
        let (data, response) = try await session.data(from: url)
        /// 下载
        // let (localURL, _) = try await session.downloadTask(with: url)
        /// 上传
        // let (tmpUpload, response) = try await session.upload(for: <#T##Foundation.URLRequest#>, from: <#T##Foundation.Data#>)
    }
    func fitUIImage() async {
        /// 1. hierarchicalColor：多层渲染，透明度不同
        let config = UIImage.SymbolConfiguration(hierarchicalColor: .systemRed)
        let img = UIImage(systemName: "square.stack.3d.down.right.fill", withConfiguration: config)
        /// 2. paletteColors：多层渲染，设置不同风格
        let config2 = UIImage.SymbolConfiguration(paletteColors: [.systemRed, .systemGreen])
        let img2 = UIImage(systemName: "person.3.sequence.fill", withConfiguration: config2)

        /// 新增了几个调整尺寸的方法
        // preparingThumbnail
        let img3 = UIImage(named: "sv.png")?.preparingThumbnail(of: CGSize(width: 200, height: 100))
        // prepareThumbnail，闭包中直接获取调整后的UIImage
        let img4 = UIImage(named: "sv.png")?.prepareThumbnail(of: CGSize(width: 200, height: 100), completionHandler: { img in
            // 需要回到主线程更新UI
            print(img)
        })
        // byPreparingThumbnail
        let img5 = await UIImage(named: "sv.png")?.byPreparingThumbnail(ofSize: CGSize(width: 200, height: 100))
    }
    func fitUINavigationBarAppearance() {
        /// 1. UINavigationBar
        let navAppearance = UINavigationBarAppearance()
        navAppearance.backgroundColor = .red
        // 毛玻璃效果
        navAppearance.backgroundEffect = UIBlurEffect(style: .regular)
        navigationController?.navigationBar.scrollEdgeAppearance = navAppearance
        navigationController?.navigationBar.standardAppearance = navAppearance
        /// 2. UIToolbar
        let toolbarAppearance = UIToolbarAppearance()
        toolbarAppearance.backgroundColor = .blue
        navigationController?.toolbar.scrollEdgeAppearance = toolbarAppearance
        navigationController?.toolbar.standardAppearance = toolbarAppearance
        /// 3. UITabBar
        let tabbarAppearance = UITabBarAppearance()
        tabbarAppearance.backgroundColor = .purple
        // tabBaritem title选中状态颜色
        tabbarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.blue
        ]
        // tabBaritem title未选中状态颜色
        tabbarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.red
        ]
        // 1. 小屏幕手机横屏时的状态
        // 2. scrollview向下拉的状态
        tabBarController?.tabBar.scrollEdgeAppearance = tabbarAppearance
        // 常规状态
        tabBarController?.tabBar.standardAppearance = tabbarAppearance
    }
    func fitUITableView() {
        let table = UITableView()
        // 单独设置
        table.sectionHeaderTopPadding = 0
        // 全局设置
        UITableView.appearance().sectionHeaderTopPadding = 0
    }
}

// MARK: - ✈️UITableViewDataSource
extension LXiOS15VC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.xl.xl_identifier) as! UITableViewCell
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}
// MARK: - ✈️UITableViewDelegate
extension LXiOS15VC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var vc: UIViewController =
        LXTable0120VC()
        if #available(iOS 15.0, *) {
                // LXTable0120VC()
            vc = LXiOS15ButtonTestVC()
        }
        self.navigationController?.showDetailViewController(vc, sender: nil)
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXiOS15VC {
    func prepareTableView() {
        table.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.xl.xl_identifier)
        table.delegate = self
        if #available(iOS 14.0, *) {
            dataSource.apply(dataSnapshot, animatingDifferences: true)
        } else {
            // Fallback on earlier versions
            table.dataSource = self
        }
    }
    func prepareUI() {
        self.view.backgroundColor = .white
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
