//
//  LXBaseCollectionViewVC.swift
//  LXToolKit
//
//  Created by lxthyme on 2022/2/7.
//

import UIKit

class LXBaseCollectionViewVC: LXBaseVC {
    // MARK: UI
    public lazy var collectionView: UICollectionView = {
        return lazyCollectionView(collectionViewLayout: lazyLayout())
    }()
}

// MARK: LoadData
extension LXBaseCollectionViewVC {}

// MARK: Public Actions
extension LXBaseCollectionViewVC {}

// MARK: Private Actions
private extension LXBaseCollectionViewVC {}

// MARK: - UICollectionView init
private extension LXBaseCollectionViewVC {
    func lazyLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = .zero
        layout.footerReferenceSize = .zero
        layout.sectionInset = .zero
        if #available(iOS 11.0, *) {
            layout.sectionInsetReference = .fromContentInset
        }
        layout.sectionHeadersPinToVisibleBounds = true
        layout.sectionFootersPinToVisibleBounds = true

        return layout
    }
    func lazyCollectionView(frame: CGRect = .zero, collectionViewLayout layout: UICollectionViewFlowLayout) -> UICollectionView {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        // cv.dataSource = self
        // cv.delegate = self
        // cv.prefetchDataSource
        return cv
    }
}
