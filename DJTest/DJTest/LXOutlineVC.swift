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
        let djTestList: LXOutlineOpt = .outline(title: "DJTest", subitems: [
            .subitem(title: "LXAMapTestVC", vc: .vc(identifier: "LXAMapTestVC", vcProvider: { LXAMapTestVC() })),
            .subitem(title: "LXOutlineVC", vc: .vc(identifier: "LXOutlineVC", vcProvider: { LXOutlineVC() })),
        ])
        let kitList: LXOutlineOpt = .subitem(title: "LXToolKit_Example", vc: .vc(identifier: UUID().uuidString, vcProvider: { DJTestType.LXToolKit_Example.vc }))
        let kitObjcList: LXOutlineOpt = .subitem(title: "LXToolKitObjC_Example", vc: .vc(identifier: UUID().uuidString, vcProvider: { DJTestType.LXToolKitObjC_Example.vc }))
        return [
            kitList,
            kitObjcList,
            .subitem(title: "DJSwiftModule", vc: .vc(identifier: UUID().uuidString, vcProvider: { DJTestType.DJSwiftModule.vc })),
            .subitem(title: "dynamicIsland", vc: .vc(identifier: UUID().uuidString, vcProvider: { DJTestType.dynamicIsland.vc })),
            djTestList,
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

#Preview("LXOutlineVC") {
    return LXOutlineVC()
}
