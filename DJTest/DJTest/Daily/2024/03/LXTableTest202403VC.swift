//
//  LXTableTest202403VC.swift
//  DJTest
//
//  Created by lxthyme on 2024/3/23.
//
import UIKit
import LXToolKit_Example
import LXToolKitObjC_Example
import ActivityKit
import DJTestKit
import LXToolKit
import AcknowList

@available(iOS 14.0, *)
class LXTableTest202403VC: LXBaseVC {
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
    private var expandedSectionList: [LXOutlineOpt] = [] {
        didSet {
            // self.refreshCollectionView()
        }
    }
    // MARK: 🔗Vaiables
    private static let sectionHeaderElementKind = "sectionHeaderElementKind"
    private static let sectionFooterElementKind = "sectionFooterElementKind"
    private static let sectionBackgroundDecorationElementKind = "sectionBackgroundDecorationElementKind"
    private var isFirstAppearing = true
    private var dataSource: UICollectionViewDiffableDataSource<LXOutlineOpt, LXOutlineOpt>!
    private lazy var menuItems: [LXOutlineOpt] = {
        return [
            .subitem(.section(title: "Item 0 - 1")),
            .subitem(.section(title: "Item 0 - 2")),
            .outline(.section(title: "Section 1"), subitems: [
                .subitem(.section(title: "Item 1 - 1")),
                .outline(.section(title: "Section 12"), subitems: [
                    .subitem(.section(title: "Item 12 - 1")),
                    .outline(.section(title: "Section 13"), subitems: [
                        .subitem(.section(title: "Item 13 - 1")),
                        .outline(.section(title: "Section 14"), subitems: [
                            .subitem(.section(title: "Item 14 - 1")),
                            .subitem(.section(title: "Item 14 - 2")),
                        ]),
                        .subitem(.section(title: "Item 13 - 2")),
                    ]),
                    .subitem(.section(title: "Item 12 - 2")),
                ]),
                .subitem(.section(title: "Item 11 - 2")),
            ]),
            .subitem(.section(title: "Item 1.5 - 1")),
            .subitem(.section(title: "Item 1.5 - 2")),
            .subitem(.section(title: "Item 1.5 - 3")),
            .subitem(.section(title: "Item 1.5 - 4")),
            .subitem(.section(title: "Item 1.5 - 5")),
            .outline(.section(title: "Section 2"), subitems: [
                .subitem(.section(title: "Item 2 - 1")),
                .outline(.section(title: "Section 22"), subitems: [
                    .subitem(.section(title: "Item 22 - 1")),
                    .outline(.section(title: "Section 23"), subitems: [
                        .subitem(.section(title: "Item 23 - 1")),
                        .outline(.section(title: "Section 24"), subitems: [
                            .subitem(.section(title: "Item 24 - 1")),
                            .subitem(.section(title: "Item 24 - 2")),
                        ]),
                        .subitem(.section(title: "Item 23 - 2")),
                    ]),
                    .subitem(.section(title: "Item 22 - 2")),
                ]),
                .subitem(.section(title: "Item 21 - 2")),
            ]),
            .subitem(.section(title: "Item 2.5 - 1")),
            .subitem(.section(title: "Item 2.5 - 2")),
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
    }
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
    }

}

// MARK: 🌎LoadData
@available(iOS 14.0, *)
extension LXTableTest202403VC {}

// MARK: 👀Public Actions
@available(iOS 14.0, *)
extension LXTableTest202403VC {}

// MARK: - 🔐Activity
@available(iOS 14.0, *)
private extension LXTableTest202403VC {}

// MARK: - 🔐
@available(iOS 14.0, *)
private extension LXTableTest202403VC {
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
}

// MARK: - 🔐
@available(iOS 14.0, *)
private extension LXTableTest202403VC {}

