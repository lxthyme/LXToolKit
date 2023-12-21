//
//  LXOutlineVC.swift
//  DJTest
//
//  Created by lxthyme on 2023/11/20.
//
import UIKit
import LXToolKit_Example
import LXToolKitObjC_Example
import ActivityKit
import DJTestKit
import LXToolKit

class LXOutlineVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var btnAppearance: UIButton = {
        let btn = UIButton(type: .custom)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8

        btn.setTitle("Appearance", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    private var collectionView: UICollectionView!
    // MARK: 🔗Vaiables
    private static let sectionHeaderElementKind = "sectionHeaderElementKind"
    private static let sectionFooterElementKind = "sectionFooterElementKind"
    private static let sectionBackgroundDecorationElementKind = "sectionBackgroundDecorationElementKind"
    private var isFirstAppearing = true
    private var dataSource: UICollectionViewDiffableDataSource<LXOutlineOpt, LXOutlineOpt>!
    var autoJumpRoute: DJTestType?
    private lazy var menuItems: [LXOutlineOpt] = {
        return [
            DJTestRouter.router233,
            DJTestRouter.routerItem,
            LXToolKitRouter.kitRouter,
            LXToolKitObjcRouter.objcRouter,
            DJTestRouter.routerDJTest,
            DJTestRouter.router3rd,
            DJTestRouter.routerFlutter,
            /// Others
            DJTestRouter.routerDJSwiftModule,
            DJTestRouter.routerDynamicIsland,
        ]
    }()
    // @available(iOS 13.0, *)
    // private var dataSnapshot: UICollectionViewDiffableDataSource<LXOutlineOpt, LXOutlineOpt>!
    var appearance: UICollectionLayoutListConfiguration.Appearance = .plain
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareCollectionView()
        prepareUI()

        startActivity()
        // testLogKit()
    }
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        if isFirstAppearing {
            gotoAutoJumpRouteScene()
        }
        isFirstAppearing = false
    }

}

// MARK: 🌎LoadData
extension LXOutlineVC {}

// MARK: 👀Public Actions
extension LXOutlineVC {}

