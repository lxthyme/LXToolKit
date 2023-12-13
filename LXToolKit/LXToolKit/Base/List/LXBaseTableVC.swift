//
//  LXBaseTableVC.swift
//  test
//
//  Created by lxthyme on 2023/3/25.
//
import UIKit
import KafkaRefresh
import RxSwift
import RxRelay
import RxDataSources
import Toast_Swift
import SnapKit

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

@objc(LXBaseKitTableVC)
open class LXBaseTableVC: LXBaseVC, LXBaseTableViewProtocol {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    public let headerRefreshTrigger = PublishSubject<Void>()
    public let footerRefreshTrigger = PublishSubject<Void>()
    
    public let isHeaderLoading = BehaviorRelay(value: false)
    public let isFooterLoading = BehaviorRelay(value: false)
    
    public lazy var table: LXBaseTableView = {
        return lazyTableView(style: .plain)
    }()
    
    public var clearSelectionOnViewWillAppear = true
    public private(set) var style: UITableView.Style = UITableView.Style.plain
    // MARK: 🛠Life Cycle
    // required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    convenience init(vm: LXBaseVM?, navigator: Navigator, style: UITableView.Style = UITableView.Style.plain) {
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
        basePrepareTableView()
        basePrepareVM()
        basePrepareUI()
        baseMasonry()
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
private extension LXBaseTableVC {
    func basePrepareTableView() {
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
            self?.table.makeToast(error.localizedDescription,
                                  title: "⚠️警告",
                                  image: nil,//R.image.icon_toast_warning(),
                                  completion: nil)
        })
        .disposed(by: rx.disposeBag)

        table.xl.registerCell(with: UITableViewCell.self)
        table.xl.registerHeaderOrFooter(UITableViewHeaderFooterView.self)
    }
    func basePrepareVM() {
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
    func basePrepareUI() {
        // self.view.backgroundColor = .white
        // contentStackView.spacing = 0
        // contentStackView.insertArrangedSubview(table, at: 0)
        self.edgesForExtendedLayout = []
        if #available(iOS 11.0, *) {
            table.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    func baseMasonry() {
        table.snp.setLabel("\(xl.typeNameString).table")
    }
}
