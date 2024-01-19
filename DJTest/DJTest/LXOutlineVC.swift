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

@available(iOS 14.0, *)
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
    private lazy var menuItems: [LXOutlineOpt] = {
        return [
            DJTestRouter.router233,
            DJTestRouter.routerItem,
            LXToolKitRouter.kitRouter,
            LXToolKitObjcRouter.objcRouter,
            DJTestRouter.routerDJTest,
            DJTestRouter.routerDJ(),
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
@available(iOS 14.0, *)
extension LXOutlineVC {}

// MARK: 👀Public Actions
@available(iOS 14.0, *)
extension LXOutlineVC {}

// MARK: - 🔐Activity
@available(iOS 14.0, *)
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
@available(iOS 14.0, *)
private extension LXOutlineVC {
    func gotoScene(by menuItem: LXOutlineOpt) {
        guard let scene = menuItem.scene,
              let vc = Navigator.default.show(segue: scene, sender: self) else {
            if menuItem.section.title.hasPrefix("Section ") ||
                menuItem.section.title.hasPrefix("Item ") {
    
                Navigator.default.show(segue: .vc(provider: {
                    let vc = LXSampleTextViewVC()
                    vc.title = menuItem.section.title
                    vc.dataFillUnSupport(content: menuItem.section.title)
                    return vc
                }), sender: self)
            }
            return
        }
        vc.title = menuItem.section.title
        DJAutoRouter.router1.updateRouter(section: menuItem.section)
    }
    func gotoAutoJumpRouteScene() {
        guard let router1 = DJAutoRouter.router1.getDefaultsValue(),
              let router1Menu = try? self.menuItems.xl_first(where: { $0.section.title == router1 }) else {
                  return
        }
        if(router1Menu.section.title == LXOutlineVC.XL.typeNameString) {
            return
        }
        if let scene = router1Menu.scene {
            let vc = Navigator.default.show(segue: scene, sender: self)
            vc?.title = router1Menu.section.title
        }
        guard let router2 = DJAutoRouter.router2.getDefaultsValue(),
              let router2Menu = try? self.menuItems.xl_first(where: { $0.section.title == router2 }) else {
            return
        }
        if let scene = router2Menu.scene {
            let vc = Navigator.default.show(segue: scene, sender: self)
            vc?.title = router1Menu.section.title
        }
    }
}

// MARK: 🔐Private Actions
@available(iOS 14.0, *)
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
        return cv
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
        let cellParamRegistration = UICollectionView.CellRegistration<LXOutlineParamCell, LXOutlineOpt> { (cell, indexPath, item) in
            // Populate the cell with our item description.
            // cell.label.text = "\(<#item#>)"
            let tmp = item.section.title.components(separatedBy: ":")
            // let env = DJRouter.getCurrentEnv()
            let mockList: [String]? = tmp[safe: 2]?
                .components(separatedBy: ",")
            let defaultValue = mockList?
                .first(where: { $0.components(separatedBy: "/").first?.trimmed == DJEnv.getCurrentEnv().rawValue })
            cell.dataFill(title: tmp[safe: 0] ?? "", placeholder: tmp[safe: 1], mockList: mockList, defaultValue: defaultValue)
            cell.accessories = [
                .disclosureIndicator()
            ]

            let bgConfig = UIBackgroundConfiguration.clear()
            cell.backgroundConfiguration = bgConfig
        }
        let dataSource = UICollectionViewDiffableDataSource<LXOutlineOpt, LXOutlineOpt>(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case .outline:
                return collectionView.dequeueConfiguredReusableCell(using: outlineRegistration, for: indexPath, item: item)
            case .subitem:
                if item.section.title.contains("👉") {
                    return collectionView.dequeueConfiguredReusableCell(using: cellParamRegistration, for: indexPath, item: item)
                } else {
                    return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
                }
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
                case .outline(_, _, let subitems):
                    addItems(subitems, to: menuItem)
                case .subitem:
                    break
                }
            }
        }

        for menuItem in self.menuItems {
            snapshot.append([menuItem], to: nil)
            switch menuItem {
            case .outline(_, _, let subitems):
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
                case .outline(_, _, let subitems):
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
            case .outline(_, _, let subitems):
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

@available(iOS 14.0, *)
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
        guard menuItem.section.title.contains("👉") else {
            gotoScene(by: menuItem)
            return
        }
        let tmp = menuItem.section.title.components(separatedBy: ":")
        switch tmp.first ?? "" {
        case DJRouterPath.getMain.title:
            guard let cell = collectionView.cellForItem(at: indexPath) as? LXOutlineParamCell else { return }
            let param = cell.currentValue.components(separatedBy: "/")
            guard let storeCode = param[safe: 1],
                  let storeType = param[safe: 2],
                  storeCode.isNotEmpty,
                  storeType.isNotEmpty else {
                return
            }
            let scene: Navigator.Scene = .vc(provider: {
                let vc = DJRouter.getMain(storeCode, storeType: storeType)
                let nav = DJTestRouter.createNav(rootVC: vc)
                return nav
            }, transition: .alert)
            Navigator.default.show(segue: scene, sender: self)
        default: break
        }

    }
}

// MARK: - 🍺UI Prepare & Masonry
@available(iOS 14.0, *)
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
