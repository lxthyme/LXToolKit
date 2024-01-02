//
//  LXNestedCell.swift
//  test
//
//  Created by lxthyme on 2021/9/26.
//

import UIKit

class LXNestedCell: UITableViewCell {
    // MARK: 📌UI
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1

        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 239, height: 239)
        layout.estimatedItemSize = CGSize(width: 239, height: 239)
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
    private lazy var collectionView: LXNestedCollectionView = {
        let v = LXNestedCollectionView(frame: .zero, collectionViewLayout: flowLayout)

        v.delegate = self
        v.dataSource = self
        // v.prefetchDataSource = self
        // v.dragDelegate = self
        // v.dropDelegate = self
        // v.isPrefetchingEnabled = true

        v.backgroundColor = .white
        // v.showsHorizontalScrollIndicator = true
        // v.showsVerticalScrollIndicator = true
        // v.alwaysBounceVertical = true
        // v.alwaysBounceHorizontal = true
        // v.allowsMultipleSelection = true

        // let header =  VPLoadingHeader.init(refreshingBlock: {
        //    [weak self] in
        //    guard let `self` = self else { return }
        //    //self.loadData(true)
        // })
        // v.mj_header = header
        // let footer = VPAutoLoadingFooter.init(refreshingBlock: {
        //    [weak self] in
        //    guard let `self` = self else { return }
        //    //self.loadData(false)
        // })
        // v.mj_footer = footer

        v.register(LXNestedCollectionCell.self, forCellWithReuseIdentifier: "LXNestedCollectionCell")
        return v
    }()
    lazy var dataList: [String] = {
        let ds = Array(repeating: "", count: 20)
        return ds
    }()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareUI()
     }
    // MARK: 🔗Vaiables
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        prepareUI()
    }

}

// MARK: 👀Public Actions
extension LXNestedCell {}

// MARK: 🔐Private Actions
private extension LXNestedCell {}

    // MARK: - ✈️UICollectionViewDataSource
extension LXNestedCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LXNestedCollectionCell", for: indexPath) as! LXNestedCollectionCell
//        <#cell.model = ds[indexPath.item]#>
        return cell
    }
}
    // MARK: - ✈️UICollectionViewDelegate
extension LXNestedCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension LXNestedCell: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView == collectionView {
//            dlog("-collectionView")
//        } else {
//            dlog("-ELSE")
//        }
//    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXNestedCell {
    func prepareUI() {
        [collectionView].forEach(self.contentView.addSubview)
        masonry()
    }

    func masonry() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
