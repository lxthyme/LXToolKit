//
//  LXCollectionVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/11/9.
//
import UIKit

// MARK: - 👀
extension LXCollectionVC {
    enum SectionLayoutKind: Int, CaseIterable {
    case list, grid5, grid3, group, groupOne, orthogonal
        var columnCount: Int {
            switch self {
            case .list: return 1
            case .grid5: return 5
            case .grid3: return 3
            case .group: return 1
            case .groupOne: return 1
            case .orthogonal: return 1
            }
        }
        var name: String {
            switch self {
            case .list: return "list"
            case .grid5: return "grid5"
            case .grid3: return "grid3"
            case .group: return "group"
            case .groupOne: return "groupOne"
            case .orthogonal: return "orthogonal"
            }
        }
    }
}

// MARK: - 🔐
private extension LXCollectionVC {
    enum OperationPosition {
        case first, last
    }
    enum OperationType {
        case insert(kind: SectionLayoutKind, position: OperationPosition, data: LXTestModel? = nil)
        case remove(kind: SectionLayoutKind, position: OperationPosition)
        case orthogonal(_ orthogonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior)
    }
}

// MARK: - 👀
extension LXCollectionVC {
    struct LXTestModel: Hashable {
        var id = UUID()
        var kind: SectionLayoutKind
        var idx: Float
        var title: String {
            return "\(kind.name)-\(idx)"
        }
    }
}

class LXCollectionVC: UIViewController {
    // MARK: 📌UI
    private lazy var collectionView: UICollectionView = {
        let v: UICollectionView
        if #available(iOS 14.0, *) {
            v = UICollectionView(frame: .zero, collectionViewLayout: prepareLayout())
        } else {
            // Fallback on earlier versions
            v = UICollectionView(frame: .zero)
        }
        v.backgroundColor = .white
        v.showsHorizontalScrollIndicator = false
        v.showsVerticalScrollIndicator = false
        v.alwaysBounceVertical = false
        v.alwaysBounceHorizontal = false
        // v.allowsMultipleSelection = true
        // v.isPagingEnabled = true

        // v.delegate = self
        // v.dataSource = self
        // v.prefetchDataSource = self
        // v.dragDelegate = self
        // v.dropDelegate = self
        // v.isPrefetchingEnabled = true

        //let header =  VPLoadingHeader.init(refreshingBlock: {
        //    [weak self] in
        //    guard let `self` = self else { return }
        //    //self.loadData(true)
        //})
        //v.mj_header = header
        //let footer = VPAutoLoadingFooter.init(refreshingBlock: {
        //    [weak self] in
        //    guard let `self` = self else { return }
        //    //self.loadData(false)
        //})
        //v.mj_footer = footer

        v.register(LXCollectionCell.self, forCellWithReuseIdentifier: LXCollectionCell.xl.xl_identifier)
        v.register(LXCollectionHeaderFooterView.self, forSupplementaryViewOfKind: LXCollectionVC.sectionHeaderElementKind, withReuseIdentifier: LXCollectionHeaderFooterView.xl.xl_identifier)
        v.register(LXCollectionHeaderFooterView.self, forSupplementaryViewOfKind: LXCollectionVC.sectionFooterElementKind, withReuseIdentifier: LXCollectionHeaderFooterView.xl.xl_identifier)
        return v
    }()
    // MARK: 🔗Vaiables
    private static let sectionBackgroundDecorationElementKind = "sectionBackgroundDecorationElementKind"
    private static let sectionHeaderElementKind = "sectionHeaderElementKind"
    private static let sectionFooterElementKind = "sectionFooterElementKind"
    private lazy var dataList: [LXTestModel] = {
        return Array(0..<10).map { LXTestModel(kind: .list, idx: Float($0)) }
    }()
    private var dataGrid3List: [LXTestModel] = {
        return Array(0..<30).map { LXTestModel(kind: .grid3, idx: Float($0)) }
    }()
    private var dataGrid5List: [LXTestModel] = {
        return Array(0..<20).map { LXTestModel(kind: .grid5, idx: Float($0)) }
    }()
    private var dataGroupList: [LXTestModel] = {
        return Array(0..<20).map { LXTestModel(kind: .group, idx: Float($0)) }
    }()
    private var dataGroupOneList: [LXTestModel] = {
        return Array(0..<2).map { LXTestModel(kind: .groupOne, idx: Float($0)) }
    }()
    private var dataOrthogonalList: [LXTestModel] = {
        return Array(0..<20).map { LXTestModel(kind: .orthogonal, idx: Float($0)) }
    }()
    private var orthogonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior = .continuous
    private var dataSource: UICollectionViewDiffableDataSource<SectionLayoutKind, LXTestModel>?
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
        if #available(iOS 14.0, *) {
            prepareCollectionDataSource()
        }
        prepareCollection()
    }

}

