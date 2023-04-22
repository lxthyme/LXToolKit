//
//  LXBaseTableVC.swift
//  test
//
//  Created by lxthyme on 2023/3/25.
//
import UIKit
import KafkaRefresh

import RxDataSources

public protocol LXBaseTableViewProtocol {
    func lazyTableView(style: UITableView.Style) -> LXBaseTableView
}
// MARK: - 👀
extension LXBaseTableViewProtocol {
    public func lazyTableView(style: LXBaseTableView.Style) -> LXBaseTableView {
        let t = LXBaseTableView(frame: .zero, style: style)
        t.rowHeight = UITableView.automaticDimension
        t.estimatedRowHeight = UITableView.automaticDimension
        t.estimatedSectionHeaderHeight = 0
        t.estimatedSectionFooterHeight = 0
        t.sectionHeaderHeight = 0
        t.sectionFooterHeight = 0
        t.backgroundColor = .white
        t.keyboardDismissMode = .onDrag
        t.cellLayoutMarginsFollowReadableWidth = false
        // t.separatorStyle = .none
        // t.separatorColor = .clear
        // t.separatorInset = .zero
        t.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.01))
        t.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.01))

        // t.delegate = self
        // t.dataSource = self
        // t.rx.setDelegate(self).disposed(by: rx.disposeBag)
        // t.rx.setDataSource(self).disposed(by: rx.disposeBag)
        t.xl.adapterWith(parentVC: nil)

        return t
    }
}

@objc(LXBaseTableVCKitExample)
open class LXBaseTableVC: LXBaseVC, LXBaseTableViewProtocol {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    let headerRefreshTrigger = PublishSubject<Void>()
    let footerRefreshTrigger = PublishSubject<Void>()

    let isHeaderLoading = BehaviorRelay(value: false)
    let isFooterLoading = BehaviorRelay(value: false)

    public lazy var table: LXBaseTableView = {
        return lazyTableView(style: .plain)
    }()

    var clearSelectionOnViewWillAppear = true
    public private(set) var style: UITableView.Style = UITableView.Style.plain
    // MARK: 🛠Life Cycle
    // required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    convenience init(vm: LXBaseVM?, navigator: LXNavigator, style: UITableView.Style = UITableView.Style.plain) {
        self.init(vm: vm, navigator: navigator)
        self.style = style
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if clearSelectionOnViewWillAppear {
            deselectSelectedRow()
        }
    }
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    open override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        // prepareTableView()
        // prepareUI()
    }
}

// MARK: 🌎LoadData
extension LXBaseTableVC {}

// MARK: 👀Public Actions
extension LXBaseTableVC {}

// MARK: 🔐Private Actions
private extension LXBaseTableVC {
    func deselectSelectedRow() {
        if let selectedIndexPaths = table.indexPathsForSelectedRows {
            selectedIndexPaths.forEach { self.table.deselectRow(at: $0, animated: false) }
        }
    }
}

// MARK: - 🍺UI Prepare & Masonry
public extension LXBaseTableVC {
    @objc func prepareTableView() {
        table.emptyDataSetSource = self
        table.emptyDataSetDelegate = self
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
        error.subscribe(onNext: { [weak self] error in
            self?.table.makeToast(error.description,
                                  title: error.title,
                                  image: R.image.icon_toast_warning(),
                                  completion: nil)
        })
        .disposed(by: rx.disposeBag)
    }
    override func prepareVM() {
        super.prepareVM()
        vm?.headerLoading.asObservable()
            .bind(to: isHeaderLoading)
            .disposed(by: rx.disposeBag)
        vm?.footerLoading.asObservable()
            .bind(to: isFooterLoading)
            .disposed(by: rx.disposeBag)

        Observable.of(isLoading.mapToVoid(),
                      emptyDataSet.imageTintColor.mapToVoid(),
                      languageChanged.asObservable())
        .merge()
        .subscribe(onNext: { [weak self] _ in
            self?.table.reloadEmptyDataSet()
        })
        .disposed(by: rx.disposeBag)
    }
    override func prepareUI() {
        super.prepareUI()
        // self.view.backgroundColor = .white
        // contentStackView.spacing = 0
        // contentStackView.insertArrangedSubview(table, at: 0)
        self.edgesForExtendedLayout = []
        self.automaticallyAdjustsScrollViewInsets = true
        if #available(iOS 11.0, *) {
            table.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }

    override func masonry() {
        super.masonry()
        table.snp.setLabel("\(self.xl.xl_typeName).table")
    }
}
