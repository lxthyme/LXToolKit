//
//  XLBaseTableVC.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/25.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import KafkaRefresh

class XLBaseTableVC: XLBaseVC {
    // MARK: 📌UI
    lazy var table: UITableView = {
        let t = UITableView(frame: .zero, style: .plain)
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

//        t.delegate = self
//        t.dataSource = self
        t.emptyDataSetDelegate = self
        t.emptyDataSetSource = self

        return t
    }()
    // MARK: 🔗Vaiables
    let headerRefreshTrigger = PublishSubject<Void>()
    let footerRefreshTriggr = PublishSubject<Void>()

    let isHeaderLoading = BehaviorRelay(value: false)
    let isFooterLoading = BehaviorRelay(value: false)

    var clearSelectionOnViewWillAppear = true
    // MARK: 🛠Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if clearSelectionOnViewWillAppear {
            deselectSelectedRow()
        }
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
        baseTableSetupTableView()
        baseTablePrepareUI()
    }

}

// MARK: 🌎LoadData
extension XLBaseTableVC {}

// MARK: 👀Public Actions
@objc extension XLBaseTableVC {
    override func updateUI() {
        super.updateUI()
    }
    override func bindViewModel() {
        super.bindViewModel()

        vm?.headerLoading
            .asObservable()
            .bind(to: isHeaderLoading)
            .disposed(by: rx.disposeBag)
        vm?.footerLoading
            .asObservable()
            .bind(to: isFooterLoading)
            .disposed(by: rx.disposeBag)

        let updateEmptyDataSet = Observable
            .of(isLoading.mapToVoid().asObservable(),
                emptyDataSet.imgTintColor.mapToVoid(),
                languageChanged.asObservable())
            .merge()
        updateEmptyDataSet
            .subscribe(onNext: {[weak self] _ in
                guard let `self` = self else { return }
                Logger.debug("🛠1. onNext - updateEmptyDataSet:")
                self.table.reloadEmptyDataSet()
            })
            .disposed(by: rx.disposeBag)
    }
}

// MARK: 🔐Private Actions
private extension XLBaseTableVC {
    func deselectSelectedRow(animated: Bool = false) {
        if let selectedIndexPaths = table.indexPathsForVisibleRows {
            selectedIndexPaths.forEach { table.deselectRow(at: $0, animated: animated) }
        }
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension XLBaseTableVC {
    func baseTableSetupTableView() {
        contentStackView.insertArrangedSubview(table, at: 0)
        table.bindGlobalStyle(forHeadRefreshHandler: {[weak self] in
            self?.headerRefreshTrigger.onNext(())
        })
        table.bindGlobalStyle(forFootRefreshHandler: {[weak self] in
            self?.footerRefreshTriggr.onNext(())
        })

        isHeaderLoading
            .bind(to: table.headRefreshControl.rx.isAnimating)
            .disposed(by: rx.disposeBag)
        isFooterLoading
            .bind(to: table.footRefreshControl.rx.isAnimating)
            .disposed(by: rx.disposeBag)

        table.footRefreshControl.autoRefreshOnFoot = true

        error
            .subscribe(onNext: {[weak self] error in
                guard let `self` = self else { return }
                Logger.debug("🛠1. onNext - error: \(error)")
                self.table.makeToast(error.description, title: error.title, image: R.image.icon_toast_warning())
            })
            .disposed(by: rx.disposeBag)
    }
    func baseTablePrepareUI() {
        baseTableMasonry()
    }

    func baseTableMasonry() {
        table.snp.setLabel("LXBaseTableVC.table")
    }
}
