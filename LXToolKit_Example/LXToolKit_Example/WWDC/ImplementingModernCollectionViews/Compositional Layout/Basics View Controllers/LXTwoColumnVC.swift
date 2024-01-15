//
//  LXTwoColumnVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/8/9.
//
import UIKit

extension LXTwoColumnVC {
    enum Section {
        case main
    }
}

class LXTwoColumnVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var layout: UICollectionViewLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // item.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: 2)
        let spacing = CGFloat(10)
        group.interItemSpacing = .fixed(spacing)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        return cv
    }()
    // MARK: 🔗Vaiables
    private var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareCollectionView()
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LXTwoColumnVC {}

// MARK: 👀Public Actions
extension LXTwoColumnVC {}

// MARK: 🔐Private Actions
@available(iOS 14.0, *)
private extension LXTwoColumnVC {
    func generateDataSource() -> UICollectionViewDiffableDataSource<Section, Int> {
        let cellRegistration = UICollectionView.CellRegistration<LXTextCell, Int> { cell, indexPath, item in
            cell.labTitle.text = "\(item)"
            cell.contentView.backgroundColor = .cornflowerBlue
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1.0
            cell.labTitle.textAlignment = .center
            cell.labTitle.font = .preferredFont(forTextStyle: .title1)
        }
        return UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXTwoColumnVC {
    func prepareCollectionView() {
        if #available(iOS 14.0, *) {
            dataSource = generateDataSource()
        }
    }
    func prepareUI() {
        self.view.backgroundColor = .white
        navigationItem.title = "Two-Column Grid"

        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0..<94))
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
