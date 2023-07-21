//
//  LXWikipediaImageSearchVC.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import LXToolKit
import RxSwift
import RxCocoa

private class MyView: UIView {
    // MARK: UI
    private lazy var labEmpty: UILabel = {
        let label = UILabel()
        label.text = """
        This app transforms Wikipedia into image search engine.
        It uses Wikipedia search API to find content and scrapes the HTML of those pages for image URLs.
        This is only showcase app, not intended for production purposes.
        """
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.xl.hex("#555")
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private lazy var searchBar: UISearchBar = {
        let v = UISearchBar()
        
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
        
        //        t.delegate = self
        //        t.dataSource = self
        
        t.register(LXWikipediaSearchCell.self, forCellReuseIdentifier: LXWikipediaSearchCell.xl.xl_identifier)
        
        return t
    }()
    private lazy var contentStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.alignment = .fill
        return v
    }()
    lazy var dataList: [String] = {
        let ds = Array(repeating: "", count: 3)
        return ds
    }()
    // MARK: Vaiables
    private weak var vc: LXWikipediaImageSearchVC?
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override private init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(vc: LXWikipediaImageSearchVC) {
        self.init(frame: .zero)
        self.vc = vc
        
        prepareUI()
        
        prepareTableDataSource()
        prepareKeyboardDismissesOnScroll()
        prepareNavigateOnRowClick()
        prepareActivityIndicatorsShow()
    }
    
}

// MARK: LoadData
extension MyView {}

// MARK: Public Actions
extension MyView {}

// MARK: Private Actions
private extension MyView {
    func toggleVCStatus(shouldShowEmpty: Bool) {
        labEmpty.isHidden = !shouldShowEmpty
        table.isHidden = shouldShowEmpty
    }
    func prepareTableDataSource() {
        table.rowHeight = 194
        table.xl.hideEmptyCells()
        
        let table = self.table
        
        let api = DefaultWikipediaAPI.shared
        let result = searchBar.rx.text.orEmpty
            .asDriver()
        //            .throttle(.milliseconds(300))
            .throttle(.seconds(1))
            .distinctUntilChanged()
            .flatMapLatest { query in
                api.getSearchResults(query)
                //                    .retry(3)
                    .retryOnBecomesReachable([], reachabilityService: Dependencies.shared.reachabilityService)
                    .startWith([])
                    .asDriver(onErrorJustReturn: [])
            }
            .map { result in
                result.map(LXSearchResultViewModel.init)
            }
        
        result
            .drive(table.rx.items(cellIdentifier: LXWikipediaSearchCell.xl.xl_identifier, cellType: LXWikipediaSearchCell.self)) {(_, vm, cell) in
                cell.viewModel = vm
            }
            .disposed(by: rx.disposeBag)
        
        result
            .map { $0.count != 0 }
            .drive(self.labEmpty.rx.isHidden)
            .disposed(by: rx.disposeBag)
        
        //        result
        //            .map { $0.count <= 0 }
        //            .drive(self.table.rx.isHidden)
        //            .disposed(by: disposeBag)
    }
    func prepareKeyboardDismissesOnScroll() {
        table.rx.contentOffset
            .asDriver()
            .drive(onNext: {[weak self] _ in
                guard let `self` = self else { return }
                if self.searchBar.isFirstResponder {
                    self.searchBar.resignFirstResponder()
                }
            })
            .disposed(by: rx.disposeBag)
    }
    func prepareNavigateOnRowClick() {
        let wireframe = DefaultWireframe.shared
        
        table.rx.modelSelected(LXSearchResultViewModel.self)
            .asDriver()
            .drive(onNext: { searchResult in
                wireframe.open(url: searchResult.searchResult.url)
            })
            .disposed(by: rx.disposeBag)
    }
    func prepareActivityIndicatorsShow() {
        Driver.combineLatest(
            DefaultWikipediaAPI.shared.loadingWikipediaData,
            DefaultImageService.shared.loadingImage) { $0 || $1 }
            .distinctUntilChanged()
            .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: rx.disposeBag)
    }
}

// MARK: - UI Prepare & Masonry
private extension MyView {
    func prepareUI() {
        self.backgroundColor = .white
        //        table.snp.removeConstraints()
        //        toggleVCStatus(shouldShowEmpty: true)
        [searchBar, table, labEmpty].forEach(contentStackView.addArrangedSubview)
        self.addSubview(contentStackView)
        masonry()
    }
    func masonry() {
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        //        searchBar.snp.remakeConstraints {
        //            $0.top.left.right.equalToSuperview()
        //        }
        //        table.snp.remakeConstraints {
        //            $0.top.equalTo(searchBar.snp.bottom)
        //            $0.left.right.bottom.equalToSuperview()
        //        }
        //        labEmpty.snp.remakeConstraints {
        //            $0.top.greaterThanOrEqualTo(searchBar.snp.bottom)
        //            $0.left.greaterThanOrEqualToSuperview().offset(32)
        //            $0.right.lessThanOrEqualToSuperview().offset(-32)
        //            $0.bottom.lessThanOrEqualToSuperview().offset(-64)
        //            $0.center.equalToSuperview()
        //        }
    }
}

class LXWikipediaImageSearchVC: LXBaseVC {
    private typealias CustomView = MyView
    // MARK: UI
    private lazy var myView: CustomView = {
        return CustomView(vc: self)
    }()
    // MARK: Vaiables
    // MARK: Life Cycle
    override func loadView() {
        view = myView
    }
    // override func viewWillAppear(_ animated: Bool) {
    //     super.viewWillAppear(animated)
    // }
    // override func viewDidAppear(_ animated: Bool) {
    //     super.viewDidAppear(animated)
    // }
    // override func viewWillDisappear(_ animated: Bool) {
    //     super.viewWillDisappear(animated)
    // }
    // override func viewDidDisappear(_ animated: Bool) {
    //     super.viewDidDisappear(animated)
    // }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        prepareUI()
    }
}

// MARK: LoadData
extension LXWikipediaImageSearchVC {}

// MARK: Public Actions
extension LXWikipediaImageSearchVC {}

// MARK: Private Actions
private extension LXWikipediaImageSearchVC {}

// MARK: - UI Prepare & Masonry
extension LXWikipediaImageSearchVC {
    override open func prepareUI() {
        super.prepareUI()
        //[<#table#>].forEach(self.view.addSubview)
        masonry()
    }
    
    override open func masonry() {
        super.masonry()
    }
}
