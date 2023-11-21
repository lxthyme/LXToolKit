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



class LXOutlineVC: LXBaseVC {
    // MARK: 📌UI
    private var collectionView: UICollectionView!
    // MARK: 🔗Vaiables
    private var dataSource: UICollectionViewDiffableDataSource<LXSection, LXOutlineOpt>!
    var autoJumpRoute: DJTestType?
    private lazy var menuItems: [LXOutlineOpt] = {
        return [
            LXToolKitRouter.kitRouter,
            LXToolKitObjcRouter.objcRouter,
            .subitem(title: "DJSwiftModule", scene: .vc(provider: { DJTestType.DJSwiftModule.vc })),
            .subitem(title: "dynamicIsland", scene: .vc(provider: { DJTestType.dynamicIsland.vc })),
            .outline(title: "DJTest", subitems: [
                .subitem(title: "LXAMapTestVC", scene: .vc(provider: { LXAMapTestVC() })),
                .subitem(title: "LXOutlineVC", scene: .vc(provider: { LXOutlineVC() })),
            ].reversed()),
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

        let route1Int = UserDefaults.standard.integer(forKey: DJTestType.AutoJumpRoute)
        if let route1 = DJTestType.fromInt(idx: route1Int) {
            // autoJumpRoute = route1
            // autoJumpRoute = DJTestType.dynamicIsland
            // .LXToolKit_Example
                // .LXToolKitObjC_Example
            gotoScene(by: route1)
        }

        startActivity()
    }

}

// MARK: 🌎LoadData
extension LXOutlineVC {}

// MARK: 👀Public Actions
extension LXOutlineVC {}

// MARK: - 🔐Activity
private extension LXOutlineVC {
    func startActivity() {
        // guard ActivityAuthorizationInfo().areActivitiesEnabled else {
        //     dlog("灵动岛没有权限")
        //     return
        // }
        // let attr = LXToolKit_WidgetAttributes(name: "")
        // let initialContentState = LXToolKit_WidgetAttributes.ContentState(emoji: "100")
        // do {
        //     let myActivity = try Activity<LXToolKit_WidgetAttributes>.request(attributes: attr,
        //                                                                       content: .init(state: initialContentState, staleDate: nil),
        //                                                                       pushType: nil)
        //     dlog("-->灵动岛: \(myActivity.id)")
        //     self.setup
        // } catch (let error) {
        //     dlog("-->灵动岛开启时发生错误: \(error)")
        // }
    }
}

// MARK: - 🔐
private extension LXOutlineVC {
    func gotoScene(by scene: Navigator.Scene?) {
        guard let scene else { return }
        let navigator = Navigator.default
        navigator.show(segue: scene, sender: self)
    }
    func gotoScene(by scene: DJTestType?, route2 tmp: String = "") {
        guard let scene else { return }
        UserDefaults.standard.set(scene.intValue(), forKey: DJTestType.AutoJumpRoute)
        guard let vc = scene.vc else {
            dlog("-->gotoScene error on scene: \(scene)")
            return
        }
        // UserDefaults.standard.set(vc.xl.xl_typeName, forKey: scene.userDefaultsKey())
        var route2 = tmp
        if route2.isEmpty {
            route2 = UserDefaults.standard.string(forKey: scene.userDefaultsKey()) ?? ""
        }
        if let vc = vc as? LXToolKitTestVC {
            vc.autoJumpRoute =
                .subitem(title: "LXToolKit_Example." + route2, scene: .vcString(vcString:
                                                    "LXToolKit_Example." +
                                                  // "LXOutlineVC"
                                                  // "LXLabelVC"
                                                  // "LXStack1206VC"
                                                  // "LXTableTestVC"
                                                  // "LXRxSwiftTestVC"
                                                  route2
                                                 ))
        } else if let vc = vc as? LXToolKitObjCTestSwiftVC {
            vc.autoJumpRoute =
            // "LXLabelTestVC"
            // "LXPopTestVC"
            // "DJCommentVC"
            // "LXViewAnimationARCTestVC"
            // "LXCollectionTestVC"
            route2
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: 🔐Private Actions
@available(iOS 14.0, *)
private extension LXOutlineVC {
    func generateLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .sidebar)
        config.headerMode = .supplementary
        // config.footerMode = .supplementary
        return  UICollectionViewCompositionalLayout.list(using: config)
    }
    func generateCollectionView() -> UICollectionView {
        let layout = generateLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemGroupedBackground
        return cv;
    }
    func generateDataSource() -> UICollectionViewDiffableDataSource<LXSection, LXOutlineOpt> {
        let containerCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, LXOutlineOpt> { cell, indexPath, menuItem in
            guard case .outline(let title, _, _) = menuItem else { return }
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
            guard case .subitem(let title, _, _) = menuItem else { return }
            // cell.label.text = "\(<#item#>)"
            var contentConfig = cell.defaultContentConfiguration()
            contentConfig.text = title
            cell.contentConfiguration = contentConfig
            cell.backgroundConfiguration = UIBackgroundConfiguration.clear()
        }
        let dataSource = UICollectionViewDiffableDataSource<LXSection, LXOutlineOpt>(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case .outline:
                return collectionView.dequeueConfiguredReusableCell(using: containerCellRegistration, for: indexPath, item: item)
            case .subitem:
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            }
        }
        let headerRegistration = UICollectionView.SupplementaryRegistration<LXCollectionHeaderFooterView>(elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView, elementKind, indexPath in
            guard let model = self.dataSource.itemIdentifier(for: indexPath) else { return }
            supplementaryView.dataFill("\(model.title) - header")
        }
        let footerRegistration = UICollectionView.SupplementaryRegistration<LXCollectionHeaderFooterView>(elementKind: UICollectionView.elementKindSectionFooter) { supplementaryView, elementKind, indexPath in
            guard let model = self.dataSource.itemIdentifier(for: indexPath) else { return }
            supplementaryView.dataFill("\(model.title) - footer")
        }
        dataSource.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            dlog("-->elementKind: \(elementKind)")
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: elementKind == UICollectionView.elementKindSectionHeader ? headerRegistration : footerRegistration, for: indexPath)
        }
        return dataSource
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
                case .outline(_, let subitems, _):
                    addItems(subitems, to: menuItem)
                case .subitem:
                    break
                }
            }
        }

        for menuItem in self.menuItems {
            snapshot.append([menuItem])
            switch menuItem {
            case .outline(_, let subitems, _):
                addItems(subitems, to: menuItem)
            case .subitem:
                break
            }
        }
        // let item = LXOutlineOpt.subitem(title: "dynamicIsland", scene: .vc(provider: { DJTestType.dynamicIsland.vc }))
        // let outline = LXOutlineOpt.outline(title: "DJTest", subitems: [
        //     LXOutlineOpt.subitem(title: "LXAMapTestVC", scene: .vc(provider: { LXAMapTestVC() })),
        //     LXOutlineOpt.subitem(title: "LXOutlineVC", scene: .vc(provider: { LXOutlineVC() })),
        // ].reversed())
        // snapshot.append([item])
        // snapshot.append([outline])
        // snapshot.append(outline.subitems ?? [], to: outline)
        return snapshot
    }
}

extension LXOutlineVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let menuItem = self.dataSource.itemIdentifier(for: indexPath) else { return }

        let random = Int.random(in: 0...10)
        assert(random != 5, "test assert: \(random) at \(Date())")
        
        if let scene = menuItem.scene {
            gotoScene(by: scene)
        } else {
            fatalError("menuItem: \(menuItem)")
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
            // dlog("-->snapshot: \(snapshot.items)")
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
