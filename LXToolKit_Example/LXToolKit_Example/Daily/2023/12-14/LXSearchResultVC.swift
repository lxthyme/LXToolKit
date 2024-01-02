//
//  LXSearchResultVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/12/14.
//
import UIKit

private typealias Section = String
private typealias Item = Int

class LXSearchResultVC: UIViewController {
    // MARK: 📌UI
    public lazy var collectionView: UICollectionView = {
        let layout = generateLayout()
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: layout)
        // cv.backgroundColor = <#.systemGroupedBackground#>
        cv.delegate = self
        return cv
    }()
    // MARK: 🔗Vaiables
    private var dataSource: UICollectionViewDiffableDataSource<String, Int>!
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareCollectionView()
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LXSearchResultVC {}

// MARK: 👀Public Actions
extension LXSearchResultVC {}

// MARK: 🔐Private Actions
private extension LXSearchResultVC {}

// MARK: - 🔐
private extension LXSearchResultVC {
    func generateLayout() -> UICollectionViewLayout {
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
        // section.interGroupSpacing = <#8.0#>
        // section.contentInsets = NSDirectionalEdgeInsets(top: <#10.0#>, leading: <#10.0#>, bottom: <#10.0#>, trailing: <#10.0#>)

        return UICollectionViewCompositionalLayout(section: section)
    }
    func generateCollectionView() -> UICollectionView {
        let layout = generateLayout()
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: layout)
        // cv.backgroundColor = <#.systemGroupedBackground#>
        cv.delegate = self
        return cv
    }
    func generateDataSource() -> UICollectionViewDiffableDataSource<Section, Item> {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { cell, indexPath, item in
            // cell.labTitle.text = "\(<#item#>)"
            var contentConfig = cell.defaultContentConfiguration()
            contentConfig.text = "\(item)"
            cell.contentConfiguration = contentConfig

            let bgConfig: UIBackgroundConfiguration = .clear()
            cell.backgroundConfiguration = bgConfig
        }
        return UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
    }
    // dataSource.apply(snapshot, animatingDifferences: true)
    // private var snapshot: !
    func generateSnapshot() -> NSDiffableDataSourceSnapshot<Section, Item> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(["233"])
        snapshot.appendItems(Array(0..<100))
        dataSource.apply(snapshot, animatingDifferences: false)
        return snapshot
    }
}

// MARK: - ✈️UICollectionViewDelegate
extension LXSearchResultVC: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXSearchResultVC {
    func prepareCollectionView() {
        // collectionView = generateCollectionView()
        dataSource = generateDataSource()
        let snapshot = generateSnapshot()
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    func prepareUI() {
        self.view.backgroundColor = .XL.randomGolden
        // navigationItem.title = ""
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(systemItem: .search, primaryAction: UIAction(handler: {[weak self] _ in
                guard let self else { return }
                let searchVC = LXSearchVC()
                let nav = UINavigationController(rootViewController: searchVC)
                // nav.isNavigationBarHidden = true
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }))
        ]

        [collectionView].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
