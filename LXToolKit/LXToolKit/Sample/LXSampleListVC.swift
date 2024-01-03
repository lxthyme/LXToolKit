//
//  LXSampleListVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/12/8.
//
import UIKit

fileprivate typealias Section = String

public struct LXSampleItem: Hashable {
    public var title: String
    public var content: String?

    public init(title: String, content: String? = nil) {
        self.title = title
        self.content = content
    }
}

open class LXSampleListVC: LXBaseVC {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    public lazy var collectionView: UICollectionView = {
        let layout = generateLayout()
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: layout)
        // cv.backgroundColor = <#.systemGroupedBackground#>
        cv.delegate = self
        return cv
    }()
    private var dataList: [LXSampleItem] = []
    private var dataSource: UICollectionViewDiffableDataSource<Section, LXSampleItem>?
    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareCollectionView()
        prepareUI()
    }
    open override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        let snapshot = generateSnapshot(list: dataList)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }

}

// MARK: 🌎LoadData
public extension LXSampleListVC {
    func dataFill(list: [LXSampleItem]) {
        dataList = list
    }
}

// MARK: 👀Public Actions
extension LXSampleListVC {
    // func suspendTransitionAnimator(_ suspended: Bool) {}
    // var transitionAnimator: UIViewPropertyAnimator? {}
    func show(animated: Bool = false, completion: (() -> Void)? = nil) {

    }
}

// MARK: 🔐Private Actions
private extension LXSampleListVC {}

// MARK: - 🔐
private extension LXSampleListVC {
    func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // item.contentInsets = NSDirectionalEdgeInsets(top: <#10.0#>, leading: <#10.0#>, bottom: <#10.0#>, trailing: <#10.0#>)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(144))
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
    func generateDataSource() -> UICollectionViewDiffableDataSource<Section, LXSampleItem> {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, LXSampleItem> { cell, indexPath, item in
            // cell.labTitle.text = "\(<#item#>)"
            var contentConfig = cell.defaultContentConfiguration()
            contentConfig.text = item.title
            contentConfig.secondaryText = item.content
            contentConfig.textProperties.numberOfLines = 0
            contentConfig.secondaryTextProperties.numberOfLines = 0
            cell.contentConfiguration = contentConfig

            let bgConfig: UIBackgroundConfiguration = .clear()
            cell.backgroundConfiguration = bgConfig
        }
        return UICollectionViewDiffableDataSource<Section, LXSampleItem>(collectionView: collectionView) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
    }
    // dataSource.apply(snapshot, animatingDifferences: true)
    // private var snapshot: !
    func generateSnapshot(list: [LXSampleItem]) -> NSDiffableDataSourceSnapshot<Section, LXSampleItem> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, LXSampleItem>()
        list.forEach { item in
            snapshot.appendSections([item.title])
            snapshot.appendItems([item], toSection: item.title)
        }
        return snapshot
    }
}

// MARK: - ✈️UICollectionViewDelegate
extension LXSampleListVC: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXSampleListVC {
    func prepareCollectionView() {
        // collectionView = generateCollectionView()
        dataSource = generateDataSource()
    }
    func prepareUI() {
        self.view.backgroundColor = .XL.randomGolden
        // navigationItem.title = ""

        [collectionView].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
