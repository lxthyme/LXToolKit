//
//  LXDistinctSectionsVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/8/9.
//
import UIKit
import LXToolKit

@available(iOS 14.0, *)
extension LXDistinctSectionsVC {
    enum SectionLayoutKind: Int, CaseIterable {
        case list, grid5, grid3

        var columnCount: Int {
            switch self {
            case .grid3: return 3
            case .grid5: return 5
            case .list: return 1
            }
        }
    }
}

@available(iOS 14.0, *)
class LXDistinctSectionsVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var layout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { sectioIdx, layoutEnv in
            guard let sectionLayoutKind = SectionLayoutKind(rawValue: sectioIdx) else { return nil }
            let columns = sectionLayoutKind.columnCount

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

            let groupHeight = columns == 1 ? NSCollectionLayoutDimension.absolute(44) : NSCollectionLayoutDimension.fractionalWidth(0.2)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitem: item,
                                                           count: columns)

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)

            return section
        }
        return layout
    }()
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        return cv
    }()
    // MARK: 🔗Vaiables
    private lazy var dataSource: UICollectionViewDiffableDataSource<SectionLayoutKind, Int> = {
        let listCellRegistration = UICollectionView.CellRegistration<LXTextCell, Int> { cell, indexPath, item in
            cell.labTitle.text = "\(item)"
        }
        let textCellRegistration = UICollectionView.CellRegistration<LXTextCell, Int> { cell, indexPath, item in
            cell.labTitle.text = "\(item)"
            cell.contentView.backgroundColor = .cornflowerBlue
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1.0
            cell.layer.cornerRadius = SectionLayoutKind(rawValue: indexPath.section)! == .grid5 ? 8 : 0
            cell.labTitle.textAlignment = .center
            cell.labTitle.font = .preferredFont(forTextStyle: .title1)
        }
        return UICollectionViewDiffableDataSource<SectionLayoutKind, Int>(collectionView: collectionView) { collectionView, indexPath, item in
            return SectionLayoutKind(rawValue: indexPath.section)! == .list ? collectionView.dequeueConfiguredReusableCell(using: listCellRegistration, for: indexPath, item: item) : collectionView.dequeueConfiguredReusableCell(using: textCellRegistration, for: indexPath, item: item)
        }
    }()
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: 🌎LoadData
@available(iOS 14.0, *)
extension LXDistinctSectionsVC {
    func dataFill() {}
}

// MARK: 👀Public Actions
@available(iOS 14.0, *)
extension LXDistinctSectionsVC {}

// MARK: 🔐Private Actions
@available(iOS 14.0, *)
private extension LXDistinctSectionsVC {}

// MARK: - 🍺UI Prepare & Masonry
@available(iOS 14.0, *)
extension LXDistinctSectionsVC {
    override func prepareUI() {
        super.prepareUI()
        self.view.backgroundColor = .white
        navigationItem.title = "Distinct Sections"

        let itemsPerSection = 10
        var snapshot = NSDiffableDataSourceSnapshot<SectionLayoutKind, Int>()
        SectionLayoutKind.allCases.forEach {
            snapshot.appendSections([$0])
            let itemOffset = $0.rawValue * itemsPerSection
            let itemUpperbound = itemOffset + itemsPerSection
            snapshot.appendItems(Array(itemOffset..<itemUpperbound))
        }
        dataSource.apply(snapshot, animatingDifferences: false)

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
