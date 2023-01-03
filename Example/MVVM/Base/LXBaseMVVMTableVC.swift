//
//  LXBaseMVVMTableVC.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/2/10.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import KafkaRefresh
import NSObject_Rx
import DZNEmptyDataSet
import RswiftResources
import Toast_Swift
import LXToolKit

open class LXBaseMVVMTableVC: LXBaseMVVMVC, LXBaseTableViewProtocol {
    // MARK: 📌UI
    public lazy var table: UITableView = {
        return lazyTableView(style: self.style)
    }()
    // MARK: 🔗Vaiables
    public let headerRefreshTrigger = PublishSubject<Void>()
    public let footerRefreshTrigger = PublishSubject<Void>()

    public let isHeaderLoading = BehaviorRelay(value: false)
    public let isFooterLoading = BehaviorRelay(value: false)

    public var clearsSelectionOnViewWillAppear = true
    public private(set) var style: UITableView.Style = UITableView.Style.plain
    // MARK: 🛠Life Cycle
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    public init(viewModel: LXBaseVM, navigator: LXNavigator, style: UITableView.Style = UITableView.Style.plain) {
        self.style = style
        super.init(viewModel: viewModel, navigator: navigator)
    }
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if clearsSelectionOnViewWillAppear == true {
            deselectSelectedRow()
        }
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
        prepareTableView()
    }
    override public func bindViewModel() {
        viewModel?.headerLoading.asObservable()
            .bind(to: isHeaderLoading)
            .disposed(by: rx.disposeBag)
        viewModel?.footerLoading.asObservable()
            .bind(to: isFooterLoading)
            .disposed(by: rx.disposeBag)

        let updateEmptyDataSet = Observable.of(
            isLoading.mapToVoid().asObservable(),
            emptyDataSetImageTintColor.mapToVoid(),
            languageChanged.asObservable()
        ).merge()
        updateEmptyDataSet
            .subscribe(onNext: { [weak self] () in
                self?.table.reloadEmptyDataSet()
            })
            .disposed(by: rx.disposeBag)
    }
}

// MARK: 🌎LoadData
extension LXBaseMVVMTableVC {}

// MARK: 👀Public Actions
extension LXBaseMVVMTableVC {}

// MARK: 🔐Private Actions
private extension LXBaseMVVMTableVC {
    func deselectSelectedRow() {
        if let selectedIndexPaths = table.indexPathsForSelectedRows {
            selectedIndexPaths.forEach({ (indexPath) in
                table.deselectRow(at: indexPath, animated: false)
            })
        }
    }
}

// MARK: - ✈️DZNEmptyDataSetSource
extension LXBaseMVVMTableVC: DZNEmptyDataSetSource {
    public func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: emptyDataSetTitle)
    }
    public func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: emptyDataSetDescription)
    }
    public func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return emptyDataSetImage
    }
    public func imageTintColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return emptyDataSetImageTintColor.value
    }
    public func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return .clear
    }
    public func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -60
    }
}

// MARK: - ✈️DZNEmptyDataSetDelegate
extension LXBaseMVVMTableVC: DZNEmptyDataSetDelegate {
    public func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return !isLoading.value
    }
    public func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    public func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        emptyDataSetButtonTap.onNext(())
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXBaseMVVMTableVC {
    func prepareTableView() {
        table.emptyDataSetDelegate = self
        table.emptyDataSetSource = self

        table.bindGlobalStyle(forHeadRefreshHandler: { [weak self] in
            self?.headerRefreshTrigger.onNext(())
        })

        table.bindGlobalStyle(forFootRefreshHandler: { [weak self] in
            self?.footerRefreshTrigger.onNext(())
        })

        isHeaderLoading
            .bind(to: table.headRefreshControl.rx.isAnimating)
            .disposed(by: rx.disposeBag)
        isFooterLoading
            .bind(to: table.footRefreshControl.rx.isAnimating)
            .disposed(by: rx.disposeBag)

        table.footRefreshControl.autoRefreshOnFoot = true

        error
            .subscribe(onNext: { [weak self] (error) in
                self?.table
                    .makeToast(error.description, title: error.title, image: R.image.icon_toast_warning())
            })
            .disposed(by: rx.disposeBag)
    }
    func prepareUI() {

        // [<#table#>].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {
        table.snp.setLabel("\(self.xl.xl_typeName).table")
    }
}
