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
    case subitems(_ section: LXSection, accessory: UICellAccessoryEnum, scene: Navigator.Scene)

    var title: String {
        switch self {
        case .outline(let section, let accessory, let subitems):
            return section.title
        case .subitems(let section, let accessory, let scene):
            return "\(section): \(accessory)"
        }
    }
    var accessory: UICellAccessory {
        switch self {
        case .outline(_, let accessory, _):
            return accessory.value
        case .subitems(_, let accessory, _):
            return accessory.value
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
        case .subitems(let section, let accessory, let scene):
            hasher.combine("\(section)_\(accessory)_scene: \(scene)")
        }
    }
}

@available(iOS 16.0, *)
class LXAccessoryListVC: LXBaseVC {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    private var collectionView: UICollectionView!
    // @available(iOS 14.0, *)
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
private extension LXAccessoryListVC {}

// MARK: - 🔐
@available(iOS 16, *)
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
        lazy var labCustom: UILabel = {
            let label = UILabel()
            label.text = "Custom Label"
            label.font = .systemFont(ofSize: 14)
            label.textColor = .black
            // label.numberOfLines = 0
            label.lineBreakMode = .byTruncatingTail
            label.textAlignment = .center
            label.adjustsFontForContentSizeCategory = true
            return label
        }()
        let customViewConfiguration: UICellAccessory.CustomViewConfiguration = .init(
            customView: labCustom,
            placement: .leading(displayed: .always, at: {[weak self] accessories in
                let msg = "-->customViewConfiguration: \(accessories)"
                dlog(msg)
                self?.view.makeToast(msg)
                return 0
            }),
            isHidden: isHidden,
            reservedLayoutWidth: reservedLayoutWidth,
            tintColor: tintColor, 
            maintainsFixedSize: true
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
                self?.view.makeToast(msg)
            }),
            .insert(displayed: displayedState, options: insertOptions, actionHandler: {[weak self] in
                let msg = "-->insert"
                dlog(msg)
                self?.view.makeToast(msg)
            }),
            .reorder(displayed: displayedState, options: reorderOptions),
            .multiselect(displayed: displayedState, options: multiselectOptions),
            .outlineDisclosure(displayed: displayedState, options: outlineDisclosureOptions, actionHandler: {[weak self] in
                let msg = "-->outlineDisclosure"
                dlog(msg)
                self?.view.makeToast(msg)
            }),
            // .popUpMenu(menu, displayed: .always, options: popUpMenuOptions, selectedElementDidChangeHandler: { menu in
            //     dlog("-->popUpMenu: \(menu)")
            // }),
            .label(text: "label accessory", displayed: displayedState, options: labelOptions),
            .customView(configuration: customViewConfiguration),
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
                self?.view.makeToast(msg)
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
                        self?.view.makeToast(msg)
                    }),
                    UIAction(title: "Item 2", handler: {[weak self] _ in
                        let msg = "-->Item 2"
                        dlog(msg)
                        self?.view.makeToast(msg)
                    }),
                    UIAction(title: "Item 3", handler: {[weak self] _ in
                        let msg = "-->Item 3"
                        dlog(msg)
                        self?.view.makeToast(msg)
                    }),
                    UIAction(title: "Item 4", handler: {[weak self] _ in
                        let msg = "-->Item 4"
                        dlog(msg)
                        self?.view.makeToast(msg)
                    }),
                    UIAction(title: "Item 5", handler: {[weak self] _ in
                        let msg = "-->Item 5"
                        dlog(msg)
                        self?.view.makeToast(msg)
                    }),
                ]
            )
            let popUpMenuOptions: UICellAccessory.PopUpMenuOptions = .init(
                isHidden: isHidden,
                reservedLayoutWidth: reservedLayoutWidth,
                tintColor: tintColor
            )
            let item: UICellAccessoryEnum = .popUpMenu(menu, displayed: .always, options: popUpMenuOptions, selectedElementDidChangeHandler: {[weak self] menu in
                let msg = "-->popUpMenu: \(menu)"
                dlog(msg)
                self?.view.makeToast(msg)
            })
            list.append(item)
        }
        return list
    }
    func generateLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.headerMode = .firstItemInSection
        // config.footerMode = <#.supplementary#>
        // config.backgroundColor = .white
        return  UICollectionViewCompositionalLayout.list(using: config)
    }
    func generateCollectionView() -> UICollectionView {
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: generateLayout())
        // cv.backgroundColor = <#.systemGroupedBackground#>
        // cv.delegate = self
        return cv
    }
    func generateDataSource() -> UICollectionViewDiffableDataSource<LXAccessoryOpt, LXAccessoryOpt> {
        let outlineRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, LXAccessoryOpt> { cell, indexPath, item in
            var contentConfig = cell.defaultContentConfiguration()
            contentConfig.text = item.title
            cell.contentConfiguration = contentConfig

            let disclosureOpt = UICellAccessory.OutlineDisclosureOptions(style: .header)
            cell.accessories = [
                item.accessory,
                .outlineDisclosure(options: disclosureOpt)
                // .outlineDisclosure()
            ]

            let bgConfig = UIBackgroundConfiguration.clear()
            cell.backgroundConfiguration = bgConfig
        }
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, LXAccessoryOpt> { cell, indexPath, item in
            var contentConfig = cell.defaultContentConfiguration()
            contentConfig.text = item.title
            cell.contentConfiguration = contentConfig

            var tmp: [UICellAccessory] = [
                .disclosureIndicator()
            ]
            if !item.title.contains("disclosureIndicator") {
                tmp.append(item.accessory)
            }
            cell.accessories = tmp

            let bgConfig = UIBackgroundConfiguration.clear()
            cell.backgroundConfiguration = bgConfig
        }
        return UICollectionViewDiffableDataSource<LXAccessoryOpt, LXAccessoryOpt>(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case .outline:
                return collectionView.dequeueConfiguredReusableCell(using: outlineRegistration, for: indexPath, item: item)
            case .subitems:
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            }
        }
    }
    func generateSnapshot() -> NSDiffableDataSourceSnapshot<LXAccessoryOpt, LXAccessoryOpt> {
        let list = generateListAccessory()
        let dataList = list.map { LXAccessoryOpt.subitems(.section(title: $0.title), accessory: $0, scene: .vc(provider: { UIViewController() })) }
        let section: LXAccessoryOpt = .outline(.main, accessory: .label(text: "label 233"), subitems: dataList)
        var snapshot = NSDiffableDataSourceSnapshot<LXAccessoryOpt, LXAccessoryOpt>()
        snapshot.appendSections([section])
        snapshot.appendItems(dataList, toSection: section)
        return snapshot
    }
}

// MARK: - 👀
@available(iOS 16.0, *)
extension LXAccessoryListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        let msg = "\(item)"
        dlog(msg)
        self.view.makeToast(msg)
    }
}

// MARK: - 🍺UI Prepare & Masonry
@available(iOS 16.0, *)
extension LXAccessoryListVC {
    func prepareCollectionView() {
        if #available(iOS 14, *) {
            collectionView = generateCollectionView()
            dataSource = generateDataSource()
            let snapshot = generateSnapshot()
            dataSource.apply(snapshot, animatingDifferences: true)
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
