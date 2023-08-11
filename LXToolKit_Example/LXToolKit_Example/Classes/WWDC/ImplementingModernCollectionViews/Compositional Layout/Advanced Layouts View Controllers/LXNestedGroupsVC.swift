//
//  LXNestedGroupsVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/8/10.
//
import UIKit
import LXToolKit

@available(iOS 14.0, *)
extension LXNestedGroupsVC {
    enum Section {
        case main
    }
}

@available(iOS 14.0, *)
class LXNestedGroupsVC: LXBaseVC {
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

            let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                         heightDimension: .fractionalHeight(0.4))
            let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: nestedGroupSize,
                                                           subitems: [leadingItem, trailingGroup])
            // group.contentInsets = NSDirectionalEdgeInsets(top: <#10.0#>, leading: <#10.0#>, bottom: <#10.0#>, trailing: <#10.0#>)

            let section = NSCollectionLayoutSection(group: nestedGroup)
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
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, Int> = {
        let cellRegistration = UICollectionView.CellRegistration<LXTextCell, Int> { cell, indexPath, item in
            cell.labTitle.text = "\(indexPath.section), \(indexPath.item)"
            // cell.contentView.layer.masksToBounds = true
            cell.contentView.backgroundColor = .cornflowerBlue
            cell.contentView.layer.cornerRadius = 8.0
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.contentView.layer.borderWidth = 1
            cell.labTitle.font = .preferredFont(forTextStyle: .title1)
        }
        return UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
    }()
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
        prepareSnapshot()
    }

}

// MARK: 🌎LoadData
@available(iOS 14.0, *)
extension LXNestedGroupsVC {
    func dataFill() {}
}

// MARK: 👀Public Actions
@available(iOS 14.0, *)
extension LXNestedGroupsVC {}

// MARK: 🔐Private Actions
@available(iOS 14.0, *)
private extension LXNestedGroupsVC {}

// MARK: - ✈️UICollectionViewDelegate
@available(iOS 14.0, *)
extension LXNestedGroupsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}


// MARK: - 🍺UI Prepare & Masonry
@available(iOS 14.0, *)
extension LXNestedGroupsVC {
    func prepareSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0..<100))
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    override func prepareUI() {
        super.prepareUI()
        self.view.backgroundColor = .white
        navigationItem.title = "Nested Groups"

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
