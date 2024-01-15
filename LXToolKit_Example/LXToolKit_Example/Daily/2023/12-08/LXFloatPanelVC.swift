//
//  LXFloatPanelVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/12/11.
//
import UIKit
import FloatingPanel
import LXToolKit

private typealias Section = String
private typealias Item = Int

class LXFloatPanelVC: LXBaseVC {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<String, Int>!
    private var state: FloatingPanelState = .full
    private var isRemovalInteractionEnabled = false
    private var nearbyState: FloatingPanelState = .full
    private var contentMode: FloatingPanelController.ContentMode = .static
    // MARK: 🛠Life Cycle
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)

        showFloatPanel()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareCollectionView()
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LXFloatPanelVC {}

// MARK: 👀Public Actions
extension LXFloatPanelVC {}

// MARK: 🔐Private Actions
private extension LXFloatPanelVC {
    func showFloatPanel() {
        let fpc = FloatingPanelController()
        // FloatingPanelControllerDelegate
        // fpc.delegate = self

        let contentVC = LXSampleListVC()
        fpc.set(contentViewController: contentVC)
        fpc.isRemovalInteractionEnabled = isRemovalInteractionEnabled
        fpc.contentMode = contentMode

        fpc.track(scrollView: contentVC.collectionView)
        fpc.addPanel(toParent: self)
    }
}

// MARK: - 👀
// extension LXFloatPanelVC: Floatingpan {}

// MARK: - 🔐
@available(iOS 14.0, *)
private extension LXFloatPanelVC {
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

// MARK: - 🔐
@available(iOS 14.0, *)
private extension LXFloatPanelVC {
    func generateRightNavItemList() -> [UIBarButtonItem] {
        return [
            // UIBarButtonItem(title: "FloatingPanelBehavior", menu: UIMenu(children: [
            //     UIAction(title: "", handler: { _ in
            //         <#code#>
            //     })
            // ])),
            UIBarButtonItem(title: "", menu: UIMenu(children: [
            ])),
            UIBarButtonItem(title: "", menu: UIMenu(children: [
            ])),
            UIBarButtonItem(title: "", menu: UIMenu(children: [
            ])),
            UIBarButtonItem(title: "", menu: UIMenu(children: [
            ])),
        ]
    }
}

// MARK: - ✈️UICollectionViewDelegate
extension LXFloatPanelVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXFloatPanelVC {
    func prepareCollectionView() {
        if #available(iOS 14.0, *) {
        collectionView = generateCollectionView()
        dataSource = generateDataSource()
        let snapshot = generateSnapshot()
        dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    func prepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""
        if #available(iOS 14.0, *) {
            navigationItem.rightBarButtonItems = generateRightNavItemList()
        }

        [collectionView].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
