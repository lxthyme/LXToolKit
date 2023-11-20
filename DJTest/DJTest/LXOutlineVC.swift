//
//  LXOutlineVC.swift
//  DJTest
//
//  Created by lxthyme on 2023/11/20.
//
import UIKit
import SwiftUI
import LXToolKit_Example
import LXToolKitObjC_Example
import ActivityKit
import DJTestKit
import LXToolKit

enum LXSection {
    case main
}
enum LXOutlineOpt: Hashable {
    case outline(title: String, subitems: [LXOutlineOpt])
    case subitem(title: String, vc: Navigator.Scene)
}

class LXOutlineVC: LXBaseVC {
    // MARK: 📌UI
    private var collectionView: UICollectionView!
    // MARK: 🔗Vaiables
    private var dataSource: UICollectionViewDiffableDataSource<LXSection, LXOutlineOpt>!
    var autoJumpRoute: DJTestType?
    private lazy var menuItems: [LXOutlineOpt] = {
        return [
            .outline(title: "Title", subitems: [
                .subitem(title: "Title1", vc: .vc(identifier: UUID().uuidString, vcProvider: { LXAMapTestVC() })),
                .subitem(title: "Title2", vc: .vc(identifier: UUID().uuidString, vcProvider: { LXAMapTestVC() })),
                .subitem(title: "Title3", vc: .vc(identifier: UUID().uuidString, vcProvider: { LXAMapTestVC() })),
            ]),
            .subitem(title: "LXAMapTestVC", vc: .vc(identifier: UUID().uuidString, vcProvider: { LXAMapTestVC() })),
            // LXOutlineItem(title: "Compositional Layout", subitems: [
            //     LXOutlineItem(title: "Getting Started", subitems: [
            //         LXOutlineItem(title: "Grid", outlineVC: GridViewController.self),
            //         LXOutlineItem(title: "Inset Items Grid",
            //                     outlineVC: InsetItemsGridViewController.self),
            //         LXOutlineItem(title: "Two-Column Grid", outlineVC: TwoColumnViewController.self),
            //         LXOutlineItem(title: "Per-Section Layout", subitems: [
            //             LXOutlineItem(title: "Distinct Sections",
            //                         outlineVC: DistinctSectionsViewController.self),
            //             LXOutlineItem(title: "Adaptive Sections",
            //                         outlineVC: AdaptiveSectionsViewController.self)
            //             ])
            //         ]),
            //     LXOutlineItem(title: "Advanced Layouts", subitems: [
            //         LXOutlineItem(title: "Supplementary Views", subitems: [
            //             LXOutlineItem(title: "Item Badges",
            //                         outlineVC: ItemBadgeSupplementaryViewController.self),
            //             LXOutlineItem(title: "Section Headers/Footers",
            //                         outlineVC: SectionHeadersFootersViewController.self),
            //             LXOutlineItem(title: "Pinned Section Headers",
            //                         outlineVC: PinnedSectionHeaderFooterViewController.self)
            //             ]),
            //         LXOutlineItem(title: "Section Background Decoration",
            //                     outlineVC: SectionDecorationViewController.self),
            //         LXOutlineItem(title: "Nested Groups",
            //                     outlineVC: NestedGroupsViewController.self),
            //         LXOutlineItem(title: "Orthogonal Sections", subitems: [
            //             LXOutlineItem(title: "Orthogonal Sections",
            //                         outlineVC: OrthogonalScrollingViewController.self),
            //             LXOutlineItem(title: "Orthogonal Section Behaviors",
            //                         outlineVC: OrthogonalScrollBehaviorViewController.self)
            //             ])
            //         ]),
            //     LXOutlineItem(title: "Conference App", subitems: [
            //         LXOutlineItem(title: "Videos",
            //                     outlineVC: ConferenceVideoSessionsViewController.self),
            //         LXOutlineItem(title: "News", outlineVC: ConferenceNewsFeedViewController.self)
            //         ])
            // ]),
            // LXOutlineItem(title: "Diffable Data Source", subitems: [
            //     LXOutlineItem(title: "Mountains Search", outlineVC: MountainsViewController.self),
            //     LXOutlineItem(title: "Settings: Wi-Fi", outlineVC: WiFiSettingsViewController.self),
            //     LXOutlineItem(title: "Insertion Sort Visualization",
            //                 outlineVC: InsertionSortViewController.self),
            //     LXOutlineItem(title: "UITableView: Editing",
            //                 outlineVC: TableViewEditingViewController.self)
            //     ]),
            // LXOutlineItem(title: "Lists", subitems: [
            //     LXOutlineItem(title: "Simple List", outlineVC: SimpleListViewController.self),
            //     LXOutlineItem(title: "Reorderable List", outlineVC: ReorderableListViewController.self),
            //     LXOutlineItem(title: "List Appearances", outlineVC: ListAppearancesViewController.self),
            //     LXOutlineItem(title: "List with Custom Cells", outlineVC: CustomCellListViewController.self)
            // ]),
            // LXOutlineItem(title: "Outlines", subitems: [
            //     LXOutlineItem(title: "Emoji Explorer", outlineVC: EmojiExplorerViewController.self),
            //     LXOutlineItem(title: "Emoji Explorer - List", outlineVC: EmojiExplorerListViewController.self)
            // ]),
            // LXOutlineItem(title: "Cell Configurations", subitems: [
            //     LXOutlineItem(title: "Custom Configurations", outlineVC: CustomConfigurationViewController.self)
            // ])
        ]
    }()
    @available(iOS 13.0, *)
    private var dataSnapshot: UICollectionViewDiffableDataSource<LXSection, LXOutlineOpt>!
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareCollectionView()
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LXOutlineVC {}

// MARK: 👀Public Actions
extension LXOutlineVC {}

// MARK: - 🔐
private extension LXOutlineVC {
    func gotoScene(by scene: Navigator.Scene?) {
        guard let scene else { return }
        let navigator = Navigator.default
        navigator.show(segue: scene, sender: self)
    }
}

// MARK: 🔐Private Actions
@available(iOS 14.0, *)
private extension LXOutlineVC {
    func generateLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .sidebar)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    func generateCollectionView() -> UICollectionView {
        let layout = generateLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemGroupedBackground
        return cv;
    }
    func generateDataSource() -> UICollectionViewDiffableDataSource<LXSection, LXOutlineOpt> {
        let containerCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, LXOutlineOpt> { cell, indexPath, menuItem in
            guard case .outline(let title, _) = menuItem else { return }
            // cell.labTitle.text = "\(<#item#>)"
            var contentConfig = cell.defaultContentConfiguration()
            contentConfig.text = title
            contentConfig.textProperties.font = .preferredFont(forTextStyle: .headline)
            cell.contentConfiguration = contentConfig

            let disclosureOpt = UICellAccessory.OutlineDisclosureOptions(style: .header)
            cell.accessories = [
                .outlineDisclosure(options: disclosureOpt)
            ]
            cell.backgroundConfiguration = UIBackgroundConfiguration.clear()
        }
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, LXOutlineOpt> { (cell, indexPath, menuItem) in
            // Populate the cell with our item description.
            guard case .subitem(let title, _) = menuItem else { return }
            // cell.label.text = "\(<#item#>)"
            var contentConfig = cell.defaultContentConfiguration()
            contentConfig.text = title
            cell.contentConfiguration = contentConfig
            cell.backgroundConfiguration = UIBackgroundConfiguration.clear()
        }
        return UICollectionViewDiffableDataSource<LXSection, LXOutlineOpt>(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case .outline:
                return collectionView.dequeueConfiguredReusableCell(using: containerCellRegistration, for: indexPath, item: item)
            case .subitem:
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            }
        }
    }
    func generateSnapshot() -> NSDiffableDataSourceSectionSnapshot<LXOutlineOpt> {
        var snapshot = NSDiffableDataSourceSectionSnapshot<LXOutlineOpt>()

        func addItems(_ menuItems: [LXOutlineOpt], to parent: LXOutlineOpt?) {
            snapshot.append(menuItems, to: parent)

            // for menuItem in menuItems where menuItem.subitems.isNotEmpty {
            //     addItems(menuItem.subitems, to: menuItem)
            // }
            for menuItem in menuItems {
                switch menuItem {
                case .outline(_, let subitems):
                    addItems(subitems, to: menuItem)
                case .subitem:
                    break
                }
            }
        }

        addItems(menuItems, to: nil)
        return snapshot
    }
}

extension LXOutlineVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let menuItem = self.dataSource.itemIdentifier(for: indexPath) else { return }

        if case .subitem(_, let scene) = menuItem {
            gotoScene(by: scene)
        } else {
            dlog("menuItem: \(menuItem)")
        }
    }
}

// MARK: - 🍺UI Prepare & Masonry
extension LXOutlineVC {
    func prepareCollectionView() {
        if #available(iOS 14.0, *) {
            collectionView = generateCollectionView()
            dataSource = generateDataSource()
            let snapshot = generateSnapshot()
            self.dataSource.apply(snapshot, to: .main, animatingDifferences: true)
        } else {
            // Fallback on earlier versions
            collectionView = UICollectionView(frame: .zero)
        }
        collectionView.delegate = self
    }
    override func prepareUI() {
        super.prepareUI()
        self.view.backgroundColor = .white
        // navigationItem.title = ""

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

#Preview("ViewController") {
    return ViewController()
}
