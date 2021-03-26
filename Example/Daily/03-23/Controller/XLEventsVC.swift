//
//  XLEventsVC.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/24.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import ImageSlideshow
import HMSegmentedControl

enum EventSegments: Int {
    case received, performed

    var title: String {
        switch self {
            case .received: return R.string.localizabled.eventsReceivedSegmentTitle()
            case .performed: return R.string.localizabled.eventsPerformedSegmentTitle()
        }
    }
}

class XLEventsVC: XLBaseTableVC {
    // MARK: 📌UI
    private lazy var segmentControl: HMSegmentedControl = {
        let s = HMSegmentedControl(sectionTitles: [
            EventSegments.received.title,
            EventSegments.performed.title
        ])
        s.selectedSegmentIndex = 0
        return s
    }()
    private lazy var avatarSlideView: ImageSlideshow = {
        let v = ImageSlideshow()
        v.layer.cornerRadius = 40
        v.backgroundColor = .gray
        return v
    }()
    private lazy var headerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.hero.id = "TopHeaderViewID"
        return v
    }()
    // MARK: 🔗Vaiables
    let segmentSelection = BehaviorRelay<Int>(value: 0)
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
        bindViewModel()
        setupTableView()
    }

}

// MARK: 🌎LoadData
extension XLEventsVC {
    override func bindViewModel() {
        super.bindViewModel()
        guard let vm = vm as? XLEventsVM else { return }

        let segmentSelected = Observable
            .of(segmentSelection.map({ EventSegments(rawValue: $0) }).filterNil())
            .merge()
        let refresh = Observable
            .of(Observable.just(()),
                headerRefreshTrigger,
                segmentSelected.mapToVoid().skip(1))
            .merge()
        let input = XLEventsVM.Input(headerRefresh: refresh,
                                     footerRefresh: footerRefreshTriggr,
                                     segmentSelection: segmentSelected,
                                     selection: table.rx.modelSelected(XLEventCellVM.self).asDriver())

        let output = vm.transform(input: input)
        output.navigationTitle
            .drive(onNext: {[weak self] title in
                guard let `self` = self else { return }
                self.navigationTitle = title
            })
            .disposed(by: rx.disposeBag)
        output.hidesSegment
            .drive(onNext: {[weak self] hides in
                guard let `self` = self else { return }
                self.navigationItem.titleView = hides ? nil : self.segmentControl
            })
            .disposed(by: rx.disposeBag)
        output.imgURL
            .drive(onNext: {[weak self] url in
                guard let `self` = self else { return }
                if let url = url {
                    self.avatarSlideView.setImageInputs([url].map({ KingfisherSource(url: $0)}))
                    self.avatarSlideView.hero.id = url.absoluteString
                }
            })
            .disposed(by: rx.disposeBag)
        output.items
            .asDriver(onErrorJustReturn: [])
            .drive(table.rx.items(cellIdentifier: XLEventCell.xl.xl_identifier, cellType: XLEventCell.self)) { tableView, viewModel, cell in
                cell.bind(to: viewModel)
            }
            .disposed(by: rx.disposeBag)
//        output.userSelected
//        output.repoSelected
    }
}

// MARK: 👀Public Actions
extension XLEventsVC {}

// MARK: 🔐Private Actions
private extension XLEventsVC {}

// MARK: - 🍺UI Prepare & Masonry
private extension XLEventsVC {
    func setupTableView() {
        table.register(XLEventCell.self, forCellReuseIdentifier: XLEventCell.xl.xl_identifier)
    }
    func prepareUI() {
        self.view.backgroundColor = UIColor.white
        navigationItem.titleView = segmentControl

        languageChanged
            .subscribe(onNext: {[weak self] _ in
                guard let `self` = self else { return }
                Logger.debug("🛠1. onNext - languageChanged: ")
                self.segmentControl.sectionTitles = [EventSegments.received.title,
                                                     EventSegments.performed.title]
            })
            .disposed(by: rx.disposeBag)
        contentStackView.insertArrangedSubview(headerView, at: 0)
        [avatarSlideView].forEach(headerView.addSubview)
        masonry()
    }

    func masonry() {
        headerView.snp.setLabel("headerView")
        avatarSlideView.snp.setLabel("avatarSlideView")
        segmentControl.snp.makeConstraints {
            $0.width.equalTo(XLMacro.ScreenWidth - 16 * 2)
        }
        avatarSlideView.snp.makeConstraints {
            $0.top.centerX.bottom.equalToSuperview()
            $0.size.equalTo(80)
        }
    }
}
