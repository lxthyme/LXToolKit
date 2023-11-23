//
//  LXWikipediaSearchCell.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/27.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import LXToolKit
import RxSwift
import RxCocoa

class LXWikipediaSearchCell: LXBaseVMTableViewCell {
    // MARK: 📌UI
    private lazy var labTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private lazy var labSubtitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.XL.hexString("#555")
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 120)

        layout.headerReferenceSize = .zero
        layout.footerReferenceSize = .zero
        layout.sectionInset = .zero
        layout.sectionHeadersPinToVisibleBounds = true
        layout.sectionFootersPinToVisibleBounds = true
        return layout
    }()
    private lazy var collectionView: UICollectionView = {
        let v = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)

        //        v.delegate = self
        //        v.dataSource = self
        //        v.prefetchDataSource = self
        //        v.dragDelegate = self
        //        v.dropDelegate = self
        //        v.isPrefetchingEnabled = true

        v.backgroundColor = .white
        //        v.showsHorizontalScrollIndicator = true
        //        v.showsVerticalScrollIndicator = true
        //        v.alwaysBounceVertical = true
        //        v.alwaysBounceHorizontal = true
        //        v.allowsMultipleSelection = true

        //            let header =  VPLoadingHeader.init(refreshingBlock: {
        //                [weak self] in
        //                guard let `self` = self else { return }
        //    //            self.loadData(true)
        //            })
        //            v.mj_header = header
        //            let footer = VPAutoLoadingFooter.init(refreshingBlock: {
        //                [weak self] in
        //                guard let `self` = self else { return }
        //    //            self.loadData(false)
        //            })
        //            v.mj_footer = footer

        v.register(LXSingleImageCell.self, forCellWithReuseIdentifier: LXSingleImageCell.XL.xl_identifier)
        return v
    }()
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    // MARK: 🔗Vaiables
    let imageService = DefaultImageService.shared
    var viewModel: LXSearchResultViewModel? {
        didSet {
            //            guard let vm = viewModel else { return }
            //            let disposeBag = DisposeBag()
            //            vm.title
            //                .map(Optional.init)
            //                .drive(self.labTitle.rx.text)
            //                .disposed(by: disposeBag)
            //            labSubtitle.text = vm.searchResult.url.absoluteString
            //
            //            let reachabilityService = Dependencies.shared.reachabilityService
            //            vm.imageURLs
            //                .drive(self.collectionView.rx.items(cellIdentifier: LXSingleImageCell.xl_identifier, cellType: LXSingleImageCell.self)) {[weak self](_, url, cell) in
            //                    guard let `self` = self else { return }
            //                    cell.downloadableImage = self.imageService.imageFromURL(url, reachabilityService: reachabilityService)
            //            }
            //            .disposed(by: disposeBag)
            //            self.disposeBag = disposeBag

            var disposeBag = DisposeBag()

            guard let viewModel = viewModel else {
                return
            }

            viewModel.title
                .map(Optional.init)
                .drive(self.labTitle.rx.text)
                .disposed(by: disposeBag)

            self.labSubtitle.text = viewModel.searchResult.url.absoluteString

            let reachabilityService = Dependencies.shared.reachabilityService
            viewModel.imageURLs
                .drive(self.collectionView.rx.items(cellIdentifier: LXSingleImageCell.XL.xl_identifier, cellType: LXSingleImageCell.self)) { [weak self] (_, url, cell) in
                    cell.downloadableImage = self?.imageService.imageFromURL(url, reachabilityService: reachabilityService) ?? Observable.empty()
                }
                .disposed(by: disposeBag)

            // FIXME: 111
            //            self.disposeBag = disposeBag
        }
    }
    // override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    //     super.init(style: style, reuseIdentifier: reuseIdentifier)
    //
    //     prepareUI()
    // }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.viewModel = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// MARK: 👀Public Actions
extension LXWikipediaSearchCell {}

// MARK: 🔐Private Actions
private extension LXWikipediaSearchCell {}

// MARK: - 🍺UI Prepare & Masonry
extension LXWikipediaSearchCell {
    override func prepareUI() {
        super.prepareUI()
        [labTitle, labSubtitle, collectionView].forEach(self.contentView.addSubview)
        masonry()
    }

    override func masonry() {
        super.masonry()
        let edges = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        labTitle.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(edges)
            $0.right.lessThanOrEqualToSuperview().offset(-16)
        }
        labSubtitle.snp.makeConstraints {
            $0.top.equalTo(labTitle.snp.bottom).offset(8)
            $0.left.equalTo(labTitle)
            $0.right.lessThanOrEqualToSuperview().offset(-16)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(labSubtitle.snp.bottom).offset(8)
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(120)
        }
    }
}
