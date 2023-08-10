//
//  LXOutlineVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/8/8.
//
import UIKit
import LXToolKit

// MARK: - 🔐
@available(iOS 14.0, *)
extension LXOutlineVC {
    enum Section {
        case main
    }
    class OutlineItem: Hashable {
        private let identifier = UUID()
        let title: String
        let subitems: [OutlineItem]
        let outlineVC: UIViewController.Type?

        init(title: String, vc: UIViewController.Type? = nil, subitems: [OutlineItem] = []) {
            self.title = title
            self.subitems = subitems
            self.outlineVC = vc
        }
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
        static func == (lhs: LXOutlineVC.OutlineItem, rhs: LXOutlineVC.OutlineItem) -> Bool {
            return lhs.identifier == rhs.identifier
        }
    }
}

@available(iOS 14.0, *)
class LXOutlineVC: LXBaseVC {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    private lazy var menuItems: [OutlineItem] = {
        return [
            OutlineItem(title: "Compositional Layout", subitems: [
                OutlineItem(title: "Getting Started", subitems: [
                    OutlineItem(title: "Grid", vc: LXGridVC.self),
                    OutlineItem(title: "Inset Items Grid", vc: LXInsetItemsGridVC.self),
                    OutlineItem(title: "Two-Column Grid", vc: LXTwoColumnVC.self),
                    OutlineItem(title: "Per-Section Layout", subitems: [
                        OutlineItem(title: "Distinct Sections", vc: LXDistinctSectionsVC.self),
                        OutlineItem(title: "Adaptive Sections", vc: LXAdaptiveSectionsVC.self),
                    ]),
                ]),
                OutlineItem(title: "Advanced Layouts", subitems: [
                    OutlineItem(title: "Supplementary Views", subitems: [
                        OutlineItem(title: "Item Badges", vc: LXItemBadgeSupplementaryVC.self),
                        OutlineItem(title: "Section Headers/Footers", vc: LXSectionHeadersFootersVC.self),
                        OutlineItem(title: "Pinned Section Headers", vc: LXPinnedSectionHeaderFooterVC.self),
                    ]),
                    OutlineItem(title: "Section Background Decoration", vc: LXSectionDecorationVC.self),
                    OutlineItem(title: "Nested Groups", vc: LXNestedGroupsVC.self),
                    OutlineItem(title: "Orthogonal Sections", subitems: [
                        OutlineItem(title: "Orthogonal Sections", vc: LXOrthogonalScrollingVC.self),
                        OutlineItem(title: "Orthogonal Section Behaviors", vc: LXOrthogonalBehaviorVC.self),
                    ]),
                ]),
                OutlineItem(title: "Conference App", subitems: [
                    OutlineItem(title: "Videos"),
                    OutlineItem(title: "News"),
                ]),
            ]),
            OutlineItem(title: "Diffable Data Source", subitems: [
                OutlineItem(title: "Mountains Search"),
                OutlineItem(title: "Settings: Wi-Fi"),
                OutlineItem(title: "Insertion Sort Visualization"),
                OutlineItem(title: "UITableView: Editing"),
            ]),
            OutlineItem(title: "Lists", subitems: [
                OutlineItem(title: "Simple List"),
                OutlineItem(title: "Reorderable List"),
                OutlineItem(title: "List Appearances"),
                OutlineItem(title: "List with Custom Cells"),
            ]),
            OutlineItem(title: "Outlines", subitems: [
                OutlineItem(title: "Emoji Explorer"),
                OutlineItem(title: "Emoji Explorer - List"),
            ]),
            OutlineItem(title: "Cell Configurations", subitems: [
                OutlineItem(title: "Custom Configurations"),
            ])
        ]
    }()
    var dataSource: UICollectionViewDiffableDataSource<Section, OutlineItem>! = nil
    var outlineCollectionView: UICollectionView! = nil
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: 🌎LoadData
@available(iOS 14.0, *)
extension LXOutlineVC {
    func dataFill() {}
}

// MARK: 👀Public Actions
@available(iOS 14.0, *)
extension LXOutlineVC {}

@available(iOS 14.0, *)
extension LXOutlineVC {
    func generateLayout() -> UICollectionViewLayout {
        let listConfig = UICollectionLayoutListConfiguration(appearance: .sidebar)
        let layout = UICollectionViewCompositionalLayout.list(using: listConfig)
        return layout
    }
    func generateCollectionView() -> UICollectionView {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        cv.backgroundColor = .systemGroupedBackground
        cv.delegate = self
        return cv
    }
    func generateDataSource() -> UICollectionViewDiffableDataSource<Section, OutlineItem> {
        let containerCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, OutlineItem> { cell, indexPath, menuItem in
            var contentConfig = cell.defaultContentConfiguration()
            contentConfig.text = menuItem.title
            contentConfig.textProperties.font = .preferredFont(forTextStyle: .headline)
            cell.contentConfiguration = contentConfig

            let disclosureOpt = UICellAccessory.OutlineDisclosureOptions(style: .header)
            cell.accessories = [
                .outlineDisclosure(options: disclosureOpt)
            ]
            cell.backgroundConfiguration = UIBackgroundConfiguration.clear()
        }

        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, OutlineItem> { cell, indexPath, menuItem in
            var contentConfig = cell.defaultContentConfiguration()
            contentConfig.text = menuItem.title
            cell.contentConfiguration = contentConfig
            cell.backgroundConfiguration = UIBackgroundConfiguration.clear()
        }

        let dataSource = UICollectionViewDiffableDataSource<Section, OutlineItem>(collectionView: outlineCollectionView) { collectionView, indexPath, item in
            if item.subitems.isEmpty {
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            } else {
                return collectionView.dequeueConfiguredReusableCell(using: containerCellRegistration, for: indexPath, item: item)
            }
        }
        return dataSource
    }
    func initialSnapshot() -> NSDiffableDataSourceSectionSnapshot<OutlineItem> {
        var snapshot = NSDiffableDataSourceSectionSnapshot<OutlineItem>()

        func addItems(_ menuItems: [OutlineItem], to parent: OutlineItem?) {
            snapshot.append(menuItems, to: parent)
            for menuItem in menuItems where menuItem.subitems.isNotEmpty {
                addItems(menuItem.subitems, to: menuItem)
            }
        }

        addItems(menuItems, to: nil)
        return snapshot
    }
}

// MARK: 🔐Private Actions
@available(iOS 14.0, *)
private extension LXOutlineVC {}

// MARK: - ✈️UICollectionViewDelegate
@available(iOS 14.0, *)
extension LXOutlineVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let menuItem = self.dataSource.itemIdentifier(for: indexPath) else { return }
        collectionView.deselectItem(at: indexPath, animated: true)

        if let vc = menuItem.outlineVC {
            navigationController?.pushViewController(vc.init(), animated: true)
        } else {
            dlog("-->\(menuItem.title): \(menuItem.outlineVC?.xl.xl_typeName ?? "NaN")")
        }
    }
}

// MARK: - 🍺UI Prepare & Masonry
@available(iOS 14.0, *)
extension LXOutlineVC {
    override func prepareUI() {
        super.prepareUI()
        navigationItem.title = "Modern Collection Views"
        self.view.backgroundColor = .white
        self.edgesForExtendedLayout = []

        self.outlineCollectionView = generateCollectionView()
        self.dataSource = generateDataSource()
        let snapshot = initialSnapshot()
        self.dataSource.apply(snapshot, to: .main, animatingDifferences: false)

        [self.outlineCollectionView].forEach(self.view.addSubview)


        masonry()
    }

    override func masonry() {
        super.masonry()
        outlineCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
