//
//  LXAccessoryListVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/12/1.
//
import UIKit
import DJTestKit
import LXToolKit
import Toast_Swift

@available(iOS 16.0, *)
enum LXAccessoryOpt {
    case outline(_ section: LXSection, accessory: UICellAccessoryEnum, subitems: [LXAccessoryOpt])
    case subitems(_ section: LXSection, accessory: UICellAccessoryEnum)

    var section: LXSection {
        switch self {
        case .outline(let section, _, _):
            return section
        case .subitems(let section, _):
            return section
        }
    }
    var accessory: UICellAccessoryEnum {
        switch self {
        case .outline(_, let accessory, _):
            return accessory
        case .subitems(_, let accessory):
            return accessory
        }
    }
    var subitems: [LXAccessoryOpt]? {
        switch self {
        case .outline(let _, let _, let subitems):
            return subitems
        case .subitems:
            return nil
        }
    }
}

// MARK: - 👀
@available(iOS 16.0, *)
extension LXAccessoryOpt: Hashable {
    static func == (lhs: LXAccessoryOpt, rhs: LXAccessoryOpt) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    func hash(into hasher: inout Hasher) {
        switch self {
        case .outline(let section, let accessory, let subitems):
            hasher.combine("\(section)_\(accessory)_subitems: \(subitems)")
        case .subitems(let section, let accessory):
            hasher.combine("\(section)_\(accessory)")
        }
    }
}

// MARK: - 👀
@available(iOS 16.0, *)
extension LXAccessoryOpt: CustomStringConvertible {
    var description: String {
        switch self {
        case .outline(let section, let accessory, let subitems):
            return ".outline(\(section), accessory: \(accessory), subitems: \(subitems))"
        case .subitems(let section, let accessory):
            return ".subitems(\(section), accessory: \(accessory))"
        }
    }
}

@available(iOS 16.0, *)
class LXAccessoryListVC: LXBaseVC {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    private static let sectionBackgroundDecorationElementKind = "sectionBackgroundDecorationElementKind"
    private static let sectionHeaderElementKind = "sectionHeaderElementKind"
    private static let sectionFooterElementKind = "sectionFooterElementKind"
    private var collectionView: UICollectionView!
    // @available(iOS 16.0, *)
    private var dataSource: UICollectionViewDiffableDataSource<LXAccessoryOpt, LXAccessoryOpt>!
    private var displayedState: UICellAccessory.DisplayedState = .always
    private var reservedLayoutWidth: UICellAccessory.LayoutDimension = .standard
    private var outlineDisclosuretyle: UICellAccessory.OutlineDisclosureOptions.Style = .automatic
    private var isHidden = false
    private var showsVerticalSeparator = true
    private var tintColor: UIColor = .random
    private var backgroundColor: UIColor = .random
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareCollectionView()
        prepareUI()
    }

}

// MARK: 🌎LoadData
@available(iOS 16.0, *)
extension LXAccessoryListVC {}

// MARK: 👀Public Actions
@available(iOS 16.0, *)
extension LXAccessoryListVC {}

// MARK: 🔐Private Actions
@available(iOS 16.0, *)
private extension LXAccessoryListVC {
    func makeToast(_ msg: String?) {
        UIApplication.XL.keyWindow?.rootViewController?.view.makeToast(msg)
    }
}

