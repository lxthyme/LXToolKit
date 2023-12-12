//
//  LXGridVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/8/8.
//
import UIKit
import LXToolKit

// MARK: - 👀
extension LXGridVC {
    enum Section {
        case main
    }
}

class LXGridVC: LXBaseVC {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    var collectionView: UICollectionView! = nil
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LXGridVC {
    func dataFill() {}
}

// MARK: 👀Public Actions
extension LXGridVC {}

private extension LXGridVC {
    func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    func generateHierarchy() -> UICollectionView {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        cv.backgroundColor = .black
        return cv
    }
    func generateDataSource() -> UICollectionViewDiffableDataSource<Section, Int> {
        let cellRegistration = UICollectionView.CellRegistration<LXTextCell, Int> { cell, indexPath, itemIdentifier in
            cell.labTitle.text = "\(itemIdentifier)"
            cell.contentView.backgroundColor = .cornflowerBlue
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.labTitle.textAlignment = .center
            cell.labTitle.font = .preferredFont(forTextStyle: .title1)
        }

        return UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
    }
}

// MARK: 🔐Private Actions
private extension LXGridVC {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXGridVC {
    func prepareUI() {
        navigationItem.title = "Grid"
        self.view.backgroundColor = .white

        if #available(iOS 14.0, *) {
            self.collectionView = generateHierarchy()
            self.dataSource = generateDataSource()
            var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
            snapshot.appendSections([.main])
            snapshot.appendItems(Array(0..<94))
            dataSource.apply(snapshot, animatingDifferences: false)

            [collectionView].forEach(self.view.addSubview)
        } else {
            // Fallback on earlier versions
        }


        masonry()
    }

    func masonry() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
