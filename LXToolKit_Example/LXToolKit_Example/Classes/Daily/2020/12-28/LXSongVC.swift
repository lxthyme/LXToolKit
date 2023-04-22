//
//  LXSongVC.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2020/12/29.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LXSongVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var imgViewLogo: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        layout.scrollDirection = .vertical
//        layout.itemSize = CGSize(width: 120, height: 120)
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.headerReferenceSize = .zero
        layout.footerReferenceSize = .zero
        layout.sectionInset = .zero
        layout.sectionHeadersPinToVisibleBounds = true
        layout.sectionFootersPinToVisibleBounds = true
        if #available(iOS 11.0, *) {
            layout.sectionInsetReference = .fromContentInset
        }
        return layout
    }()
    private lazy var collectionView: UICollectionView = {
        let v = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)

        v.delegate = self
        v.dataSource = self
        //v.prefetchDataSource = self
        //v.dragDelegate = self
        //v.dropDelegate = self
        //v.isPrefetchingEnabled = true
        v.contentInset = .zero

        v.backgroundColor = .white
        //v.showsHorizontalScrollIndicator = true
        //v.showsVerticalScrollIndicator = true
        //v.alwaysBounceVertical = true
        //v.alwaysBounceHorizontal = true
        //v.allowsMultipleSelection = true

        //let header =  VPLoadingHeader.init(refreshingBlock: {
        //    [weak self] in
        //    guard let `self` = self else { return }
        //    //self.loadData(true)
        //})
        //v.mj_header = header
        //let footer = VPAutoLoadingFooter.init(refreshingBlock: {
        //    [weak self] in
        //    guard let `self` = self else { return }
        //    //self.loadData(false)
        //})
        //v.mj_footer = footer
        if #available(iOS 13.0, *) {
            v.automaticallyAdjustsScrollIndicatorInsets = false
        } else {
            // Fallback on earlier versions
        }
        edgesForExtendedLayout = []
        automaticallyAdjustsScrollViewInsets = true

        v.register(LXEmptyCell.self, forCellWithReuseIdentifier: LXEmptyCell.xl.xl_identifier)
        v.register(LXSongRecordCell.self, forCellWithReuseIdentifier: LXSongRecordCell.xl.xl_identifier)
        return v
    }()
    // MARK: 🔗Vaiables
    var vm2: LXSongVM!
    lazy var cell = LXSongRecordCell()
    var publish = PublishSubject<String>()
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
        configUI()
            .bindingInput()
            .aimingOutput()
    }

}

// MARK: 🌎LoadData
extension LXSongVC {}

// MARK: 👀Public Actions
extension LXSongVC {
//    func 
}

// MARK: 🔐Private Actions
private extension LXSongVC {
    @discardableResult
    func configUI() -> LXSongVC {
        self.view.backgroundColor = .clear
//        self.imgViewLogo.image = UIImage.color
        return self
    }
    @discardableResult
    func bindingInput() -> LXSongVC {
        vm2 = LXSongVM(pageStatus: .songRecord,
                      apiService: SongRecordListService(),
                      disposeBag: rx.disposeBag)
        self.collectionView.rx.headerRefreshing.asDriver()
            .drive(vm2.input.headerRefresh)
            .disposed(by: rx.disposeBag)
        self.collectionView.rx.footerRefresh.asDriver()
            .drive(vm2.input.footerRefresh)
            .disposed(by: rx.disposeBag)
        self.collectionView.rx.retry
            .bind(to: vm2.input.retry)
            .disposed(by: rx.disposeBag)
        vm2.output.footerState
            .asDriver(onErrorJustReturn: (current: 0, pageSize: 18))
            .drive(self.collectionView.rx.footerEndRefreshWithNoMoreDataByPageSize)
            .disposed(by: rx.disposeBag)
        vm2.output.emptyData
            .asDriver(onErrorJustReturn: .success)
            .drive(self.collectionView.rx.isShowRetryView)
            .disposed(by: rx.disposeBag)
//        publish.bind(to: self.vm2.output.con)
        return self
    }
    @discardableResult
    func aimingOutput() -> LXSongVC {
        vm2.output.dataSource
//            .subscribe({ (<#Event<[LXSongCellVM]>#>) in
//                <#code#>
//            })
//            .subscribe(onNext: <#T##(([LXSongCellVM]) -> Void)?##(([LXSongCellVM]) -> Void)?##([LXSongCellVM]) -> Void#>, onError: <#T##((Error) -> Void)?##((Error) -> Void)?##(Error) -> Void#>, onCompleted: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>, onDisposed: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
            .subscribeNext(weak: self) { (vc) -> ([LXSongCellVM]) -> Void in
                return { _ in
                    vc.collectionView.rx.beginReloadData.onNext(())
                    vc.collectionView.rx.isShowRetryView.onNext(.success)
                }
            }
            .disposed(by: rx.disposeBag)
        self.collectionView.rx.itemSelected
            .debounce(.milliseconds(100), scheduler: MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] ip in
                guard let `self` = self,
                      let ds = try? self.vm2.output.dataSource.value(),
                      ds.count > 0 else { return }
                let vc = LXTestVC()
//                let record = ds[ip.row]
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: rx.disposeBag)

        return self
    }
}

// MARK: - ✈️UICollectionViewDataSource
extension LXSongVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return max(1, (try? self.vm2.output.dataSource.value().count) ?? 0)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let count = try? self.vm2.output.dataSource.value().count,
              count > 0 else {
            // swiftlint:disable:next force_cast
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LXEmptyCell.xl.xl_identifier, for: indexPath) as! LXEmptyCell
            // swiftlint:disable:previous force_cast
            cell.retryType = .noData
            return cell
        }
        // swiftlint:disable:next force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LXSongRecordCell.xl.xl_identifier, for: indexPath) as! LXSongRecordCell
        self.cell = cell
        // swiftlint:disable:previous force_cast
        if let d = try? self.vm2.output.dataSource.value()[indexPath.row] {
            cell.bindResult(d)
        }
        return cell
    }
}
// MARK: - ✈️UICollectionViewDelegate
extension LXSongVC: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionElementKindSectionHeader {
//            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: <#UICollectionReusableView#>.xl_identifier, for: indexPath)
//            return headerView
//        } else {
//            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: <#UICollectionReusableView#>.xl_identifier, for: indexPath)
//            return footerView
//        }
//    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let cell = collectionView.cellForItem(at: indexPath) as? LXSongRecordCell
//
        if let vm = cell?.vm {
            Observable.just(vm).map { tmp in
                tmp
            }
        self.cell.detaObservable.onNext(vm)
        }
    }
}
// MARK: - ✈️UICollectionViewDelegateFlowLayout
extension LXSongVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let count = try? self.vm2.output.dataSource.value().count,
              count > 0 else {
            return collectionView.bounds.size
        }
        return CGSize(width: kScreenWidth / 3.0, height: kScreenHeight / 3.0 / 1.6 + 40)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 30
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 20
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 0)
    }
}

// MARK: - 🍺UI Prepare & Masonry
extension LXSongVC {
    override func prepareUI() {
        super.prepareUI()
        self.view.backgroundColor = UIColor.white
        self.title = "Song Record"

        [collectionView].forEach(self.view.addSubview)
        masonry()
    }

    override func masonry() {
        super.masonry()
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
