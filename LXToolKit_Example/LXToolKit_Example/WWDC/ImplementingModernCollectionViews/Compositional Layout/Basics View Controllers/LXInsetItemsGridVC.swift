//
//  LXInsetItemsGridVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/8/9.
//
import UIKit

extension LXInsetItemsGridVC {
    enum Section {
        case main
    }
}

class LXInsetItemsGridVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var layout: UICollectionViewLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
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
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, Int> = {
        let cellRegistration = UICollectionView.CellRegistration<LXTextCell, Int> { cell, indexPath, itemIdentifier in
            cell.labTitle.text = "\(itemIdentifier)"
            cell.contentView.backgroundColor = .cornflowerBlue
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1.0
            cell.labTitle.textAlignment = .center
            cell.labTitle.font = .preferredFont(forTextStyle: .title1)
        }
        return UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
    }()
    // var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
    // snapshot.appendSections([.main])
    // snapshot.appendItems(Array(0..<94))
    // dataSource.apply(snapshot, animatingDifferences: false)
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
    }

}

// MARK: 🌎LoadData
extension LXInsetItemsGridVC {}

// MARK: 👀Public Actions
extension LXInsetItemsGridVC {}

// MARK: 🔐Private Actions
private extension LXInsetItemsGridVC {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXInsetItemsGridVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        navigationItem.title = "Inset Items Grid"

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
