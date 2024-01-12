//
//  LXOrthogonalScrollingVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/8/10.
//
import UIKit
import LXToolKit

extension LXOrthogonalScrollingVC {}

class LXOrthogonalScrollingVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var layout: UICollectionViewLayout = {
        return UICollectionViewCompositionalLayout { sectionIdx, layoutEnv in
            // guard let layoutKind = <#SectionLayoutKind#>(rawValue: sectionIdx) else { return nil }
            // let columns = layoutKind.columnCount(for: layoutEnv.container.effectiveContentSize.width)

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

            let containerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85),
                                                            heightDimension: .fractionalHeight(0.4))
            let containerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: containerGroupSize,
                                                                    subitems: [leadingItem, trailingGroup])
            // <#group#>.contentInsets = NSDirectionalEdgeInsets(top: <#10.0#>, leading: <#10.0#>, bottom: <#10.0#>, trailing: <#10.0#>)

            let section = NSCollectionLayoutSection(group: containerGroup)
            section.orthogonalScrollingBehavior = .continuous
            // section.contentInsets = NSDirectionalEdgeInsets(top: <#10.0#>, leading: <#10.0#>, bottom: <#10.0#>, trailing: <#10.0#>)

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
    private var dataSource: UICollectionViewDiffableDataSource<Int, Int>!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareCollectionView()
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LXOrthogonalScrollingVC {
    func dataFill() {}
}

// MARK: 👀Public Actions
extension LXOrthogonalScrollingVC {}

// MARK: 🔐Private Actions
@available(iOS 14.0, *)
private extension LXOrthogonalScrollingVC {
    func generateDataSource() -> UICollectionViewDiffableDataSource<Int, Int> {
        let cellRegistration = UICollectionView.CellRegistration<LXTextCell, Int> { cell, indexPath, item in
            cell.labTitle.text = "\(indexPath.section), \(indexPath.item)"
            cell.contentView.backgroundColor = .cornflowerBlue
            // cell.contentView.layer.masksToBounds = true
            cell.contentView.layer.cornerRadius = 8
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.contentView.layer.borderWidth = 1
            cell.labTitle.textAlignment = .center
            cell.labTitle.font = .preferredFont(forTextStyle: .title1)
        }
        return UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
    }
}

// MARK: - ✈️UICollectionViewDelegate
extension LXOrthogonalScrollingVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXOrthogonalScrollingVC {
    func prepareCollectionView() {
        if #available(iOS 14.0, *) {
            dataSource = generateDataSource()
        }
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        let itemsPerSection = 30
        var identifierOffset = 0
        for section in 0..<5 {
            snapshot.appendSections([section])
            let maxIdentifier = identifierOffset + itemsPerSection
            snapshot.appendItems(Array(identifierOffset..<maxIdentifier))
            identifierOffset += itemsPerSection
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    func prepareUI() {
        self.view.backgroundColor = .white
        navigationItem.title = "Orthogonal Sections"

        [collectionView].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
