//
//  LXItemBadgeSupplementaryVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/8/9.
//
import UIKit
import LXToolKit

extension LXItemBadgeSupplementaryVC {
    static let badgeElementKind = "badge-element-kind"
    enum Section {
        case main
    }

    struct Model: Hashable {
        let identifier = UUID()
        let title: String
        let badgeCount: Int

        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }
}

class LXItemBadgeSupplementaryVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var layout: UICollectionViewLayout = {
        let badgeAnchor = NSCollectionLayoutAnchor(edges: [.top, .trailing],
                                                   fractionalOffset: CGPoint(x: 0.3, y: -0.3))
        let badgeSize = NSCollectionLayoutSize(widthDimension: .absolute(20),
                                               heightDimension: .absolute(20))
        let badge = NSCollectionLayoutSupplementaryItem(layoutSize: badgeSize,
                                                        elementKind: LXItemBadgeSupplementaryVC.badgeElementKind,
                                                        containerAnchor: badgeAnchor)

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [badge])
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        // group.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20.0, leading: 20.0, bottom: 20.0, trailing: 20.0)

        return UICollectionViewCompositionalLayout(section: section)
    }()
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        // cv.delegate = self
        return cv
    }()
    // MARK: 🔗Vaiables
    private var dataSource: UICollectionViewDiffableDataSource<Section, Model>!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareCollectionView()
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LXItemBadgeSupplementaryVC {
    func dataFill() {}
}

// MARK: 👀Public Actions
extension LXItemBadgeSupplementaryVC {}

// MARK: 🔐Private Actions
@available(iOS 14.0, *)
private extension LXItemBadgeSupplementaryVC {
    func generateDataSource() -> UICollectionViewDiffableDataSource<Section, Model> {
        let cellRegistration = UICollectionView.CellRegistration<LXTextCell, Model> { cell, indexPath, model in
            cell.labTitle.text = "\(model.title)"
            cell.contentView.backgroundColor = .cornflowerBlue
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.contentView.layer.borderWidth = 1
            cell.contentView.layer.cornerRadius = 8
            cell.labTitle.textAlignment = .center
            cell.labTitle.font = .preferredFont(forTextStyle: .title1)
        }

        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<LXBadgeSupplementaryView>(elementKind: LXItemBadgeSupplementaryVC.badgeElementKind) { supplementaryView, elementKind, indexPath in
            guard let model = self.dataSource.itemIdentifier(for: indexPath) else { return }
            let hasBadgeCount = model.badgeCount > 0
            supplementaryView.labTitle.text = "\(model.badgeCount)"
            supplementaryView.isHidden = !hasBadgeCount
        }
        let dataSource = UICollectionViewDiffableDataSource<Section, Model>(collectionView: collectionView) { collectionView, indexPath, model in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: model)
        }
        dataSource.supplementaryViewProvider = {
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: $2)
        }
        return dataSource
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXItemBadgeSupplementaryVC {
    func prepareCollectionView() {
        if #available(iOS 14.0, *) {
            dataSource = generateDataSource()
        }
    }
    func prepareUI() {
        self.view.backgroundColor = .white
        navigationItem.title = "Item Badges"

        var snapshot = NSDiffableDataSourceSnapshot<Section, Model>()
        snapshot.appendSections([.main])
        let list = (0..<100).map { Model(title: "\($0)", badgeCount: Int.random(in: 0..<3)) }
        snapshot.appendItems(list)
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
