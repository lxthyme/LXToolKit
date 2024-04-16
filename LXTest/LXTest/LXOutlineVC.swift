//
//  LXOutlineVC.swift
//  LXTest
//
//  Created by lxthyme on 2023/11/20.
//
import UIKit
import LXToolKit_Example
import LXToolKitObjC_Example
import ActivityKit
import DJTestKit
import LXToolKit
import AcknowList

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
    private var isFirstLoad = true
    private var dataSource: UICollectionViewDiffableDataSource<LXOutlineItem, LXOutlineItem>!
    private lazy var menuItems: [LXOutlineItem] = {
        return [
            DJTestRouter.routerDebug(),
            LXOutlineItem(opt: .subitem(.section(title: "AcknowListViewController")), scene: .vc(provider: {
                let settingBundle = Bundle.XL.settingsBundle(for: LXOutlineVC.self)
                if let url = settingBundle?.url(forResource: "Pods-acknowledgements", withExtension: "plist") {
                    return AcknowListViewController(plistFileURL: url)
                }
                let vc = LXSampleTextViewVC()
                vc.dataFillUnSupport(content: "Pods-acknowledgements.plist file not found!")
                return vc
            })),
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
            // DJTestRouter.routerItemCustom("1"),
            // DJTestRouter.routerItemCustom("2"),
            // DJTestRouter.routerItemCustom("3"),
            // DJTestRouter.routerItemCustom("4"),
            // DJTestRouter.routerItemCustom("5"),
            // DJTestRouter.routerItemCustom("6"),
            // DJTestRouter.routerItemCustom("7"),
            // DJTestRouter.routerItemCustom("8"),
            // DJTestRouter.routerItemCustom("9"),
            // DJTestRouter.routerItemCustom("10"),
        ]
    }()
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
            let result: [LXOutlineItem] = gotoAutoJumpRouteScene()
            generateMultiSnapshot(result)
        }
        isFirstAppearing = false

        // testCharacterSet()
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
    func gotoScene(by menuItem: LXOutlineItem) {
        guard let scene = menuItem.scene,
              let vc = Navigator.default.show(segue: scene, sender: self) else {
            if menuItem.opt.section.title.hasPrefix("Section ") ||
                menuItem.opt.section.title.hasPrefix("Item ") {
                DJAutoRouter.router1.updateRouter(section: menuItem.opt.section)
                Navigator.default.show(segue: .vc(provider: {
                    let vc = LXSampleTextViewVC()
                    vc.title = menuItem.opt.section.title
                    vc.dataFillUnSupport(content: menuItem.opt.section.title)
                    return vc
                }), sender: self)
            }
            return
        }
        vc.title = menuItem.opt.section.title
        DJAutoRouter.router1.updateRouter(section: menuItem.opt.section)
    }
    func gotoAutoJumpRouteScene() -> [LXOutlineItem] {
        guard let router1 = DJAutoRouter.router1.getDefaultsValue(),
              let router1Menu = try? self.menuItems.xl_first(where: { $0.opt.section.title == router1 }) else {
                  return []
        }
        if(router1Menu.opt.section.title == LXOutlineVC.XL.typeNameString) {
            return []
        }
        var router1VC: UIViewController?
        if let scene = router1Menu.scene {
            router1VC = Navigator.default.show(segue: scene, sender: self)
            router1VC?.title = router1Menu.opt.section.title
        }

        /// LXToolKitObjCTestVC 跳转二级页面使用 String -> Class 方式, 如果 dataList 包含 router2, 则设置 autoJumpRoute 即可自动跳转
        if let vc = router1VC as? LXToolKitObjCTestVC,
           let router2 = DJAutoRouter.router2.getDefaultsValue(),
           vc.dataList.contains(router2) {
            vc.autoJumpRoute = router2
        }
        guard let router2 = DJAutoRouter.router2.getDefaultsValue(),
              let router2Menu = try? self.menuItems.xl_first(where: { $0.opt.section.title == router2 }) else {
            return [router1Menu]
        }
        if let scene = router2Menu.scene {
            let vc = Navigator.default.show(segue: scene, sender: self)
            vc?.title = router1Menu.opt.section.title
        }
        return [router1Menu, router2Menu];
    }
    func getDefaultExpandSection() -> [LXOutlineItem] {
        let autoPinned = DaoJiaConfig.LocalKey.autoPinnedDaoJiaSection
        guard let local = autoPinned.getValue(),
              local == "1",
              let djPage = try? self.menuItems.xl_first(where: { $0.opt.section.title == "Page List" })  else {
            return []
        }
        return [djPage]
    }
    func getDepth(destList: [LXOutlineItem]) -> [LXOutlineItem] {
        var depthList: [[LXOutlineItem]] = []
        for dest in destList {
            var depth: [LXOutlineItem] = [dest]
            for item in self.menuItems {
                let section = self.dataSource.snapshot(for: item)
                if !section.contains(dest) {
                    continue
                }
                var level = section.level(of: dest)
                var parent = section.parent(of: dest)
                while level >= 0, let p = parent {
                    // dlog("-->level[\(level)]: \(p)")
                    depth.append(p)
                    parent = section.parent(of: p)
                    level = section.level(of: p)
                }
            }
            depthList.append(depth)
        }
        let tmp = depthList.map { depth in
            return depth.map { $0.opt.section.title }
        }
        dlog("-->depthList: \(tmp)")
        return depthList.flatMap { $0 }
    }
    func getLastIndexPath(exList: [LXOutlineItem]) -> IndexPath? {
        if let lastItem = exList
            .first(where: {
                if case .subitem = $0.opt {
                    return true
                } else {
                    return false
                }
            }),
           let ip = self.dataSource.indexPath(for: lastItem) {
            dlog("-->lastItem[\(ip)]: \(lastItem)")
            return ip
        }
        if let lastSection = exList
            .first(where: {
                if case .outline = $0.opt {
                    return true
                } else {
                    return false
                }
            }),
           let ip = self.dataSource.indexPath(for: lastSection) {
            dlog("-->lastSection[\(ip)]: \(lastSection)")
            return ip
        }
        return nil
    }
}

