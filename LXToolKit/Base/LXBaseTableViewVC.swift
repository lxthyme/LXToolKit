//
//  LXBaseTableViewVC.swift
//  LXToolKit
//
//  Created by lxthyme on 2022/2/7.
//

import UIKit

public protocol LXBaseTableViewProtocol {
    func lazyTableView(style: UITableView.Style) -> UITableView
}
// MARK: - 👀
extension LXBaseTableViewProtocol {
    public func lazyTableView(style: UITableView.Style) -> UITableView {
        let t = UITableView(frame: .zero, style: style)
        t.rowHeight = UITableView.automaticDimension
        t.estimatedRowHeight = UITableView.automaticDimension
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

        // t.delegate = self
        // t.dataSource = self

        return t
    }
}

open class LXBaseTableViewVC: LXBaseVC, LXBaseTableViewProtocol {
    // MARK: UI
    public lazy var table: UITableView = {
        return lazyTableView(style: .plain)
    }()
    // MARK: - Vaiables
    // MARK: Life Cycle
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override open func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: LoadData
extension LXBaseTableViewVC {}

// MARK: Public Actions
extension LXBaseTableViewVC {}

// MARK: Private Actions
private extension LXBaseTableViewVC {}

// MARK: - UI Prepare & Masonry
private extension LXBaseTableViewVC {
    func prepareUI() {
        self.edgesForExtendedLayout = []
        self.automaticallyAdjustsScrollViewInsets = true
        if #available(iOS 11.0, *) {
            table.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }

    func masonry() {}
}