// MARK: 🌎LoadData
extension LXCollectionVC {}

// MARK: 👀Public Actions
extension LXCollectionVC {}

// MARK: 🔐Private Actions
@available(iOS 14.0, *)
private extension LXCollectionVC {
    func prepareLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIdx: Int, layoutEnv: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionKind = SectionLayoutKind(rawValue: sectionIdx) else { return nil }
            switch sectionKind {
            case .group, .groupOne, .orthogonal:
                let bgNestedGroupDecoration = NSCollectionLayoutDecorationItem.background(elementKind: LXCollectionVC.sectionBackgroundDecorationElementKind)
                bgNestedGroupDecoration.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)

                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                        heightDimension: .estimated(44.0))
                let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                        heightDimension: .estimated(44.0))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                                elementKind: LXCollectionVC.sectionHeaderElementKind,
                                                                                alignment: .top)
                let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize,
                                                                                elementKind: LXCollectionVC.sectionFooterElementKind,
                                                                                alignment: .bottom)


                let leadingItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                                             heightDimension: .fractionalHeight(1))
                let leadingItem = NSCollectionLayoutItem(layoutSize: leadingItemSize)
                // leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)
                let trailingItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                              heightDimension: .fractionalHeight(0.3))
                let trailingItem = NSCollectionLayoutItem(layoutSize: trailingItemSize)
                // trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)
                let trailingGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                                               heightDimension: .fractionalHeight(1))
                let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: trailingGroupSize,
                                                                     subitem: trailingItem,
                                                                     count: 2)
                trailingGroup.interItemSpacing = .fixed(10)
                // trailingGroup.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                // <#group#>.contentInsets = NSDirectionalEdgeInsets(top: <#10.0#>, leading: <#10.0#>, bottom: <#10.0#>, trailing: <#10.0#>)
                let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                             heightDimension: .fractionalHeight(0.4))
                let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: nestedGroupSize,
                                                                     subitems: [leadingItem, trailingGroup])
                // nestedGroup.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)
                nestedGroup.interItemSpacing = .fixed(10)
                // nestedGroup.edgeSpacing
                let section = NSCollectionLayoutSection(group: nestedGroup)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
                section.interGroupSpacing = 10
                /// section 背景
                section.decorationItems = [bgNestedGroupDecoration]
                /// section header/footer
                sectionHeader.pinToVisibleBounds = true
                sectionHeader.zIndex = 2
                section.boundarySupplementaryItems = [sectionHeader, sectionFooter]
                if(sectionKind == .orthogonal || sectionKind == .groupOne) {
                    bgNestedGroupDecoration.zIndex = 99
                    section.orthogonalScrollingBehavior = self.orthogonalScrollingBehavior
                    // section.orthogonalScrollingProperties = .DecelerationRate
                }
                return section
            case .list, .grid5, .grid3:
                let columns = sectionKind.columnCount

                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

                let groupHeight: NSCollectionLayoutDimension = columns == 1 ? .absolute(44) : .fractionalWidth(0.2)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: groupHeight)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitem: item,
                                                               count: columns)
                // group.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)

                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)

                return section
            }
        }
        layout.register(LXBGNestedGroupDecorationView.self, forDecorationViewOfKind: LXCollectionVC.sectionBackgroundDecorationElementKind)
        return layout
    }
    func prepareCollectionDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<LXCollectionCell, LXTestModel> { cell, indexPath, item in
            // cell.labTitle.text = "\(item)"
            // cell.contentView.backgroundColor = .cornflowerBlue
            // cell.layer.borderColor = UIColor.black.cgColor
            // cell.layer.borderWidth = 1.0
            // cell.labTitle.textAlignment = .center
            // cell.labTitle.font = .preferredFont(forTextStyle: .title1)
            cell.dataFill(item.title)
        }
        let headerRegistration = UICollectionView.SupplementaryRegistration<LXCollectionHeaderFooterView>(elementKind: LXCollectionVC.sectionHeaderElementKind) { supplementaryView, elementKind, indexPath in
            guard let model = self.dataSource?.itemIdentifier(for: indexPath) else { return }
            // supplementaryView.labTitle.text = "\(model.badgeCount)"
            supplementaryView.dataFill("\(model.title) - header")
        }
        let footerRegistration = UICollectionView.SupplementaryRegistration<LXCollectionHeaderFooterView>(elementKind: LXCollectionVC.sectionFooterElementKind) { supplementaryView, elementKind, indexPath in
            guard let model = self.dataSource?.itemIdentifier(for: indexPath) else { return }
            // supplementaryView.labTitle.text = "\(model.badgeCount)"
            supplementaryView.dataFill("\(model.title) - footer")
        }
        dataSource = UICollectionViewDiffableDataSource<SectionLayoutKind, LXTestModel>(collectionView: collectionView) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        dataSource?.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: elementKind == LXCollectionVC.sectionHeaderElementKind ? headerRegistration : footerRegistration, for: indexPath)
        }
    }
    func prepareRightMenu() {
        let orthogonalSubmenu: [UIAction] = [
            UIAction(title: "continuous", state: self.orthogonalScrollingBehavior == .continuous ? .on : .off, handler: {[weak self] _ in
                guard let self else { return }
                self.operation(with: .orthogonal(.continuous))
            }),
            UIAction(title: "continuousGroupLeadingBoundary", state: self.orthogonalScrollingBehavior == .continuousGroupLeadingBoundary ? .on : .off, handler: {[weak self] _ in
                guard let self else { return }
                self.operation(with: .orthogonal(.continuousGroupLeadingBoundary))
            }),
            UIAction(title: "paging", state: self.orthogonalScrollingBehavior == .paging ? .on : .off, handler: {[weak self] _ in
                guard let self else { return }
                self.operation(with: .orthogonal(.paging))
            }),
            UIAction(title: "groupPaging", state: self.orthogonalScrollingBehavior == .groupPaging ? .on : .off, handler: {[weak self] _ in
                guard let self else { return }
                self.operation(with: .orthogonal(.groupPaging))
            }),
            UIAction(title: "groupPagingCentered", state: self.orthogonalScrollingBehavior == .groupPagingCentered ? .on : .off, handler: {[weak self] _ in
                guard let self else { return }
                self.operation(with: .orthogonal(.groupPagingCentered))
            }),
            UIAction(title: "none", state: self.orthogonalScrollingBehavior == .none ? .on : .off, handler: {[weak self] _ in
                guard let self else { return }
                self.operation(with: .orthogonal(.none))
            }),
        ]
        let orthogonalMenu: UIMenu
        if #available(iOS 15.0, *) {
            orthogonalMenu = UIMenu(title: "orthogonal", options: .singleSelection, children: orthogonalSubmenu)
        } else {
            // Fallback on earlier versions
            orthogonalMenu = UIMenu(title: "orthogonal", children: orthogonalSubmenu)
        }
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "list", menu: UIMenu(children: [
                UIAction(title: "insert first", handler: {[weak self] _ in
                    guard let self else { return }
                    self.operation(with: .insert(kind: .list, position: .first))
                }),
                UIAction(title: "insert last", handler: {[weak self] _ in
                    guard let self else { return }
                    self.operation(with: .insert(kind: .list, position: .last))
                }),
                UIAction(title: "remove first", handler: {[weak self] _ in
                    guard let self else { return }
                    self.operation(with: .remove(kind: .list, position: .first))
                }),
                UIAction(title: "remove last", handler: {[weak self] _ in
                    guard let self else { return }
                    self.operation(with: .remove(kind: .list, position: .last))
                }),
            ])),
            UIBarButtonItem(title: "grid3", menu: UIMenu(children: [
                UIAction(title: "insert first", handler: {[weak self] _ in
                    guard let self else { return }
                    self.operation(with: .insert(kind: .grid3, position: .first))
                }),
                UIAction(title: "insert last", handler: {[weak self] _ in
                    guard let self else { return }
                    self.operation(with: .insert(kind: .grid3, position: .last))
                }),
                UIAction(title: "remove first", handler: {[weak self] _ in
                    guard let self else { return }
                    self.operation(with: .remove(kind: .grid3, position: .first))
                }),
                UIAction(title: "remove last", handler: {[weak self] _ in
                    guard let self else { return }
                    self.operation(with: .remove(kind: .grid3, position: .last))
                }),
            ])),
            UIBarButtonItem(title: "grid5", menu: UIMenu(children: [
                UIAction(title: "insert first", handler: {[weak self] _ in
                    guard let self else { return }
                    self.operation(with: .insert(kind: .grid5, position: .first))
                }),
                UIAction(title: "insert last", handler: {[weak self] _ in
                    guard let self else { return }
                    self.operation(with: .insert(kind: .grid5, position: .last))
                }),
                UIAction(title: "remove first", handler: {[weak self] _ in
                    guard let self else { return }
                    self.operation(with: .remove(kind: .grid5, position: .first))
                }),
                UIAction(title: "remove last", handler: {[weak self] _ in
                    guard let self else { return }
                    self.operation(with: .remove(kind: .grid5, position: .last))
                }),
            ])),
            UIBarButtonItem(title: "group", menu: UIMenu(children: [
                UIAction(title: "insert first", handler: {[weak self] _ in
                    guard let self else { return }
                    self.operation(with: .insert(kind: .group, position: .first))
                }),
                UIAction(title: "insert last", handler: {[weak self] _ in
                    guard let self else { return }
                    self.operation(with: .insert(kind: .group, position: .last))
                }),
                UIAction(title: "remove first", handler: {[weak self] _ in
                    guard let self else { return }
                    self.operation(with: .remove(kind: .group, position: .first))
                }),
                UIAction(title: "remove last", handler: {[weak self] _ in
                    guard let self else { return }
                    self.operation(with: .remove(kind: .group, position: .last))
                }),
            ])),
            UIBarButtonItem(title: "orthogonal", menu: UIMenu(children: [orthogonalMenu])),
        ]
    }
}

