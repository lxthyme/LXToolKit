//
//  LXOrthogonalBehaviorVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/8/10.
//
import UIKit
import LXToolKit

extension LXOrthogonalBehaviorVC {
    static let headerElementKind = "header-element-kind"

    enum SectionKind: Int, CaseIterable {
        case continuous, continuousGroupLeadingBoundary, paging, groupPaging, groupPagingCentered, none

        func orthogonalScrollingBehavior() -> UICollectionLayoutSectionOrthogonalScrollingBehavior {
            switch self {
            case .none: return .none
            case .continuous: return .continuous
            case .continuousGroupLeadingBoundary: return .continuousGroupLeadingBoundary
            case .paging: return .paging
            case .groupPaging: return .groupPaging
            case .groupPagingCentered: return .groupPagingCentered
            }
        }
    }
}

class LXOrthogonalBehaviorVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var layout: UICollectionViewLayout = {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        return UICollectionViewCompositionalLayout { sectionIdx, layoutEnv in
            guard let sectionKind = SectionKind(rawValue: sectionIdx) else { fatalError("unknown section kind") }
            // let columns = sectionKind.columnCount(for: layoutEnv.container.effectiveContentSize.width)

            let leadingItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                                  heightDimension: .fractionalHeight(1.0))
            let leadingItem = NSCollectionLayoutItem(layoutSize: leadingItemSize)
            leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)

            let trailingItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                          heightDimension: .fractionalHeight(0.3))
            let trailingItem = NSCollectionLayoutItem(layoutSize: trailingItemSize)
            trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)

            let trailingGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                                   heightDimension: .fractionalHeight(1.0))
            let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: trailingGroupSize,
                                                           subitem: trailingItem,
                                                           count: 2)
            // group.contentInsets = NSDirectionalEdgeInsets(top: <#10.0#>, leading: <#10.0#>, bottom: <#10.0#>, trailing: <#10.0#>)

            let orthogonallyScrolls = sectionKind.orthogonalScrollingBehavior() != .none
            let containerGroupFractionWidth = orthogonallyScrolls ? CGFloat(0.85) : CGFloat(1.0)
            let containerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(containerGroupFractionWidth),
                                                            heightDimension: .fractionalHeight(0.4))
            let containerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: containerGroupSize,
                                                                   subitems: [leadingItem, trailingGroup])
            // <#group#>.contentInsets = NSDirectionalEdgeInsets(top: <#10.0#>, leading: <#10.0#>, bottom: <#10.0#>, trailing: <#10.0#>)

            let section = NSCollectionLayoutSection(group: containerGroup)
            section.orthogonalScrollingBehavior = sectionKind.orthogonalScrollingBehavior()
            // section.contentInsets = NSDirectionalEdgeInsets(top: <#10.0#>, leading: <#10.0#>, bottom: <#10.0#>, trailing: <#10.0#>)

            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .estimated(44.0))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                            elementKind: LXOrthogonalBehaviorVC.headerElementKind,
                                                                            alignment: .top)
            // sectionHeader.pinToVisibleBounds = true
            // sectionHeader.zIndex = 2
            section.boundarySupplementaryItems = [sectionHeader]

            return section
        }
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
            cell.contentView.backgroundColor = .cornflowerBlue
            // cell.contentView.layer.masksToBounds = true
            cell.contentView.layer.cornerRadius = 8.0
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.contentView.layer.borderWidth = 1
            cell.labTitle.textAlignment = .center
            cell.labTitle.font = .preferredFont(forTextStyle: .title1)
        }
        let dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }

        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<LXTitleHeaderView>(elementKind: LXOrthogonalBehaviorVC.headerElementKind) { supplementaryView, elementKind, indexPath in
            // guard let model = self.dataSource.itemIdentifier(for: indexPath) else { return }
            let sectionKind = SectionKind(rawValue: indexPath.section)
            supplementaryView.labTitle.text = "." + String(describing: sectionKind)
        }
        dataSource.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: indexPath)
        }
        return dataSource
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
        prepareSnapshot()
    }

}

// MARK: 🌎LoadData
extension LXOrthogonalBehaviorVC {
    func dataFill() {}
}

// MARK: 👀Public Actions
extension LXOrthogonalBehaviorVC {}

// MARK: 🔐Private Actions
private extension LXOrthogonalBehaviorVC {}

// MARK: - ✈️UICollectionViewDelegate
extension LXOrthogonalBehaviorVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXOrthogonalBehaviorVC {
    func prepareSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        let itemsPerSection = 18
        var identifierOffset = 0
        SectionKind.allCases.forEach {
            snapshot.appendSections([$0.rawValue])
            let maxIdentifier = identifierOffset + itemsPerSection
            snapshot.appendItems(Array(identifierOffset..<maxIdentifier))
            identifierOffset += itemsPerSection
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    func prepareUI() {
        self.view.backgroundColor = .white
        navigationItem.title = "Orthogonal Section Behaviors"

        [collectionView].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