// MARK: - 🔐
@available(iOS 16.0, *)
private extension LXAccessoryListVC {
    func generateListAccessory() -> [UICellAccessoryEnum] {
        let disclosureIndicatorOptions: UICellAccessory.DisclosureIndicatorOptions = .init(
            isHidden: isHidden,
            reservedLayoutWidth: reservedLayoutWidth,
            tintColor: tintColor
        )
        let checkmarkOptions: UICellAccessory.CheckmarkOptions = .init(
            isHidden: isHidden,
            reservedLayoutWidth: reservedLayoutWidth,
            tintColor: tintColor
        )
        let deleteOptions: UICellAccessory.DeleteOptions = .init(
            isHidden: isHidden,
            reservedLayoutWidth: reservedLayoutWidth,
            tintColor: tintColor,
            backgroundColor: backgroundColor
        )
        let insertOptions: UICellAccessory.InsertOptions = .init(
            isHidden: isHidden,
            reservedLayoutWidth: reservedLayoutWidth,
            tintColor: tintColor,
            backgroundColor: backgroundColor
        )
        let reorderOptions: UICellAccessory.ReorderOptions = .init(
            isHidden: isHidden,
            reservedLayoutWidth: reservedLayoutWidth,
            tintColor: tintColor, 
            showsVerticalSeparator: showsVerticalSeparator
        )
        let multiselectOptions: UICellAccessory.MultiselectOptions = .init(
            isHidden: isHidden,
            reservedLayoutWidth: reservedLayoutWidth,
            tintColor: tintColor,
            backgroundColor: backgroundColor
        )
        let outlineDisclosureOptions: UICellAccessory.OutlineDisclosureOptions = .init(
            style: outlineDisclosuretyle,
            isHidden: isHidden,
            reservedLayoutWidth: reservedLayoutWidth,
            tintColor: tintColor
        )
        let labelOptions: UICellAccessory.LabelOptions = .init(
            isHidden: isHidden,
            reservedLayoutWidth: reservedLayoutWidth,
            tintColor: tintColor,
            font: .systemFont(ofSize: 14),
            adjustsFontForContentSizeCategory: true
        )
        var list: [UICellAccessoryEnum] = [
            .disclosureIndicator(displayed: displayedState, options: disclosureIndicatorOptions),
            // .detail(displayed: .always, options: detailOptions, actionHandler: {
            //     dlog("-->detail")
            // }),
            .checkmark(displayed: displayedState, options: checkmarkOptions),
            .delete(displayed: .always, options: deleteOptions, actionHandler: {[weak self] in
                let msg = "-->delete"
                dlog(msg)
                self?.makeToast(msg)
            }),
            .insert(displayed: displayedState, options: insertOptions, actionHandler: {[weak self] in
                let msg = "-->insert"
                dlog(msg)
                self?.makeToast(msg)
            }),
            .reorder(displayed: displayedState, options: reorderOptions),
            .multiselect(displayed: displayedState, options: multiselectOptions),
            .outlineDisclosure(displayed: displayedState, options: outlineDisclosureOptions, actionHandler: {[weak self] in
                let msg = "-->outlineDisclosure"
                dlog(msg)
                self?.makeToast(msg)
            }),
            // .popUpMenu(menu, displayed: .always, options: popUpMenuOptions, selectedElementDidChangeHandler: { menu in
            //     dlog("-->popUpMenu: \(menu)")
            // }),
            .label(text: "label accessory", displayed: displayedState, options: labelOptions),
            .customView(configuration: UICellAccessoryEnum.customViewConfiguration(UICellAccessoryEnum.createCustomLabel(title: "🚀X"), isHidden: isHidden, reservedLayoutWidth: reservedLayoutWidth, tintColor: tintColor)),
        ]

        if #available(iOS 15.4, *) {
            let detailOptions: UICellAccessory.DetailOptions = .init(
                isHidden: isHidden,
                reservedLayoutWidth: reservedLayoutWidth,
                tintColor: tintColor
            )
            let detailItem: UICellAccessoryEnum = .detail(displayed: .always, options: detailOptions, actionHandler: {[weak self] in
                let msg = "-->detail"
                dlog(msg)
                self?.makeToast(msg)
            })
            list.append(detailItem)
        }
        if #available(iOS 17.0, *) {
            let menu = UIMenu(
                title: "Title 1",
                subtitle: "Subtitle 1",
                options: .displayAsPalette,
                children: [
                    UIAction(title: "Item 1", handler: {[weak self] _ in
                        let msg = "-->Item 1"
                        dlog(msg)
                        self?.makeToast(msg)
                    }),
                    UIAction(title: "Item 2", handler: {[weak self] _ in
                        let msg = "-->Item 2"
                        dlog(msg)
                        self?.makeToast(msg)
                    }),
                    UIAction(title: "Item 3", handler: {[weak self] _ in
                        let msg = "-->Item 3"
                        dlog(msg)
                        self?.makeToast(msg)
                    }),
                    UIAction(title: "Item 4", handler: {[weak self] _ in
                        let msg = "-->Item 4"
                        dlog(msg)
                        self?.makeToast(msg)
                    }),
                    UIAction(title: "Item 5", handler: {[weak self] _ in
                        let msg = "-->Item 5"
                        dlog(msg)
                        self?.makeToast(msg)
                    }),
                ]
            )
            let popUpMenuOptions: UICellAccessory.PopUpMenuOptions = .init(
                isHidden: isHidden,
                reservedLayoutWidth: reservedLayoutWidth,
                tintColor: tintColor
            )
            let item: UICellAccessoryEnum = .popUpMenu(menu, displayed: .always, options: popUpMenuOptions, selectedElementDidChangeHandler: {[weak self] menu in
                let msg = "-->popUpMenu[outline]: \(menu.title)"
                dlog(msg)
                self?.makeToast(msg)
            })
            list.append(item)
        }
        return list
    }
    func generateLayout() -> UICollectionViewLayout {
        let sectionProvider = {[weak self] (sectionIdx: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            // guard let sectionKind = Section(rawValue: sectionIdx) else { return nil }
            guard let self else { return nil }
            dlog("-->sectionIdx: \(sectionIdx)")
            var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            config.headerMode = .firstItemInSection
            // config.footerMode = .supplementary
            // config.backgroundColor = .white

            let bgDecoration = NSCollectionLayoutDecorationItem.background(elementKind: LXAccessoryListVC.sectionBackgroundDecorationElementKind)
            bgDecoration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

            // layout.register(LXSectionBgDecorationView.self, forDecorationViewOfKind: LXSectionDecorationVC.sectionBackgroundDecorationElementKind)

            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .estimated(44.0))
            let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .estimated(44.0))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                            elementKind: LXAccessoryListVC.sectionHeaderElementKind,
                                                                            alignment: .topLeading)
            let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize,
                                                                            elementKind: LXAccessoryListVC.sectionFooterElementKind,
                                                                            alignment: .bottomTrailing)
            let section: NSCollectionLayoutSection
            if case .subitems = self.dataSource.sectionIdentifier(for: sectionIdx) {
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
        layout.register(LXBGNestedGroupDecorationView.self, forDecorationViewOfKind: LXAccessoryListVC.sectionBackgroundDecorationElementKind)
        return layout
    }
    func generateCollectionView() -> UICollectionView {
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: generateLayout())
        // cv.backgroundColor = <#.systemGroupedBackground#>
        cv.delegate = self
        return cv
    }
    func generateDataSource() -> UICollectionViewDiffableDataSource<LXAccessoryOpt, LXAccessoryOpt> {
        let outlineRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, LXAccessoryOpt> { cell, indexPath, item in
            var contentConfig = cell.defaultContentConfiguration()
            contentConfig.text = item.section.title
            cell.contentConfiguration = contentConfig

            let disclosureOpt = UICellAccessory.OutlineDisclosureOptions(style: .header)
            var tmp: [UICellAccessory] = [
                // .outlineDisclosure()
                .outlineDisclosure(options: disclosureOpt)
            ]
            if item.accessory.value.accessoryType == .outlineDisclosure {
            // } else if case .customView = item.accessory.value.accessoryType {
            } else {
                tmp.append(item.accessory.value)
                dlog("-->contain[header]: \(item.accessory)")
            }
            cell.accessories = tmp

            let bgConfig = UIBackgroundConfiguration.clear()
            cell.backgroundConfiguration = bgConfig
        }
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, LXAccessoryOpt> { cell, indexPath, item in
            var contentConfig = cell.defaultContentConfiguration()
            contentConfig.text = "\(item.accessory)"
            cell.contentConfiguration = contentConfig

            var tmp: [UICellAccessory] = [
                .disclosureIndicator()
            ]
            if item.accessory.value.accessoryType == .disclosureIndicator {
            // } else if case .customView = item.accessory.value.accessoryType {
            } else {
                tmp.append(item.accessory.value)
                dlog("-->contain[cell]: \(item.accessory.value)")
            }
            cell.accessories = tmp

            let bgConfig = UIBackgroundConfiguration.clear()
            cell.backgroundConfiguration = bgConfig
        }
        let dataSource = UICollectionViewDiffableDataSource<LXAccessoryOpt, LXAccessoryOpt>(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case .outline:
                return collectionView.dequeueConfiguredReusableCell(using: outlineRegistration, for: indexPath, item: item)
            case .subitems:
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            }
        }
        let headerRegistration = UICollectionView.SupplementaryRegistration<LXCollectionHeaderFooterView>(elementKind: LXAccessoryListVC.sectionHeaderElementKind) {[weak self] supplementaryView, elementKind, indexPath in
            guard let model = self?.dataSource.itemIdentifier(for: indexPath) else { return }
            supplementaryView.dataFill("\(model.section.title) - header")
        }
        let footerRegistration = UICollectionView.SupplementaryRegistration<LXCollectionHeaderFooterView>(elementKind: LXAccessoryListVC.sectionFooterElementKind) {[weak self] supplementaryView, elementKind, indexPath in
            guard let model = self?.dataSource.itemIdentifier(for: indexPath) else { return }
            supplementaryView.dataFill("\(model.section.title) - footer")
        }
        dataSource.supplementaryViewProvider = {[weak self] collectionView, elementKind, indexPath in
            dlog("-->elementKind: \(elementKind)")
            return self?.collectionView.dequeueConfiguredReusableSupplementary(using: elementKind == LXAccessoryListVC.sectionHeaderElementKind ? headerRegistration : footerRegistration, for: indexPath)
        }
        return dataSource
    }
    func generateSnapshot() -> NSDiffableDataSourceSnapshot<LXAccessoryOpt, LXAccessoryOpt> {
        let list = generateListAccessory()
        let dataList = list.map { LXAccessoryOpt.subitems(.section(title: $0.value.accessoryType.title), accessory: $0) }
        let section: LXAccessoryOpt = .outline(.main, accessory: .label(text: "label 233"), subitems: dataList)
        var snapshot = NSDiffableDataSourceSnapshot<LXAccessoryOpt, LXAccessoryOpt>()
        snapshot.appendSections([section])
        snapshot.appendItems(dataList, toSection: section)
        return snapshot
    }
    @available(iOS 16.0, *)
    func generateAllSnapshot() {
        let list = generateListAccessory()
        let dataList = list.map { accessoryItem in
            let subitems: [LXAccessoryOpt] = accessoryItem.value.accessoryType.list.map { .subitems(.section(title: $0.value.accessoryType.title), accessory: $0) }
            return LXAccessoryOpt.outline(.section(title: accessoryItem.value.accessoryType.title), accessory: accessoryItem, subitems: subitems)
        }
        var expandList: [LXAccessoryOpt: NSDiffableDataSourceSectionSnapshot<LXAccessoryOpt>] = [:]
        var snapshot = NSDiffableDataSourceSnapshot<LXAccessoryOpt, LXAccessoryOpt>()
        snapshot.appendSections(dataList)
        dataList.forEach { item in
            switch item {
            case .outline(let _, let accessory, let subitems):
                if case .customView = accessory.value.accessoryType {
                    // let customView: UICellAccessory = .customView(configuration: UICellAccessory.customViewConfiguration(reservedLayoutWidth: .standard))
                    // let tmp: [LXAccessoryOpt] = [
                    //     .subitems(.section(title: "X1"), accessory: .label(text: "X1")),
                    //     .subitems(.section(title: "X2"), accessory: .label(text: "X2")),
                    //     .subitems(.section(title: "X3"), accessory: .label(text: "X3")),
                    // ]
                    // let tmp = subitems
                    // let section: LXAccessoryOpt = .outline(.section(title: "XXX"), accessory: .label(text: "Label-XXX"), subitems: tmp)
                    // let section: LXAccessoryOpt = .outline(.section(title: "XXX"), accessory: customView, subitems: tmp)
                    // let section = item
                    // snapshot.appendSections([section])
                    snapshot.appendItems([item], toSection: item)
                    var snapshot2 = NSDiffableDataSourceSectionSnapshot<LXAccessoryOpt>()
                    snapshot2.append([item])
                    snapshot2.append(subitems, to: item)
                    dataSource.apply(snapshot2, to: item, animatingDifferences: true)
                    expandList[item] = snapshot2
                } else {
                    snapshot.appendItems([item], toSection: item)
                    var snapshot2 = NSDiffableDataSourceSectionSnapshot<LXAccessoryOpt>()
                    snapshot2.append([item])
                    snapshot2.append(subitems, to: item)
                    dataSource.apply(snapshot2, to: item, animatingDifferences: true)
                    // expandList[section] = snapshot2
                }
            case .subitems:
                snapshot.appendItems([item])
            }
        }
        dataSource.apply(snapshot, animatingDifferences: true )
        // for (key, value) in expandList {
        //     var tmp = value
        //     tmp.expand([key])
        //     dataSource.apply(tmp, to: key, animatingDifferences: true)
        // }
    }
    func generateMultiSnapshot() {
        func addItems(_ snapshot: inout NSDiffableDataSourceSectionSnapshot<LXAccessoryOpt>, menuItems: [LXAccessoryOpt], to parent: LXAccessoryOpt?) {
            for menuItem in menuItems {
                switch menuItem {
                case .outline(_, let accessory, let subitems):
                    if !snapshot.contains(menuItem) {
                        snapshot.append([menuItem], to: parent)
                    }
                    addItems(&snapshot, menuItems: subitems, to: menuItem)
                    // snapshot.append(subitems, to: parent)
                case .subitems:
                    snapshot.append([menuItem], to: parent)
                    break
                }
            }
        }
        let list = generateListAccessory()
        let dataList = list.map { accessoryItem in
            let subitems: [LXAccessoryOpt] = accessoryItem.value.accessoryType.list.map { .subitems(.section(title: $0.value.accessoryType.title), accessory: $0) }
            return LXAccessoryOpt.outline(.section(title: accessoryItem.value.accessoryType.title), accessory: accessoryItem, subitems: subitems)
        }
        var snapshot = NSDiffableDataSourceSnapshot<LXAccessoryOpt, LXAccessoryOpt>()
        snapshot.appendSections(dataList)
        // snapshot.appendItems([DJTestRouter.routerDynamicIsland])
        var expandList: [LXAccessoryOpt: NSDiffableDataSourceSectionSnapshot<LXAccessoryOpt>] = [:]
        for item in dataList {
            switch item {
            case .outline(_, _, let subitems):
                snapshot.appendItems([item], toSection: item)

                var snapshot2 = NSDiffableDataSourceSectionSnapshot<LXAccessoryOpt>()
                snapshot2.append([item])
                // snapshot2.append(subitems, to: item)
                addItems(&snapshot2, menuItems: subitems, to: item)
                dataSource.apply(snapshot2, to: item, animatingDifferences: true)
                // expandList[section] = snapshot2
            case .subitems:
                snapshot.appendItems([item])
                break
            }
        }
        dataSource.apply(snapshot, animatingDifferences: true)
        // for (key, value) in expandList {
        //     var tmp = value
        //     tmp.expand([key])
        //     dataSource.apply(tmp, to: key, animatingDifferences: true)
        // }
    }
    func refreshCollection() {
        // collectionView.reloadData()
        if #available(iOS 17.0, *) {
            // generateAllSnapshot()
            generateMultiSnapshot()
        }
    }
    @available(iOS 16.0, *)
    func generateRightNavItem() -> [UIBarButtonItem] {
        let displayedStateMenu = UIMenu(title: "displayedState", options: .singleSelection, children: [
            UIAction(title: ".always", state: displayedState == .always ? .on : .off, handler: {[weak self] _ in
                self?.displayedState = .always
                self?.refreshCollection()
            }),
            UIAction(title: ".whenEditing", state: displayedState == .whenEditing ? .on : .off, handler: {[weak self] _ in
                self?.displayedState = .whenEditing
                self?.refreshCollection()
            }),
            UIAction(title: ".whenNotEditing", state: displayedState == .whenNotEditing ? .on : .off, handler: {[weak self] _ in
                self?.displayedState = .whenNotEditing
                self?.refreshCollection()
            }),
        ])
        let reservedLayoutWidthMenu = UIMenu(title: "reservedLayoutWidth", options: .singleSelection, children: [
            UIAction(title: ".actual", state: reservedLayoutWidth == .actual ? .on : .off, handler: {[weak self] _ in
                self?.reservedLayoutWidth = .actual
                self?.refreshCollection()
            }),
            UIAction(title: ".standard", state: reservedLayoutWidth == .standard ? .on : .off, handler: {[weak self] _ in
                self?.reservedLayoutWidth = .standard
                self?.refreshCollection()
            }),
            UIAction(title: ".custom(64)", state: reservedLayoutWidth == .xl_custom_64 ? .on : .off, handler: {[weak self] _ in
                self?.reservedLayoutWidth = .xl_custom_64
                self?.refreshCollection()
            }),
        ])
        let outlineDisclosuretyleMenu = UIMenu(title: "outlineDisclosuretyle", options: .singleSelection, children: [
            UIAction(title: ".automatic", state: outlineDisclosuretyle == .automatic ? .on : .off, handler: {[weak self] _ in
                self?.outlineDisclosuretyle = .automatic
                self?.refreshCollection()
            }),
            UIAction(title: ".header", state: outlineDisclosuretyle == .header ? .on : .off, handler: {[weak self] _ in
                self?.outlineDisclosuretyle = .header
                self?.refreshCollection()
            }),
            UIAction(title: ".cell", state: outlineDisclosuretyle == .cell ? .on : .off, handler: {[weak self] _ in
                self?.outlineDisclosuretyle = .cell
                self?.refreshCollection()
            }),
        ])
        let isHiddenMenu = UIMenu(title: "isHidden", options: .singleSelection, children: [
            UIAction(title: "isHidden", subtitle: "\(isHidden)", handler: {[weak self] _ in
                guard let self else { return }
                self.isHidden = !self.isHidden
                self.refreshCollection()
            }),
            UIAction(title: "showsVerticalSeparator", subtitle: "\(showsVerticalSeparator)", handler: {[weak self] _ in
                guard let self else { return }
                self.showsVerticalSeparator = !self.showsVerticalSeparator
                self.refreshCollection()
            }),
        ])
        let colorMenu = UIMenu(title: "color", options: .singleSelection, children: [
            UIAction(title: "tintColor", subtitle: "\(tintColor.xl.hexString)", handler: {[weak self] _ in
                self?.tintColor = .random
                self?.refreshCollection()
            }),
            UIAction(title: "backgroundColor", subtitle: "\(backgroundColor.xl.hexString)", handler: {[weak self] _ in
                self?.backgroundColor = .random
                self?.refreshCollection()
            }),
        ])
        return [
            UIBarButtonItem(title: "state", menu: displayedStateMenu),
            UIBarButtonItem(title: "width", menu: reservedLayoutWidthMenu),
            UIBarButtonItem(title: "style", menu: outlineDisclosuretyleMenu),
            UIBarButtonItem(title: "isHidden", menu: isHiddenMenu),
            UIBarButtonItem(title: "color", menu: colorMenu),
        ]
    }
}