// MARK: - 🔐
@available(iOS 14.0, *)
private extension LXOutlineVC {
    func testCharacterSet() {
        let set = CharacterSet.urlQueryAllowed
        print("set: \(set)")
        dlog("set: \(set)")
        dlog("set: \(set.description)")
        dlog("set: \(set.debugDescription)")
        dlog("set: \(String(describing: set))")
        dlog("set: \(String(reflecting: set))")
        dlog("set: \(set.allCharacters())")
        let data = set.bitmapRepresentation
        let desc = String(data: data, encoding: .utf8)
        // let img = UIImage(data: set.bitmapRepresentation)
        dlog("set: \(desc ?? "--")")
    }
    func testM() {
        for idx in 0...3 {
        }
        for idx in (0...3) {
        }
        for idx in [0...3] {
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
            // dlog("-->sectionIdx: \(sectionIdx)")
            var config = UICollectionLayoutListConfiguration(appearance: self.appearance)
            config.headerMode = .firstItemInSection
            // config.footerMode = .supplementary
            // config.backgroundColor = .white

            let bgDecoration = NSCollectionLayoutDecorationItem.background(elementKind: LXOutlineVC.sectionBackgroundDecorationElementKind)
            bgDecoration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)

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
            // if case .outline = self.menuItems[sectionIdx].opt {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .estimated(44))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                // <#item#>.contentInsets = NSDirectionalEdgeInsets(top: <#10.0#>, leading: <#10.0#>, bottom: <#10.0#>, trailing: <#10.0#>)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .estimated(44))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitems: [item])
                // <#group#>.contentInsets = NSDirectionalEdgeInsets(top: <#10.0#>, leading: <#10.0#>, bottom: <#10.0#>, trailing: <#10.0#>)
                group.contentInsets = .zero
                section = NSCollectionLayoutSection(group: group)
            // } else {
            //     section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
            // }
            // section.contentInsets = .zero
            section.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 10, bottom: 5, trailing: 10)
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
    func generateDataSource() -> UICollectionViewDiffableDataSource<LXOutlineItem, LXOutlineItem> {
        let outlineRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, LXOutlineItem> { cell, indexPath, menuItem in
            // cell.labTitle.text = "\(<#item#>)"
            var contentConfig = cell.defaultContentConfiguration()
            contentConfig.text = "\(menuItem.opt.section.title)."
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
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, LXOutlineItem> {[weak self] (cell, indexPath, menuItem) in
            guard let self else { return }
            // Populate the cell with our item description.
            // cell.label.text = "\(<#item#>)"
            var contentConfig = cell.defaultContentConfiguration()
            contentConfig.text = menuItem.opt.section.title
            // contentConfig.textProperties.color = .black
            cell.contentConfiguration = contentConfig

            switch self.appearance {
            case .sidebar, .sidebarPlain: cell.accessories = []
            default: cell.accessories = [.disclosureIndicator()]
            }
            let bgConfig = UIBackgroundConfiguration.clear()
            cell.backgroundConfiguration = bgConfig
        }
        let cellParamRegistration = UICollectionView.CellRegistration<LXOutlineParamCell, LXOutlineItem> { (cell, indexPath, item) in
            // Populate the cell with our item description.
            let tmp = item.opt.section.title.components(separatedBy: ":")
            let mockList: [String]? = tmp[safe: 2]?
                .components(separatedBy: ",")
                .map { $0.trimmed }
                .filter { $0.isNotEmpty }
            var defaultValue: String? = ""
            switch tmp[safe: 0] {
            case DJRouterPath.goodsDetail.title:
                if let prevSelectedGoodsId = DaoJiaConfig.LocalKey.previousSelectedGoodsId.getValue() {
                    defaultValue = mockList?.first(where: { $0.contains(prevSelectedGoodsId) && $0.components(separatedBy: "/").first?.trimmed == DJRouter.getCurrentEnv().title })
                }
            case DJRouterPath.getMain.title:
                defaultValue = mockList?
                    .first(where: { $0.components(separatedBy: "/").first?.trimmed == DJRouter.getCurrentEnv().title })
            case DJRouterPath.shopList.title:
                if let prevSelectedIdx = DaoJiaConfig.LocalKey.shopListType.getValue()?.int {
                    defaultValue = mockList?[safe: prevSelectedIdx]
                }
            default: break
            }
            cell.dataFill(title: tmp[safe: 0] ?? "", placeholder: tmp[safe: 1], mockList: mockList, defaultValue: defaultValue)
            cell.accessories = [
                .disclosureIndicator()
            ]

            let bgConfig = UIBackgroundConfiguration.clear()
            cell.backgroundConfiguration = bgConfig
        }
        let dataSource = UICollectionViewDiffableDataSource<LXOutlineItem, LXOutlineItem>(collectionView: collectionView) { collectionView, indexPath, item in
            switch item.opt {
            case .outline:
                return collectionView.dequeueConfiguredReusableCell(using: outlineRegistration, for: indexPath, item: item)
            case .subitem:
                if item.opt.section.title.contains("👉") {
                    return collectionView.dequeueConfiguredReusableCell(using: cellParamRegistration, for: indexPath, item: item)
                } else {
                    return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
                }
            }
        }
        // dataSource.sectionSnapshotHandlers.shouldCollapseItem = { opt in
        //     return !DJTestRouter.expandedSectionListItem.contains([opt])
        // }
        // dataSource.sectionSnapshotHandlers.willExpandItem = {[weak self] opt in
        //     // self?.gotoScene(by: opt.scene)
        //     dlog("-->willExpandItem: \(opt.opt.section.title)")
        //     // self?.expandedSectionList.insert(opt)
        // }
        // dataSource.sectionSnapshotHandlers.willCollapseItem = {[weak self] opt in
        //     // self?.gotoScene(by: opt.scene)
        //     dlog("-->willCollapseItem: \(opt.opt.section.title)")
        //     // self?.expandedSectionList.remove(opt)
        // }
        // dataSource.sectionSnapshotHandlers.snapshotForExpandingParent = {(item, snapshot) in
        //     dlog("-->snapshotForExpandingParent[\(item.opt.section.title)]: \(snapshot)")
        //     return snapshot
        // }
        let headerRegistration = UICollectionView.SupplementaryRegistration<LXCollectionHeaderFooterView>(elementKind: LXOutlineVC.sectionHeaderElementKind) {[weak self] supplementaryView, elementKind, indexPath in
            guard let model = self?.dataSource.itemIdentifier(for: indexPath) else { return }
            supplementaryView.dataFill("\(model.opt.section.title) - header")
        }
        let footerRegistration = UICollectionView.SupplementaryRegistration<LXCollectionHeaderFooterView>(elementKind: LXOutlineVC.sectionFooterElementKind) {[weak self] supplementaryView, elementKind, indexPath in
            guard let model = self?.dataSource.itemIdentifier(for: indexPath) else { return }
            supplementaryView.dataFill("\(model.opt.section.title) - footer")
        }
        dataSource.supplementaryViewProvider = {[weak self] collectionView, elementKind, indexPath in
            dlog("-->elementKind: \(elementKind)")
            return self?.collectionView.dequeueConfiguredReusableSupplementary(using: elementKind == LXOutlineVC.sectionHeaderElementKind ? headerRegistration : footerRegistration, for: indexPath)
        }
        return dataSource
    }
    func generateMultiSnapshot(_ dest: [LXOutlineItem] = []) {
        var destList = dest
        if destList.isEmpty {
            destList = getDefaultExpandSection()
        }
        let exList = getDepth(destList: destList)
        var expandList: [LXOutlineItem: NSDiffableDataSourceSectionSnapshot<LXOutlineItem>] = [:]
        func addItems(_ snapshot: inout NSDiffableDataSourceSectionSnapshot<LXOutlineItem>, menuItems: [LXOutlineItem], to parent: LXOutlineItem?) {
            for menuItem in menuItems {
                snapshot.append([menuItem], to: parent)
                switch menuItem.opt {
                case .outline:
                    addItems(&snapshot, menuItems: menuItem.subitems ?? [], to: menuItem)
                    if exList.contains(menuItem) {
                        snapshot.expand([menuItem])
                        expandList[menuItem] = snapshot
                    }
                    // snapshot.append(subitems, to: parent)
                case .subitem:
                    // snapshot.append([menuItem], to: parent)
                    break
                }
            }
        }
        var snapshot = NSDiffableDataSourceSnapshot<LXOutlineItem, LXOutlineItem>()
        snapshot.appendSections(self.menuItems)
        dataSource.apply(snapshot, animatingDifferences: true) {[weak self] in
            guard let self else { return }
            if let ip = self.getLastIndexPath(exList: exList) {
                self.collectionView.scrollToItem(at: ip, at: .centeredVertically, animated: true)
            }
        }
        for section in self.menuItems {
            snapshot.appendItems([section], toSection: section)
            switch section.opt {
            case .outline:
                var snapshot2 = NSDiffableDataSourceSectionSnapshot<LXOutlineItem>()
                snapshot2.append([section])
                addItems(&snapshot2, menuItems: section.subitems ?? [], to: section)
                if exList.contains(section) {
                    snapshot2.expand([section])
                    expandList[section] = snapshot2
                }
                dataSource.apply(snapshot2, to: section, animatingDifferences: true)
            case .subitem:
                var snapshot2 = NSDiffableDataSourceSectionSnapshot<LXOutlineItem>()
                snapshot2.append([section])
                dataSource.apply(snapshot2, to: section, animatingDifferences: true)
                break
            }
        }
    }
    func refreshCollectionView() {
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
        guard var menuItem = self.dataSource.itemIdentifier(for: indexPath) else { return }

        // let snapshot = self.dataSource.snapshot()
        // let sectionList = snapshot.sectionIdentifiers;
        // let idx = snapshot.indexOfItem(self.menuItems[0]) ?? -1
        // let idx1 = snapshot.indexOfItem(self.menuItems[1]) ?? -1
        // let section = snapshot.indexOfSection(self.menuItems[0]) ?? -1
        // let section1 = snapshot.indexOfSection(self.menuItems[1]) ?? -1
        // dlog("-->sectionList: \(sectionList.map({ $0.opt.section.title }))")
        // dlog("-->idx: (\(idx), \(idx1)), section: (\(section), \(section1))")
        // return
        // let random = Int.random(in: 0...10)
        // assert(random != 5, "test assert: \(random) at \(Date())")
        // if random == 6 {
        //     fatalError("test assert: \(random) at \(Date())")
        // }
        // checkAll(menuItem)
        // return
        guard menuItem.opt.section.title.contains("👉") else {
            gotoScene(by: menuItem)
            return
        }
        DJAutoRouter.router1.updateRouter(section: menuItem.opt.section)
        let tmp = menuItem.opt.section.title.components(separatedBy: ":")
        guard let path = DJRouterPath.from(tmp.first) else { return }
        switch path {
        case .shopList:
            guard let cell = collectionView.cellForItem(at: indexPath) as? LXOutlineParamCell else { return }
            let type = DJRouterPath.DJShopListType.from(string: cell.currentValue)
            DaoJiaConfig.LocalKey.shopListType.setValue("\(type.rawValue)")
            let scene: Navigator.Scene = .vc(provider: {
                let vc = DJRouterObjc.getShopListVC(type.sceneId, complection: {[weak self] in
                    guard let self else { return }
                    let gStore = DJStoreManager.sharedInstance().storeModel;
                    let scene = DJRouter.getDaoJia(storeCode: gStore.shopId, storeType: gStore.shopType)
                    Navigator.default.show(segue: scene, sender: self)
                })
                // return DJTestRouter.createNav(rootVC: vc)
                return vc
            })
            Navigator.default.show(segue: scene, sender: self)
        case .getMain:
            guard let cell = collectionView.cellForItem(at: indexPath) as? LXOutlineParamCell else { return }
            let param = cell.currentValue.components(separatedBy: "/")
            let storeCode = param[safe: 2]
            let storeType = param[safe: 3]
            let scene = DJRouter.getDaoJia(storeCode: storeCode, storeType: storeType)
            Navigator.default.show(segue: scene, sender: self)
        case .firstMedicine:
            guard let cell = collectionView.cellForItem(at: indexPath) as? LXOutlineParamCell else { return }
            let param = cell.currentValue.components(separatedBy: "/")
            let storeCode = param[safe: 2]
            let storeType = param[safe: 3]
            let scene = DJRouter.getFirstMedicine(storeCode: storeCode, storeType: storeType)
            Navigator.default.show(segue: scene, sender: self)
        case .goodsDetail:
            guard let cell = collectionView.cellForItem(at: indexPath) as? LXOutlineParamCell else { return }
            let param = cell.currentValue.components(separatedBy: "/")
            let gStore = DJStoreManager.sharedInstance().storeModel
            guard let storeCode = param[safe: 2],
                  gStore.shopId == storeCode,
                  let goodsId = param[safe: 3],
                  let tdType = param[safe: 4] else {
                self.view.makeToast("商品信息缺失~~ storeCode: (\(param[safe: 2] ?? "--"), \(gStore.shopId)), goodsId: \(param[safe: 3] ?? "--")")
                return
            }
            DaoJiaConfig.LocalKey.previousSelectedGoodsId.setValue(goodsId)
            let scene = DJRouter.getGoodsDetail(storeCode: gStore.shopId,
                                                storeType: gStore.shopType,
                                                merchantId: gStore.merchantId,
                                                goodsId: goodsId,
                                                tdType: tdType)
            Navigator.default.show(segue: scene, sender: self)
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