// MARK: - 🔐Activity
private extension LXOutlineVC {
    // func testLogKit() {
    //     dlog("1. dlog")
    //     print("1.1. Swift.print")
    //     LogKit.kitLog("2. LogKit.kitLog")
    //     LogKit.resourcesCount()
    //     LogKit.logRxSwift(.onNext, items: "4. LogKit.logRxSwift")
    //     LogKit.traceLifeCycle(.vc, typeName: xl.typeNameString, type: .didReceiveMemoryWarning)
    //     loggerNormal.debug("6. loggerNormal.debug")
    // }
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
    func gotoScene(by menuItem: LXOutlineOpt) {
        guard let scene = menuItem.scene,
              let vc = Navigator.default.show(segue: scene, sender: self) else {
            // DJTestType.LXToolKit_Example.updateRouter(vcName: "")
            if menuItem.section.title.hasPrefix("Section ") ||
                menuItem.section.title.hasPrefix("Item ") {

                Navigator.default.show(segue: .vc(provider: {
                    let vc = LXSampleTextViewVC()
                    vc.dataFillUnSupport(content: menuItem.section.title)
                    return vc
                }), sender: self)
            } else if let provider = menuItem.scene?.vcProvider {
                let result = provider()
                TingYunManager.reportEvent(name: "scene.vcProvider 异常", properties: [
                    "menuItem": menuItem.description,
                    "provider": result?.xl.typeNameString ?? ""
                ])
            }
            return
        }
        vc.title = menuItem.section.title
        if let _ = try? DJTestRouter.routerDJSwiftModule.xl_first(where: { $0 == menuItem}) {
            DJTestType.DJSwiftModule.updateRouter(vcName: vc.xl.typeNameString)
        } else if let _ = try? DJTestRouter.routerDynamicIsland.xl_first(where: { $0 == menuItem }) {
            DJTestType.dynamicIsland.updateRouter(vcName: vc.xl.typeNameString)
        } else if let _ = try? DJTestRouter.routerDJTest.xl_first(where: { $0 == menuItem }) {
            DJTestType.djTest.updateRouter(vcName: vc.xl.typeNameString)
        } else if let _ = try? LXToolKitRouter.kitRouter.xl_first(where: { $0 == menuItem }) {
            DJTestType.LXToolKit_Example.updateRouter(vcName: vc.xl.typeNameString)
        } else if let _ = try? LXToolKitObjcRouter.objcRouter.xl_first(where: { $0 == menuItem }) {
            DJTestType.LXToolKitObjC_Example.updateRouter(vcName: vc.xl.typeNameString)
        } else {
            TingYunManager.reportEvent(name: "set AutoJumpRoute [menuItem] not found", properties: [
                "menuItem": menuItem.description,
            ])
            // fatalError("save AutoJumpRoute not found for \(menuItem)")
        }
    }
    func gotoAutoJumpRouteScene() {
        let route1Int = UserDefaults.standard.integer(forKey: DJTestType.AutoJumpRoute)
        guard let type = DJTestType.fromInt(idx: route1Int),
              let item = self.menuItems.first(where: { $0.section.title == type.title }) else {
            dlog("-->gotoScene error on scene[1]")
            TingYunManager.reportEvent(name: "restore Route1 failure", properties: [
                "route1Int": "\(route1Int)",
            ])
            return
        }
        let scene = item.scene != nil ? item.scene : item.subitems?.first?.scene
        guard let scene else {
            dlog("-->gotoScene error on scene[2]")
            TingYunManager.reportEvent(name: "restore scene failure", properties: [
                "route1": type.title,
                "scene": scene?.description ?? ""
            ])
            return
        }
        let vc: UIViewController?
        switch scene {
        case .vc(let provider, _):
            vc = provider()
            // type.updateRouter(vcName: <#T##String#>)
        case .vcString(let vcString, _):
            vc = vcString.xl.getVCInstance()
            // type.updateRouter(vcName: vcString)
        case .openURL:
            vc = nil
            break
        }
        guard let vc else { return }
        let route2 = type.userRouter
        if let vc = vc as? LXToolKitTestVC {
            let itemOpt: LXOutlineOpt
            do {
                itemOpt = try LXToolKitRouter.kitRouter.xl_first(where: { $0.section.title == route2 })
            } catch {
                dlog("-->error: \(error)")
                TingYunManager.reportEvent(name: "kit scene not found", properties: [
                    "route2": route2
                ])
                itemOpt = .subitem(.section(title: "LXToolKit_Example.\(route2)"),
                                   scene: .vcString(vcString:
                                                        "LXToolKit_Example." +
                                                    // "LXOutlineVC"
                                                    // "LXLabelVC"
                                                    // "LXStack1206VC"
                                                    // "LXTableTestVC"
                                                    // "LXRxSwiftTestVC"
                                                    route2
                                                   ))
            }
            vc.autoJumpRoute = itemOpt
        } else if let vc = vc as? LXToolKitObjCTestVC {
            vc.autoJumpRoute = route2
        } else if let vc = vc as? LXToolKitObjCTestSwiftVC {
            var itemOpt: LXOutlineOpt
            do {
                itemOpt = try LXToolKitObjcRouter.objcRouter.xl_first(where: { $0.section.title == route2 })
            } catch {
                dlog("-->error: \(error)")
                TingYunManager.reportEvent(name: "objc scene not found", properties: [
                    "route2": route2
                ])
                itemOpt = .subitem(.section(title: "LXToolKitObjC.\(route2)"),
                                   scene: .vcString(vcString: "LXToolKitObjc_Example" +
                                                    // "LXLabelTestVC"
                                                    // "LXPopTestVC"
                                                    // "DJCommentVC"
                                                    // "LXViewAnimationARCTestVC"
                                                    // "LXCollectionTestVC"
                                                    route2))
            }
            vc.autoJumpRoute = itemOpt
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: 🔐Private Actions
private extension LXOutlineVC {
    func generateLayout() -> UICollectionViewLayout {
        let sectionProvider = {[weak self] (sectionIdx: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            // guard let sectionKind = Section(rawValue: sectionIdx) else { return nil }
            guard let self else { return nil }
            dlog("-->sectionIdx: \(sectionIdx)")
            var config = UICollectionLayoutListConfiguration(appearance: self.appearance)
            config.headerMode = .firstItemInSection
            // config.footerMode = .supplementary
            // config.backgroundColor = .white

            let bgDecoration = NSCollectionLayoutDecorationItem.background(elementKind: LXOutlineVC.sectionBackgroundDecorationElementKind)
            bgDecoration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

            // layout.register(LXSectionBgDecorationView.self, forDecorationViewOfKind: LXSectionDecorationVC.sectionBackgroundDecorationElementKind)

            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .estimated(44.0))
            let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .estimated(44.0))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                            elementKind: LXOutlineVC.sectionHeaderElementKind,
                                                                            alignment: .topLeading)
            let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize,
                                                                            elementKind: LXOutlineVC.sectionFooterElementKind,
                                                                            alignment: .bottomTrailing)
            let section: NSCollectionLayoutSection
            if case .subitem = self.menuItems[sectionIdx] {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                // <#item#>.contentInsets = NSDirectionalEdgeInsets(top: <#10.0#>, leading: <#10.0#>, bottom: <#10.0#>, trailing: <#10.0#>)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .estimated(44))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitems: [item])
                // <#group#>.contentInsets = NSDirectionalEdgeInsets(top: <#10.0#>, leading: <#10.0#>, bottom: <#10.0#>, trailing: <#10.0#>)
                section = NSCollectionLayoutSection(group: group)
            } else {
                section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
            }
            // section.contentInsets = .zero
            section.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 10, bottom: 10, trailing: 10)
            // sectionHeader.pinToVisibleBounds = true
            // sectionHeader.zIndex = 2
            section.decorationItems = [bgDecoration]
            // section.boundarySupplementaryItems = [sectionHeader, sectionFooter]
            return section
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
        layout.register(LXBGNestedGroupDecorationView.self, forDecorationViewOfKind: LXOutlineVC.sectionBackgroundDecorationElementKind)
        return layout
    }
    func generateCollectionView() -> UICollectionView {
        let layout = generateLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // cv.backgroundColor = .white
        return cv;
    }
    func generateDataSource() -> UICollectionViewDiffableDataSource<LXOutlineOpt, LXOutlineOpt> {
        let outlineRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, LXOutlineOpt> { cell, indexPath, menuItem in
            // cell.labTitle.text = "\(<#item#>)"
            var contentConfig = cell.defaultContentConfiguration()
            contentConfig.text = "\(menuItem.section.title)."
            // contentConfig.textProperties.color = .black
            // contentConfig.textProperties.font = .preferredFont(forTextStyle: .headline)
            cell.contentConfiguration = contentConfig

            let disclosureOpt = UICellAccessory.OutlineDisclosureOptions(style: .header)
            cell.accessories = [
                .outlineDisclosure(options: disclosureOpt)
                // .outlineDisclosure()
            ]
            let bgConfig = UIBackgroundConfiguration.clear()
            cell.backgroundConfiguration = bgConfig
        }
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, LXOutlineOpt> {[weak self] (cell, indexPath, menuItem) in
            guard let self else { return }
            // Populate the cell with our item description.
            // cell.label.text = "\(<#item#>)"
            var contentConfig = cell.defaultContentConfiguration()
            contentConfig.text = menuItem.section.title
            // contentConfig.textProperties.color = .black
            cell.contentConfiguration = contentConfig

            switch self.appearance {
            case .sidebar, .sidebarPlain: cell.accessories = []
            default: cell.accessories = [.disclosureIndicator()]
            }
            let bgConfig = UIBackgroundConfiguration.clear()
            cell.backgroundConfiguration = bgConfig
        }
        let dataSource = UICollectionViewDiffableDataSource<LXOutlineOpt, LXOutlineOpt>(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case .outline:
                return collectionView.dequeueConfiguredReusableCell(using: outlineRegistration, for: indexPath, item: item)
            case .subitem:
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            }
        }
        dataSource.sectionSnapshotHandlers.shouldCollapseItem = { opt in
            return !DJTestRouter.expandedSectionList.contains([opt])
        }
        // dataSource.sectionSnapshotHandlers.willExpandItem = {[weak self] opt in
        //     self?.gotoScene(by: opt.scene)
        // }
        // dataSource.sectionSnapshotHandlers.willCollapseItem = {[weak self] opt in
        //     self?.gotoScene(by: opt.scene)
        // }
        let headerRegistration = UICollectionView.SupplementaryRegistration<LXCollectionHeaderFooterView>(elementKind: LXOutlineVC.sectionHeaderElementKind) {[weak self] supplementaryView, elementKind, indexPath in
            guard let model = self?.dataSource.itemIdentifier(for: indexPath) else { return }
            supplementaryView.dataFill("\(model.section.title) - header")
        }
        let footerRegistration = UICollectionView.SupplementaryRegistration<LXCollectionHeaderFooterView>(elementKind: LXOutlineVC.sectionFooterElementKind) {[weak self] supplementaryView, elementKind, indexPath in
            guard let model = self?.dataSource.itemIdentifier(for: indexPath) else { return }
            supplementaryView.dataFill("\(model.section.title) - footer")
        }
        dataSource.supplementaryViewProvider = {[weak self] collectionView, elementKind, indexPath in
            dlog("-->elementKind: \(elementKind)")
            return self?.collectionView.dequeueConfiguredReusableSupplementary(using: elementKind == LXOutlineVC.sectionHeaderElementKind ? headerRegistration : footerRegistration, for: indexPath)
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
                case .outline(_, _, let subitems, _):
                    addItems(subitems, to: menuItem)
                case .subitem:
                    break
                }
            }
        }

        for menuItem in self.menuItems {
            snapshot.append([menuItem], to: nil)
            switch menuItem {
            case .outline(_, _, let subitems, _):
                addItems(subitems, to: menuItem)
            case .subitem:
                break
            }
        }
        return snapshot
    }
    // func initialSnapshot(outline: [LXOutlineOpt]) -> NSDiffableDataSourceSectionSnapshot<LXOutlineOpt> {
    //     var snapshot = NSDiffableDataSourceSectionSnapshot<LXOutlineOpt>()
    //
    //     func addItems(_ menuItems: [LXOutlineOpt], to parent: LXOutlineOpt?) {
    //         snapshot.append(menuItems, to: parent)
    //         for menuItem in menuItems where (menuItem.subitems ?? []).isNotEmpty {
    //             addItems(menuItem.subitems ?? [], to: menuItem)
    //         }
    //     }
    //
    //     addItems(outline, to: nil)
    //     return snapshot
    // }
    func generateMultiSnapshot() {
        func addItems(_ snapshot: inout NSDiffableDataSourceSectionSnapshot<LXOutlineOpt>, menuItems: [LXOutlineOpt], to parent: LXOutlineOpt?) {
            for menuItem in menuItems {
                switch menuItem {
                case .outline(_, _, let subitems, _):
                    if !snapshot.contains(menuItem) {
                        snapshot.append([menuItem], to: parent)
                    }
                    addItems(&snapshot, menuItems: subitems, to: menuItem)
                    // snapshot.append(subitems, to: parent)
                case .subitem:
                    snapshot.append([menuItem], to: parent)
                    break
                }
            }
        }
        var snapshot = NSDiffableDataSourceSnapshot<LXOutlineOpt, LXOutlineOpt>()
        snapshot.appendSections(self.menuItems)
        // snapshot.appendItems([DJTestRouter.routerDynamicIsland])
        var expandList: [LXOutlineOpt: NSDiffableDataSourceSectionSnapshot<LXOutlineOpt>] = [:]
        for menuItem in self.menuItems {
            switch menuItem {
            case .outline(_, _, let subitems, _):
                snapshot.appendItems([menuItem], toSection: menuItem)

                var snapshot2 = NSDiffableDataSourceSectionSnapshot<LXOutlineOpt>()
                snapshot2.append([menuItem])
                // snapshot2.append(subitems, to: menuItem)
                addItems(&snapshot2, menuItems: subitems, to: menuItem)
                if DJTestRouter.expandedSectionList.contains([menuItem]) {
                    expandList[menuItem] = snapshot2
                }
                dataSource.apply(snapshot2, to: menuItem, animatingDifferences: true)
            case .subitem:
                snapshot.appendItems([menuItem])
                break
            }
        }
        dataSource.apply(snapshot, animatingDifferences: true)
        for (key, value) in expandList {
            var tmp = value
            tmp.expand([key])
            dataSource.apply(tmp, to: key, animatingDifferences: true)
        }
    }
    func refreshCollectionView() {
        // let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first
        // let snapshot = dataSource.snapshot()
        // dlog("-->snapshot: \(snapshot)")
        // dataSource.apply(dataSource.snapshot(), animatingDifferences: true)
        // collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: [])
        generateMultiSnapshot()
    }
    func generateNavRightItems() -> [UIBarButtonItem] {
        let subItems = [
            UIAction(title: "plain", state: self.appearance == .plain ? .on : .off, handler: {[weak self] _ in
                self?.appearance = .plain
                self?.refreshCollectionView()
            }),
            UIAction(title: "grouped", state: self.appearance == .grouped ? .on : .off, handler: {[weak self] _ in
                self?.appearance = .grouped
                self?.refreshCollectionView()
            }),
            UIAction(title: "insetGrouped", state: self.appearance == .insetGrouped ? .on : .off, handler: {[weak self] _ in
                self?.appearance = .insetGrouped
                self?.refreshCollectionView()
            }),
            UIAction(title: "sidebar", state: self.appearance == .sidebar ? .on : .off, handler: {[weak self] _ in
                self?.appearance = .sidebar
                self?.refreshCollectionView()
            }),
            UIAction(title: "sidebarPlain", state: self.appearance == .sidebarPlain ? .on : .off, handler: {[weak self] _ in
                self?.appearance = .sidebarPlain
                self?.refreshCollectionView()
            }),
        ]
        let appearance = if #available(iOS 15.0, *) {
            UIMenu(title: "", options: .singleSelection, children: subItems)
        } else {
            // Fallback on earlier versions
            UIMenu(title: "", children: subItems)
        }
        return [
            UIBarButtonItem(title: "Appearance", menu: appearance),
        ]
    }
}

