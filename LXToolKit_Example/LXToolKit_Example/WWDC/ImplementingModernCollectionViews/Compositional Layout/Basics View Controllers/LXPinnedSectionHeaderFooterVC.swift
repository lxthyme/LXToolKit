//
//  LXPinnedSectionHeaderFooterVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/8/10.
//
import UIKit
import LXToolKit

extension LXPinnedSectionHeaderFooterVC {
    static let sectionHeaderElementKind = "section-header-element-kind"
    static let sectionFooterElementKind = "section-footer-element-kind"
}

class LXPinnedSectionHeaderFooterVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var layout: UICollectionViewLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // item.contentInsets = NSDirectionalEdgeInsets(top: <#10.0#>, leading: <#10.0#>, bottom: <#10.0#>, trailing: <#10.0#>)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        // group.contentInsets = NSDirectionalEdgeInsets(top: <#10.0#>, leading: <#10.0#>, bottom: <#10.0#>, trailing: <#10.0#>)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(44))
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(44.0))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: LXPinnedSectionHeaderFooterVC.sectionHeaderElementKind,
                                                                        alignment: .top)
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize,
                                                                        elementKind: LXPinnedSectionHeaderFooterVC.sectionFooterElementKind,
                                                                        alignment: .bottom)
        sectionHeader.pinToVisibleBounds = true
        sectionHeader.zIndex = 2
        section.boundarySupplementaryItems = [sectionHeader, sectionFooter]

        return UICollectionViewCompositionalLayout(section: section)
    }()
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        cv.delegate = self
        return cv
    }()
    // MARK: 🔗Vaiables
    private lazy var dataSource: UICollectionViewDiffableDataSource<Int, Int> = {
        let cellRegistration = UICollectionView.CellRegistration<LXTextCell, Int> { cell, indexPath, item in
            cell.labTitle.text = "\(indexPath.section), \(indexPath.item)"
        }
        let headerRegistration = UICollectionView.SupplementaryRegistration<LXTitleHeaderView>(elementKind: LXPinnedSectionHeaderFooterVC.sectionHeaderElementKind) { supplementaryView, elementKind, indexPath in
            // guard let model = self.dataSource.itemIdentifier(for: indexPath) else { return }
            supplementaryView.labTitle.text = "\(elementKind) for section \(indexPath.section)"
            supplementaryView.backgroundColor = .lightGray
            supplementaryView.layer.borderColor = UIColor.black.cgColor
            supplementaryView.layer.borderWidth = 1.0
        }
        let footerRegistration = UICollectionView.SupplementaryRegistration<LXTitleHeaderView>(elementKind: LXPinnedSectionHeaderFooterVC.sectionFooterElementKind) { supplementaryView, elementKind, indexPath in
            // guard let model = self.dataSource.itemIdentifier(for: indexPath) else { return }
            supplementaryView.labTitle.text = "\(elementKind) for section \(indexPath.section)"
            supplementaryView.backgroundColor = .lightGray
            supplementaryView.layer.borderColor = UIColor.black.cgColor
            supplementaryView.layer.borderWidth = 1.0
        }
        let dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        dataSource.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: elementKind == LXPinnedSectionHeaderFooterVC.sectionHeaderElementKind ? headerRegistration : footerRegistration, for: indexPath)
        }
        return dataSource
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LXPinnedSectionHeaderFooterVC {
    func dataFill() {}
}

// MARK: 👀Public Actions
extension LXPinnedSectionHeaderFooterVC {}

// MARK: 🔐Private Actions
private extension LXPinnedSectionHeaderFooterVC {}

// MARK: - ✈️UICollectionViewDelegate
extension LXPinnedSectionHeaderFooterVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXPinnedSectionHeaderFooterVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        navigationItem.title = "Pinned Section Headers"

        let itemsPerSection = 5
        var itemOffset = 0
        let sections = Array(0..<5)
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        sections.forEach {
            snapshot.appendSections([$0])
            snapshot.appendItems(Array(itemOffset..<itemOffset + itemsPerSection))
            itemOffset += itemsPerSection
        }
        dataSource.apply(snapshot, animatingDifferences: false)

        [collectionView].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