// MARK: - 🔐
private extension LXCollectionVC {
    func getList(from kind: SectionLayoutKind) -> [LXTestModel] {
        var list: [LXTestModel]
        switch kind {
        case .list: list = self.dataList
        case .grid5: list = self.dataGrid5List
        case .grid3: list = self.dataGrid3List
        case .group: list = self.dataGroupList
        case .groupOne: list = self.dataGroupOneList
        case .orthogonal: list = self.dataOrthogonalList
        }
        return list
    }
    func updateList(with kind: SectionLayoutKind, list: [LXTestModel]) {
        switch kind {
        case .list: self.dataList = list
        case .grid5: self.dataGrid5List = list
        case .grid3: self.dataGrid3List = list
        case .group: self.dataGroupList = list
        case .groupOne: self.dataGroupOneList = list
        case .orthogonal: self.dataOrthogonalList = list
        }
    }
    func operation(with operation: OperationType) {
        switch operation {
        case .insert(let kind, let position, let data):
            var list = getList(from: kind)
            switch position {
            case .first:
                if let data {
                    list.insert(data, at: 0)
                } else if let item = list.first {
                    let idx = item.idx + 0.1
                    let tmp = LXCollectionVC.LXTestModel(kind: kind, idx: idx)
                    list.insert(tmp, at: 0)
                }
            case .last:
                if let data {
                    list.append(data)
                } else if let item = list.last {
                    let idx = item.idx + 0.1
                    let tmp = LXCollectionVC.LXTestModel(kind: kind, idx: idx)
                    list.append(tmp)
                }
            }
            updateList(with: kind, list: list)
        case .remove(let kind, let position):
            var list = getList(from: kind)
            switch position {
            case .first:
                list.removeFirst()
            case .last:
                list.removeLast()
            }
            updateList(with: kind, list: list)
        case .orthogonal(let orthogonalScrollingBehavior):
            self.orthogonalScrollingBehavior = orthogonalScrollingBehavior
        }
        self.prepareCollection()
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXCollectionVC {
    func prepareCollection() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionLayoutKind, LXTestModel>()
        let itemsPerSection = 10
        SectionLayoutKind.allCases.forEach {[weak self] kind in
            guard let self else { return }
            snapshot.appendSections([kind])
            let list = self.getList(from: kind)
            if #available(iOS 14.0, *),
               kind == .orthogonal {
                collectionView.setCollectionViewLayout(prepareLayout(), animated: true)
            }
            snapshot.appendItems(list, toSection: kind)
        }
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    func prepareUI() {
        self.view.backgroundColor = .white
        navigationItem.title = ""
        if #available(iOS 14.0, *) {
            prepareRightMenu()
        }

        [collectionView].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