// MARK: - 👀
@available(iOS 16.0, *)
extension LXAccessoryListVC: UICollectionViewDelegate {
    // func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    //     guard let item = dataSource.itemIdentifier(for: indexPath) else { return true }
    //     dlog("-->\(item.accessory.accessoryType)")
    //     return true
    // }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        guard .multiselect != item.accessory.value.accessoryType else {
            let msg = "\(item)"
            dlog(msg)
            makeToast(msg)
            return
        }
        let scene: Navigator.Scene = .vc(provider: {
            let vc = LXUnSupportedVC(msg: "item: \(item)")
            vc.title = "\(item.accessory.value.accessoryType)"
            vc.subtitle = "accessory: \(item.accessory)"
            return vc
        })
        Navigator.default.show(segue: scene, sender: self)
    }
}

// MARK: - 🍺UI Prepare & Masonry
@available(iOS 16.0, *)
extension LXAccessoryListVC {
    func prepareCollectionView() {
        if #available(iOS 14, *) {
            collectionView = generateCollectionView()
            dataSource = generateDataSource()
            if #available(iOS 17.0, *) {
                // generateAllSnapshot()
                generateMultiSnapshot()
            } else {
                // Fallback on earlier versions
                let snapshot = generateSnapshot()
                dataSource.apply(snapshot, animatingDifferences: true)
            }
        } else {
            // Fallback on earlier versions
            let layout = UICollectionViewFlowLayout()
            collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        }
    }
    override func prepareUI() {
        super.prepareUI()
        self.view.backgroundColor = .white
        // navigationItem.title = ""
        if #available(iOS 15.0, *) {
            navigationItem.rightBarButtonItems = generateRightNavItem()
        }

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
