//
//  LXEventsVC.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/2/18.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import LXToolKit
import RxSwift
import RxCocoa
import ImageSlideshow
import Hero
import RxDataSources

enum EventSegments: Int {
    case received, performed

    var title: String {
        switch self {
        case .received: return R.string.localizabled.eventsReceivedSegmentTitle()
        case .performed: return R.string.localizabled.eventsPerformedSegmentTitle()
        }
    }
}

class LXEventsVC: LXBaseMVVMTableVC {
    // MARK: 📌UI
    private lazy var segmentControl: LXSegmentedControl = {
        let s = LXSegmentedControl(sectionTitles: [
            EventSegments.received.title,
            EventSegments.performed.title,
        ])
        s.selectedSegmentIndex = 0
        return s
    }()
    private lazy var imgViewOwner: LXSlideImageView = {
        let iv = LXSlideImageView()
        iv.layer.cornerRadius = 40
        return iv
    }()
    private lazy var headerView: UIView = {
        let v = UIView()
        v.hero.id = "TopHeaderId"
        v.backgroundColor = .white
        return v
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
        prepareUI()
    }
    override func bindViewModel() {
        super.bindViewModel()
        guard let vm = viewModel as? LXEventsVM else { return }

        let segmentSelected = Observable
            .of(segmentControl.segmentSelection.map({ EventSegments(rawValue: $0)! }))
            .merge()
        let refresh = Observable
            .of(Observable.just(()),
                headerRefreshTrigger,
                segmentSelected.mapToVoid().skip(1)
            )
            .merge()
        let input = LXEventsVM.Input(headerRefresh: refresh,
                                     footerRefresh: footerRefreshTrigger,
                                     segmentSelection: segmentSelected,
                                     selection: table.rx.modelSelected(LXEventCellVM.self).asDriver())
        let output = vm.transform(input: input)
        output.navTitle
            .drive(onNext: {[weak self] title in
                self?.navigationTitle = title
            })
            .disposed(by: rx.disposeBag)
        output.hideSegment
            .drive(onNext: {[weak self] hide in
                self?.navigationItem.titleView = hide ? nil : self?.segmentControl
            })
            .disposed(by: rx.disposeBag)
        output.imgUrl
            .drive(onNext: {[weak self] url in
                if let url = url {
                    self?.imgViewOwner.setSources(sources: [url])
                    self?.imgViewOwner.hero.id = url.absoluteString
                }
            })
            .disposed(by: rx.disposeBag)
        output.dataList
            .asDriver(onErrorJustReturn: [])
            .drive(table.rx.items(cellIdentifier: LXEventCell.xl.xl_identifier, cellType: LXEventCell.self)) {tableView, vm, cell in
                cell.bind(to: vm)
            }
            .disposed(by: rx.disposeBag)
        // output.userSelected
        //     .drive(onNext: {[weak self] vm in
        //         self.navigator.show(segue: .userDetails(viewModel: vm), sender: self, transition: .detail)
        //     })
        //     .disposed(by: rx.disposeBag)
        // output.repos
    }
}

// MARK: 🌎LoadData
extension LXEventsVC {}

// MARK: 👀Public Actions
extension LXEventsVC {}

// MARK: 🔐Private Actions
private extension LXEventsVC {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXEventsVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        navigationItem.titleView = segmentControl

        languageChanged
            .subscribe(onNext: {[weak self] () in
                guard let `self` = self else { return }
                self.segmentControl.sectionTitles = [
                    EventSegments.received.title,
                    EventSegments.performed.title
                ]
            })
            .disposed(by: rx.disposeBag)

        headerView.theme.backgroundColor = themeService.attribute { $0.primaryDark }

        headerView.addSubview(imgViewOwner)
        [headerView, table].forEach(contentStackView.addArrangedSubview)

        table.xl.registerCell(with: LXEventCell.self)

        masonry()
    }

    func masonry() {
        segmentControl.snp.makeConstraints {
            $0.width.equalTo(250)
        }
        imgViewOwner.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Configs.BaseDimensions.inset)
            $0.center.equalToSuperview()
            $0.size.equalTo(80)
        }
        table.snp.makeConstraints {
            $0.top.equalTo(imgViewOwner.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
}
