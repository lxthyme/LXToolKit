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
    private var dataSource: UICollectionViewDiffableDataSource<LXOutlineOpt, LXOutlineOpt>!
    var autoJumpRoute: DJTestType?
    private lazy var menuItems: [LXOutlineOpt] = {
        return [
            LXToolKitRouter.kitRouter,
            LXToolKitObjcRouter.objcRouter,
            .subitem(title: "DJSwiftModule", scene: .vc(provider: {
                DJTestType.DJSwiftModule.updateRouter(vcName: "")
                let window = UIApplication.XL.keyWindow
                Application.shared.presentInitialScreen(in: window)
                return nil
            })),
            .subitem(title: "dynamicIsland", scene: .vc(provider: {
                if #available(iOS 16.2, *) {
                    UIHostingController(rootView: EmojiRangersView())
                } else {
                    // Fallback on earlier versions
                    LXNonSupportedVC(title: "当前设备不支持灵动岛!")
                }
            })),
            .outline(title: "DJTest", subitems: [
                .subitem(title: "LXAMapTestVC", scene: .vc(provider: { LXAMapTestVC() })),
                .subitem(title: "LXOutlineVC", scene: .vc(provider: { LXOutlineVC() })),
            ].reversed()),
        ]
    }()
    // @available(iOS 13.0, *)
    private var dataSnapshot: UICollectionViewDiffableDataSource<LXOutlineOpt, LXOutlineOpt>!
    var appearance: UICollectionLayoutListConfiguration.Appearance = .plain
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareCollectionView()
        prepareUI()

        gotoAutoJumpRouteScene()

        startActivity()
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
    func gotoScene(by scene: Navigator.Scene?) {
        guard let scene,
              let vc = Navigator.default.show(segue: scene, sender: self) else {
            DJTestType.LXToolKit_Example.updateRouter(vcName: "")
            if let provider = scene?.vcProvider {
                let result = provider()
                dlog("-->vc: \(result)")
            }
            return
        }
        DJTestType.LXToolKit_Example.updateRouter(vcName: vc.xl.xl_typeName)
    }
    func gotoAutoJumpRouteScene() {
        let route1Int = UserDefaults.standard.integer(forKey: DJTestType.AutoJumpRoute)
        guard let type = DJTestType.fromInt(idx: route1Int),
              let item = self.menuItems.first(where: { $0.title == type.title }) else {
            dlog("-->gotoScene error on scene[1]")
            return
        }
        let scene = item.scene != nil ? item.scene : item.subitems?.first?.scene
        guard let scene else {
            dlog("-->gotoScene error on scene[2]")
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
        let route2 = UserDefaults.standard.string(forKey: type.userDefaultsKey()) ?? ""
        if let vc = vc as? LXToolKitTestVC {
            let itemOpt: LXOutlineOpt
            do {
                itemOpt = try LXToolKitRouter.kitRouter.xl_first(where: { $0.title == route2 })
            } catch {
                dlog("-->error: \(error)")
                itemOpt = .subitem(title: "LXToolKit_Example." + route2,
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
        } else if let vc = vc as? LXToolKitObjcTestVC {
            var itemOpt: LXOutlineOpt
            do {
                itemOpt = try LXToolKitObjcRouter.objcRouter.xl_first(where: { $0.title == route2 })
            } catch {
                dlog("-->error: \(error)")
                itemOpt = .subitem(title: "",
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
@available(iOS 14.0, *)
private extension LXOutlineVC {
    func generateLayout() -> UICollectionViewLayout {
        let sectionProvider = {[weak self] (sectionIdx: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            // guard let sectionKind = Section(rawValue: sectionIdx) else { return nil }
            guard let self else { return nil }
            var config = UICollectionLayoutListConfiguration(appearance: self.appearance)
            config.headerMode = .firstItemInSection
            // config.footerMode = .supplementary
            config.backgroundColor = .white

            let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
            // section.contentInsets = NSDirectionalEdgeInsets(top: <#10.0#>, leading: <#10.0#>, bottom: <#10.0#>, trailing: <#10.0#>)

            return section
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
    }
    func generateCollectionView() -> UICollectionView {
        let layout = generateLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv;
    }
    func generateDataSource() -> UICollectionViewDiffableDataSource<LXOutlineOpt, LXOutlineOpt> {
        let containerCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, LXOutlineOpt> { cell, indexPath, menuItem in
            guard case .outline(let title, _, _) = menuItem else { return }
            // cell.labTitle.text = "\(<#item#>)"
            var contentConfig = cell.defaultContentConfiguration()
            contentConfig.text = title
            contentConfig.textProperties.color = .black
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
            contentConfig.textProperties.color = .black
            cell.contentConfiguration = contentConfig
            cell.backgroundConfiguration = UIBackgroundConfiguration.clear()
        }
        let dataSource = UICollectionViewDiffableDataSource<LXOutlineOpt, LXOutlineOpt>(collectionView: collectionView) { collectionView, indexPath, item in
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
        return snapshot
    }
    func generateMultiSnapshot() -> [LXOutlineOpt: NSDiffableDataSourceSectionSnapshot<LXOutlineOpt>] {
        // var snapshot = NSDiffableDataSourceSectionSnapshot<LXOutlineOpt>()
    
        func addItems(_ snapshot: inout NSDiffableDataSourceSectionSnapshot<LXOutlineOpt>, menuItems: [LXOutlineOpt], to parent: LXOutlineOpt?) {
            snapshot.append(menuItems, to: parent)
    
            // for menuItem in menuItems where menuItem.subitems.isNotEmpty {
            //     addItems(menuItem.subitems, to: menuItem)
            // }
            for menuItem in menuItems {
                switch menuItem {
                case .outline(_, let subitems, _):
                    addItems(&snapshot, menuItems: subitems, to: menuItem)
                case .subitem:
                    break
                }
            }
        }
    
        var list: [LXOutlineOpt: NSDiffableDataSourceSectionSnapshot<LXOutlineOpt>] = [:]
        for menuItem in self.menuItems {
            var snapshot = NSDiffableDataSourceSectionSnapshot<LXOutlineOpt>()
            snapshot.append([menuItem])
            snapshot .expand([menuItem])
            switch menuItem {
            case .outline(_, let subitems, _):
                addItems(&snapshot, menuItems: subitems, to: menuItem)
                // dataSource.apply(snapshot, to: menuItem, animatingDifferences: true)
                list[menuItem] = snapshot
            case .subitem:
                break
            }
        }
        return list
    }
    func refreshCollectionView() {
        // let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first
        // let snapshot = dataSource.snapshot()
        // dlog("-->snapshot: \(snapshot)")
        // dataSource.apply(dataSource.snapshot(), animatingDifferences: true)
        // collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: [])
        let snapshotList = generateMultiSnapshot()
        snapshotList.forEach {
            self.dataSource.apply($0.value, to: $0.key, animatingDifferences: true)
        }
    }
}

@available(iOS 14.0, *)
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
@available(iOS 14.0, *)
extension LXOutlineVC {
    func prepareCollectionView() {
        if #available(iOS 14.0, *) {
            collectionView = generateCollectionView()
            dataSource = generateDataSource()
            let snapshotList = generateMultiSnapshot()
            snapshotList.forEach {
                self.dataSource.apply($0.value, to: $0.key, animatingDifferences: true)
            }
            // let snapshot = generateSnapshot()
            // dlog("-->snapshot: \(snapshot.items)")
            // self.dataSource.apply(snapshot, to: .main, animatingDifferences: true)
        } else {
            // Fallback on earlier versions
            collectionView = UICollectionView(frame: .zero)
        }
        collectionView.delegate = self
    }
    override func prepareUI() {
        super.prepareUI()
        self.view.backgroundColor = .cyan
        // navigationItem.title = ""
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "Appearance", menu: UIMenu(children: [
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
            ]))
        ]

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

@available(iOS 14.0, *)
#Preview("LXOutlineVC") {
    return LXOutlineVC()
}