extension LXOutlineVC: UICollectionViewDelegate {
    // func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    //     guard let menuItem = dataSource.itemIdentifier(for: indexPath) else { return true }
    //     // let dataSnapt = dataSource.sectionIdentifier(for: <#T##Int#>)
    //     if let section = dataSource.sectionIdentifier(for: indexPath.section) {
    //         let snapshot = dataSource.snapshot(for: section)
    //         let t = snapshot.items.map { $0.section.title }
    //         dlog("-->snapshot: \(snapshot)")
    //     }
    //     return false
    // }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let menuItem = self.dataSource.itemIdentifier(for: indexPath) else { return }

        // let random = Int.random(in: 0...10)
        // assert(random != 5, "test assert: \(random) at \(Date())")
        // if random == 6 {
        //     fatalError("test assert: \(random) at \(Date())")
        // }

        gotoScene(by: menuItem)
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXOutlineVC {
    func prepareCollectionView() {
        if #available(iOS 14.0, *) {
            collectionView = generateCollectionView()
            dataSource = generateDataSource()
            generateMultiSnapshot()
        } else {
            // Fallback on earlier versions
            collectionView = UICollectionView(frame: .zero)
        }
        collectionView.delegate = self
    }
    func prepareUI() {
        self.view.backgroundColor = .cyan
        // navigationItem.title = ""
        navigationItem.rightBarButtonItems = generateNavRightItems()

        [collectionView].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

@available(iOS 17.0, *)
#Preview("LXOutlineVC") {
    return LXOutlineVC()
}
