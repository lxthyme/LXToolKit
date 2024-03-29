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
    private var expandedSectionList: Set<LXOutlineItem> = [] {
        didSet {
            dlog("-->expandedSectionList: \(self.expandedSectionList.map({ $0.opt.section.title }))")
            self.refreshCollectionView()
        }
    }
    // MARK: 🔗Vaiables
    private static let sectionHeaderElementKind = "sectionHeaderElementKind"
    private static let sectionFooterElementKind = "sectionFooterElementKind"
    private static let sectionBackgroundDecorationElementKind = "sectionBackgroundDecorationElementKind"
    private var isFirstAppearing = true
    private var dataSource: UICollectionViewDiffableDataSource<LXOutlineItem, LXOutlineItem>!
    private lazy var menuItems: [LXOutlineItem] = {
        return [
            LXOutlineOpt.subitem(.section(title: "AcknowListViewController"), scene: .vc(provider: {
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
        ].map { DJTestRouter.makeRouterItem(from: $0) }
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
        guard let scene = menuItem.opt.scene,
              let vc = Navigator.default.show(segue: scene, sender: self) else {
            if menuItem.opt.section.title.hasPrefix("Section ") ||
                menuItem.opt.section.title.hasPrefix("Item ") {
                DJAutoRouter.router1.updateRouter(section: menuItem.opt.section)
                self.expandedSectionList.insert(menuItem)
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
        self.expandedSectionList.insert(menuItem)
    }
    func gotoAutoJumpRouteScene() {
        guard let router1 = DJAutoRouter.router1.getDefaultsValue(),
              let router1Menu = try? self.menuItems.xl_first(where: { $0.opt.section.title == router1 }) else {
                  return
        }
        if(router1Menu.opt.section.title == LXOutlineVC.XL.typeNameString) {
            return
        }
        var router1VC: UIViewController?
        if let scene = router1Menu.opt.scene {
            self.expandedSectionList.insert(router1Menu)
            router1VC = Navigator.default.show(segue: scene, sender: self)
            router1VC?.title = router1Menu.opt.section.title
        }
        /// LXToolKitObjCTestVC 跳转二级页面使用 String -> Class 方式, 如果 dataList 包含 router2, 则设置 autoJumpRoute 即可自动跳转
        if let vc = router1VC as? LXToolKitObjCTestVC,
           let router2 = DJAutoRouter.router2.getDefaultsValue(),
           vc.dataList.contains(router2) {
            vc.autoJumpRoute = router2
            return
        }
        guard let router2 = DJAutoRouter.router2.getDefaultsValue(),
              let router2Menu = try? self.menuItems.xl_first(where: { $0.opt.section.title == router2 }) else {
            return
        }
        if let scene = router2Menu.opt.scene {
            let vc = Navigator.default.show(segue: scene, sender: self)
            vc?.title = router1Menu.opt.section.title
        }
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
            // if case .subitem = self.menuItems[sectionIdx] {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(1.0))
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
            let defaultValue = mockList?
                .first(where: { $0.components(separatedBy: "/").first?.trimmed == DJRouter.getCurrentEnv().title2 })
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
    // func generateSnapshot() -> NSDiffableDataSourceSectionSnapshot<LXOutlineOpt> {
    //     var snapshot = NSDiffableDataSourceSectionSnapshot<LXOutlineOpt>()
    // 
    //     func addItems(_ menuItems: [LXOutlineOpt], to parent: LXOutlineOpt?) {
    //         snapshot.append(menuItems, to: parent)
    // 
    //         // for menuItem in menuItems where menuItem.subitems.isNotEmpty {
    //         //     addItems(menuItem.subitems, to: menuItem)
    //         // }
    //         for menuItem in menuItems {
    //             switch menuItem {
    //             case .outline(_, _, let subitems):
    //                 addItems(subitems, to: menuItem)
    //             case .subitem:
    //                 break
    //             }
    //         }
    //     }
    // 
    //     for menuItem in self.menuItems {
    //         snapshot.append([menuItem], to: nil)
    //         switch menuItem {
    //         case .outline(_, _, let subitems):
    //             addItems(subitems, to: menuItem)
    //         case .subitem:
    //             break
    //         }
    //     }
    //     return snapshot
    // }
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
        var exList: [LXOutlineItem] = []
        if menuItems.count > 6 {
            let dj1 = menuItems[6]
            let dj2 = dj1.subitems![3]
            let dj3 = dj2.subitems![1]
            exList = [dj1, dj2, dj3]
        }
        var expandList: [LXOutlineItem: NSDiffableDataSourceSectionSnapshot<LXOutlineItem>] = [:]
        func addItems(_ snapshot: inout NSDiffableDataSourceSectionSnapshot<LXOutlineItem>, menuItems: [LXOutlineItem], to parent: LXOutlineItem?) {
            for menuItem in menuItems {
                snapshot.append([menuItem], to: parent)
                switch menuItem.opt {
                case .outline(_, _, _):
                    // if !snapshot.contains(menuItem) {
                    //     snapshot.append([menuItem], to: parent)
                    // }
                    // if menuItem.isExpanded {
                    //     snapshot.expand([menuItem])
                    // }
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
            if let lastItem = self.expandedSectionList.first,
               let lastIp = self.dataSource.indexPath(for: lastItem) {
                dlog("-->scroll to: \(lastIp)")
                self.collectionView.scrollToItem(at: lastIp, at: .centeredVertically, animated: true)
            }
        }
        // snapshot.appendItems([DJTestRouter.routerDynamicIsland])
        for section in self.menuItems {
            // snapshot.appendItems([section], toSection: section)
            switch section.opt {
            case .outline(_, _, _):
                // snapshot.appendItems([menuItem], toSection: menuItem)

                var snapshot2 = NSDiffableDataSourceSectionSnapshot<LXOutlineItem>()
                snapshot2.append([section])
                // snapshot2.append(subitems, to: menuItem)
                addItems(&snapshot2, menuItems: section.subitems ?? [], to: section)
                // if DJTestRouter.expandedSectionListItem.contains([menuItem]) {
                //     expandList[menuItem] = snapshot2
                //     snapshot2.expand([menuItem])
                // } else if self.expandedSectionList.contains([menuItem]) {
                //     snapshot2.expand([menuItem])
                //     expandList[menuItem] = snapshot2
                // }
                // if Set(menuItem.subitems ?? []).intersection(self.expandedSectionList).count > 0 {
                //     snapshot2.expand([menuItem])
                // }
                // if menuItem.isExpanded {
                //     snapshot2.expand([menuItem])
                // }
                if exList.contains(section) {
                    snapshot2.expand([section])
                    expandList[section] = snapshot2
                }
                dataSource.apply(snapshot2, to: section, animatingDifferences: true)
            case .subitem:
                // snapshot.appendItems([menuItem], toSection: menuItem)
                break
            }
        }
        // for (key, value) in expandList {
        //     var tmp = value
        //     tmp.expand([key])
        //     dataSource.apply(tmp, to: key, animatingDifferences: true)
        // }
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
            UIAction(title: "test", handler: {[weak self] _ in
                // self?.test233()
                self?.test235()
            }),
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
    func test233() {
        refreshCollectionView()
        // let section = menuItems[1]
        // expandItem(item: section)
        // let ip = self.dataSource.indexPath(for: section)
        // dlog("-->ip: \(ip)")
        // self.dataSource.snapshot(for: section).expand([section)]
        // self.dataSource.snapshot().reloadSections(<#T##identifiers: [LXOutlineOpt]##[LXOutlineOpt]#>)
        // dlog("------------")
        // if let item = section.subitems?.first {
        //     expandItem(item: item)
        // }
    }
    func expandItem(item: LXOutlineItem) {
        let snapshot = self.dataSource.snapshot(for: item)
        logSnapshot(snapshot)
        dlog("-->tmp0: \(self.dataSource.sectionSnapshotHandlers.snapshotForExpandingParent)")
        dlog("-->tmp1: \(self.dataSource.sectionSnapshotHandlers.willExpandItem)")
        dlog("-->tmp2: \(self.dataSource.sectionSnapshotHandlers.willCollapseItem)")
        dlog("-->tmp3: \(self.dataSource.sectionSnapshotHandlers.shouldExpandItem)")
        dlog("-->tmp4: \(self.dataSource.sectionSnapshotHandlers.shouldCollapseItem)")
        let result = self.dataSource.sectionSnapshotHandlers.snapshotForExpandingParent?(item, snapshot)
        let result2 = self.dataSource.sectionSnapshotHandlers.willExpandItem?(item)
        dlog("-->result: \(result)")
        dlog("-->result2: \(result2)")
        logSnapshot(result)
    }
    func logSnapshot(_ snapshot: NSDiffableDataSourceSectionSnapshot<LXOutlineItem>?) {
        guard let snapshot else {
            dlog("-->snapshot: nil")
            return
        }
        let t1 = snapshot.rootItems.map { $0.opt.section.title }
        let t2 = snapshot.items.map { $0.opt.section.title }
        // dlog("-->snapshot: \(snapshot.visualDescription())")
        dlog("-->rootItems: \(t1)")
        dlog("-->items: \(t2)")
    }
    func test234() {
        let snapshot = self.dataSource.snapshot()
        // let t1 = snapshot.itemIdentifiers
        // let t2 = snapshot.sectionIdentifiers
        // dlog("-->t1: \(t1.map({ $0.section.title }))")
        // dlog("-->t2: \(t2.map({ $0.section.title }))")
        guard let item = expandedSectionList.first else { return }
        // let t = self.dataSource.sectionSnapshotHandlers.willCollapseItem?(item)
        // dlog("-->t: \(t)")
        // for item in expandedSectionList {
            for sectionItem in snapshot.sectionIdentifiers {
                let section = self.dataSource.snapshot(for: sectionItem)
                var p = section
                var subitem: LXOutlineItem? = item
                while let subitem2 = subitem,
                      p.contains(subitem2) {
                    let level = section.level(of: subitem2)
                    p.expand([subitem2])
                    self.dataSource.apply(p, to: subitem2)
                    dlog("-->level[\(level)]: \(subitem2.opt.section.title)")
                    // p = p.snapshot(of: subitem2)
                    subitem = p.parent(of: subitem2)
                    p = self.dataSource.snapshot(for: subitem2)
                }
            }
        // }
    }
    func test235() {
        let d1 = self.menuItems[0]
        let d2 = d1.subitems![1]
        let d3 = d2.subitems![3]
        let d4 = d3.subitems![1]
        let d5 = d3.subitems![1]
        let result = checkAll(d5)
        dlog("-->result: \(result.map({ $0.opt.section.title }))")
    }
    func checkAll(_ item: LXOutlineItem) -> [LXOutlineItem] {
        var destList: [LXOutlineItem] = []
        var isExist = false
        func fbs(list: [LXOutlineItem], dest: LXOutlineItem) {
            for subItem in list {
                // if subItem.subitems?.isNotEmpty ?? false {
                    dlog("-->section in[\(isExist)]: \(subItem.opt.section.title)")
                // }
                if subItem.opt.section.title == dest.opt.section.title {
                    isExist = true
                    destList.append(subItem)
                }
                guard let list2 = subItem.subitems, list2.isNotEmpty else { continue }
                fbs(list: list2, dest: dest)
                // isExist = false
                // isExist = false
                dlog("-->section out[\(isExist)]: \(subItem.opt.section.title)")
            }
        }
        for subItem in self.menuItems {
            if let list = subItem.subitems, list.isNotEmpty {
                isExist = false
                fbs(list: list, dest: item)
            }
        }
        // var snapshot = self.dataSource.snapshot()
        // for sectionItem in snapshot.sectionIdentifiers {
        //     let section = self.dataSource.snapshot(for: sectionItem)
        //     var p = section
        //     var subitem: LXOutlineItem? = item
        //     repeat {
        //         guard var subitem2 = subitem else { return }
        //         dlog("-->item: \(subitem2.opt.section.title)")
        //         subitem2.isExpanded = true
        //         guard p.contains(subitem2) else { return }
        //         let level = section.level(of: subitem2)
        //         // self.dataSource.apply(p, to: subitem2)
        //         dlog("-->level[\(level)]: \(subitem2.opt.section.title)")
        //         // p = p.snapshot(of: subitem2)
        //         subitem = p.parent(of: subitem2)
        //         p = self.dataSource.snapshot(for: subitem2)
        //     } while 1 == 1
        // }
        return destList
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard var menuItem = self.dataSource.itemIdentifier(for: indexPath) else { return }

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
        let tmp = menuItem.opt.section.title.components(separatedBy: ":")
        guard let path = DJRouterPath.from(tmp.first) else { return }
        switch path {
        case .getMain:
            guard let cell = collectionView.cellForItem(at: indexPath) as? LXOutlineParamCell else { return }
            let param = cell.currentValue.components(separatedBy: "/")
            guard let storeCode = param[safe: 1],
                  let storeType = param[safe: 2] else {
                return
            }
            let scene: Navigator.Scene = .vc(provider: {
                let vc = DJRouter.getMain(storeCode: storeCode, storeType: storeType)!
                let nav = DJTestRouter.createNav(rootVC: vc) {
                    DJSavedData.saveGStore()
                }
                return nav
            }, transition: .alert)
            Navigator.default.show(segue: scene, sender: self)
        case .goodsDetail:
            guard let cell = collectionView.cellForItem(at: indexPath) as? LXOutlineParamCell else { return }
            let param = cell.currentValue.components(separatedBy: "/")
            let gStore = DJRouterObjc.gStore()
            guard let storeCode = param[safe: 2],
                  gStore.shopId == storeCode,
                  let goodsId = param[safe: 3],
                  let tdType = param[safe: 4] else {
                return
            }
            let scene: Navigator.Scene = .vc(provider: {
                let vc = DJRouter.getGoodsDetail(storeCode: gStore.shopId,
                                                 storeType: gStore.shopType,
                                                 merchantId: gStore.merchantId,
                                                 goodsId: goodsId,
                                                 tdType: tdType)
                let nav = DJTestRouter.createNav(rootVC: vc) {
                    DJSavedData.saveGStore()
                }
                return nav
            }, transition: .alert)
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