// MARK: 🔐Private Actions
@available(iOS 14.0, *)
private extension LXTableTest202403VC {
    func generateLayout() -> UICollectionViewLayout {
        let sectionProvider = {[weak self] (sectionIdx: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            // guard let sectionKind = Section(rawValue: sectionIdx) else { return nil }
            guard let self else { return nil }
            dlog("-->sectionIdx0403: \(sectionIdx)")
            var config = UICollectionLayoutListConfiguration(appearance: self.appearance)
            config.headerMode = .firstItemInSection
            // config.footerMode = .supplementary
            // config.backgroundColor = .white

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let bgDecoration = NSCollectionLayoutDecorationItem.background(elementKind: LXTableTest202403VC.sectionBackgroundDecorationElementKind)
            // let bgDecoration = NSCollectionLayoutDecorationItem(layoutSize: itemSize)
            bgDecoration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            // bgDecoration.contentInsets = .zero

            // layout.register(LXSectionBgDecorationView.self, forDecorationViewOfKind: LXSectionDecorationVC.sectionBackgroundDecorationElementKind)

            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .estimated(44.0))
            let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .estimated(44.0))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                            elementKind: LXTableTest202403VC.sectionHeaderElementKind,
                                                                            alignment: .topLeading)
            let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize,
                                                                            elementKind: LXTableTest202403VC.sectionFooterElementKind,
                                                                            alignment: .bottomTrailing)
            let section: NSCollectionLayoutSection
            // if case .subitem = self.menuItems[sectionIdx] {
                // let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                //                                       heightDimension: .fractionalHeight(1.0))
                // let item = NSCollectionLayoutItem(layoutSize: itemSize)
                // <#item#>.contentInsets = NSDirectionalEdgeInsets(top: <#10.0#>, leading: <#10.0#>, bottom: <#10.0#>, trailing: <#10.0#>)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .estimated(44))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitems: [item])
                // <#group#>.contentInsets = NSDirectionalEdgeInsets(top: <#10.0#>, leading: <#10.0#>, bottom: <#10.0#>, trailing: <#10.0#>)
                section = NSCollectionLayoutSection(group: group)
            // } else {
            //     section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
                // section.contentInsets = .zero
                // section.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 10, bottom: 10, trailing: 10)
                // sectionHeader.pinToVisibleBounds = true
                // sectionHeader.zIndex = 2
            // if case .outline = self.menuItems[sectionIdx] {
            //     section.decorationItems = [bgDecoration]
            // }
                // section.boundarySupplementaryItems = [sectionHeader, sectionFooter]
            // }
            return section
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
        layout.register(LXBGNestedGroupDecorationView.self, forDecorationViewOfKind: LXTableTest202403VC.sectionBackgroundDecorationElementKind)
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
            let tmp = item.section.title.components(separatedBy: ":")
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
        let headerRegistration = UICollectionView.SupplementaryRegistration<LXCollectionHeaderFooterView>(elementKind: LXTableTest202403VC.sectionHeaderElementKind) {[weak self] supplementaryView, elementKind, indexPath in
            guard let model = self?.dataSource.itemIdentifier(for: indexPath) else { return }
            supplementaryView.dataFill("\(model.section.title) - header")
        }
        let footerRegistration = UICollectionView.SupplementaryRegistration<LXCollectionHeaderFooterView>(elementKind: LXTableTest202403VC.sectionFooterElementKind) {[weak self] supplementaryView, elementKind, indexPath in
            guard let model = self?.dataSource.itemIdentifier(for: indexPath) else { return }
            supplementaryView.dataFill("\(model.section.title) - footer")
        }
        dataSource.supplementaryViewProvider = {[weak self] collectionView, elementKind, indexPath in
            dlog("-->elementKind: \(elementKind)")
            return self?.collectionView.dequeueConfiguredReusableSupplementary(using: elementKind == LXTableTest202403VC.sectionHeaderElementKind ? headerRegistration : footerRegistration, for: indexPath)
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
    func generateMultiSnapshot4() {
        func addItem(sectionSnapshot: inout NSDiffableDataSourceSectionSnapshot<LXOutlineOpt>,
                     itemList: [LXOutlineOpt],
                     parent: LXOutlineOpt) {
            for menuItem in itemList {
                // snapshot.append([menuItem], to: parent)
                switch menuItem {
                case .outline(_, _, let subitems):
                    // snapshot.append([menuItem], to: parent)
                    // snapshot.append([menuItem])
                    sectionSnapshot.append([menuItem], to: parent)
                    addItem(sectionSnapshot: &sectionSnapshot, itemList: subitems, parent: menuItem)
                case .subitem:
                    sectionSnapshot.append([menuItem], to: parent)
                    break
                }
            }
        }
        let t1 = menuItems[0]
        let t2 = menuItems[1]
        let t3 = menuItems[2]
        let t4 = menuItems[3]
        let t5 = menuItems[4]

        let t3List = t3.subitems ?? []
        let t31 = t3List[0]
        let t32 = t3List[1]
        let t33 = t3List[2]
        var snapshot = NSDiffableDataSourceSnapshot<LXOutlineOpt, LXOutlineOpt>()
        snapshot.appendSections([t1, t2, t3, t4, t5])
        // snapshot.appendSections([])

        snapshot.appendItems([t1], toSection: t1)
        snapshot.appendItems([t2], toSection: t2)
        snapshot.appendItems([t3], toSection: t3)
        snapshot.appendItems([t4], toSection: t4)
        snapshot.appendItems([t5], toSection: t5)
        // snapshot.appendItems([t1], toSection: menuItem)

        // var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<LXOutlineOpt>()
        // sectionSnapshot.append([t2])
        // addItem(sectionSnapshot: &sectionSnapshot, itemList: t2.subitems!, parent: t2)
        // dataSource.apply(sectionSnapshot, to: t2)
        dataSource.apply(snapshot)
    }
    func generateMultiSnapshot() {
        func addItem(sectionSnapshot: inout NSDiffableDataSourceSectionSnapshot<LXOutlineOpt>,
                     itemList: [LXOutlineOpt],
                     parent: LXOutlineOpt) {
            for menuItem in itemList {
                // snapshot.append([menuItem], to: parent)
                switch menuItem {
                case .outline(_, _, let subitems):
                    // snapshot.append([menuItem], to: parent)
                    // snapshot.append([menuItem])
                    sectionSnapshot.append([menuItem], to: parent)
                    addItem(sectionSnapshot: &sectionSnapshot, itemList: subitems, parent: menuItem)
                case .subitem:
                    sectionSnapshot.append([menuItem], to: parent)
                    break
                }
            }
        }
        var snapshot = NSDiffableDataSourceSnapshot<LXOutlineOpt, LXOutlineOpt>()
        snapshot.appendSections(menuItems)
        for menuItem in menuItems {
            switch menuItem {
            case .outline(_, _, let subitems):
                // snapshot.appendSections([menuItem])
                snapshot.appendItems([menuItem], toSection: menuItem)

                var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<LXOutlineOpt>()
                sectionSnapshot.append([menuItem])
                addItem(sectionSnapshot: &sectionSnapshot, itemList: subitems, parent: menuItem)
                dataSource.apply(sectionSnapshot, to: menuItem)
            case .subitem:
                snapshot.appendItems([menuItem], toSection: menuItem)
                // snapshot.appendSections([menuItem])
                break
            }
        }


        dataSource.apply(snapshot)
    }
    func generateMultiSnapshot3() {
        var snapshot = NSDiffableDataSourceSectionSnapshot<LXOutlineOpt>()
        // var snapshot = NSDiffableDataSourceSnapshot<LXOutlineOpt, LXOutlineOpt>()
        func addItem(itemList: [LXOutlineOpt], to parent: LXOutlineOpt) {
            for menuItem in itemList {
                // snapshot.append([menuItem], to: parent)
                switch menuItem {
                case .outline(_, _, let subitems):
                    snapshot.append([menuItem], to: parent)
                    // snapshot.append([menuItem])
                    addItem(itemList: subitems, to: menuItem)
                case .subitem:
                    snapshot.append([menuItem], to: parent)
                }
            }
        }
        let section: LXOutlineOpt = .outline(.section(title: "TT"), subitems: self.menuItems)
        snapshot.append([section])
        addItem(itemList: section.subitems ?? [], to: section)


        dataSource.apply(snapshot, to: section)
    }
    func generateMultiSnapshot2() {
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
                    snapshot2.expand([menuItem])
                } else if self.expandedSectionList.contains([menuItem]) {
                    snapshot2.expand([menuItem])
                    expandList[menuItem] = snapshot2
                }
                dataSource.apply(snapshot2, to: menuItem, animatingDifferences: true)
            case .subitem:
                snapshot.appendItems([menuItem])
                break
            }
        }
        dataSource.apply(snapshot, animatingDifferences: true) {[weak self] in
            guard let self else { return }
            // if let lastItem = self.expandedSectionList.last,
            //    let lastIp = self.dataSource.indexPath(for: lastItem) {
            //     dlog("-->scroll to: \(lastIp)")
            //     self.collectionView.scrollToItem(at: lastIp, at: .centeredVertically, animated: true)
            // }
        }
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
extension LXTableTest202403VC: UICollectionViewDelegate {
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

    }
}

// MARK: - 🍺UI Prepare & Masonry
@available(iOS 14.0, *)
private extension LXTableTest202403VC {
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
#Preview("LXTableTest202403VC") {
    return LXTableTest202403VC()
}
