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
    case list, grid5, grid3
        var columnCount: Int {
            switch self {
            case .list: return 1
            case .grid5: return 5
            case .grid3: return 3
            }
        }
        var name: String {
            switch self {
            case .list: return "list"
            case .grid5: return "grid5"
            case .grid3: return "grid3"
            }
        }
    }
}
// MARK: - 👀
extension LXCollectionVC {
    struct LXTestModel: Hashable {
        var id = UUID()
        var kind: SectionLayoutKind
        var idx: Float
        var title: String {
            switch kind {
            case .list: return "list-\(idx)"
            case .grid5: return "grid5-\(idx)"
            case .grid3: return "grid3-\(idx)"
            }
        }
    }
}

class LXCollectionVC: UIViewController {
    // MARK: 📌UI
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        // layout.itemSize = CGSize(width: <#120#>, height: <#120#>)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .zero
        layout.headerReferenceSize = .zero
        layout.footerReferenceSize = .zero

        layout.scrollDirection = .vertical
        layout.sectionHeadersPinToVisibleBounds = true
        layout.sectionFootersPinToVisibleBounds = true
        if #available(iOS 11.0, *) {
            layout.sectionInsetReference = .fromContentInset
        }
        return layout
    }()
    // private lazy var layout: UICollectionViewLayout = {
    //     let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
    //                                           heightDimension: .absolute(44))
    //     let item = NSCollectionLayoutItem(layoutSize: itemSize)
    //     // item.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0)
    // 
    //     let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
    //                                            heightDimension: .absolute(44))
    //     let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
    //                                                    subitems: [item])
    // 
    //     let section = NSCollectionLayoutSection(group: group)
    //     let layout = UICollectionViewCompositionalLayout(section: section)
    //     return layout
    // }()
    private lazy var layout: UICollectionViewLayout = {
        return UICollectionViewCompositionalLayout { (sectionIdx: Int, layoutEnv: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionKind = SectionLayoutKind(rawValue: sectionIdx) else { return nil }
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
            // group.contentInsets = NSDirectionalEdgeInsets(top: <#10.0#>, leading: <#10.0#>, bottom: <#10.0#>, trailing: <#10.0#>)

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)

            return section
        }
    }()
    private lazy var collectionView: UICollectionView = {
        let v = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
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
        return v
    }()
    // MARK: 🔗Vaiables
    private lazy var dataList: [LXTestModel] = {
        return Array(0..<10)
            .map { LXTestModel(kind: .list, idx: Float($0)) }
    }()
    private var dataGrid3List: [LXTestModel] = {
        return Array(0..<30).map { LXTestModel(kind: .grid3, idx: Float($0)) }
    }()
    private var dataGrid5List: [LXTestModel] = {
        return Array(0..<20).map { LXTestModel(kind: .grid5, idx: Float($0)) }
    }()
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
        dataSource = UICollectionViewDiffableDataSource<SectionLayoutKind, LXTestModel>(collectionView: collectionView) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
    }
    func prepareRightMenu() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "list", menu: UIMenu(children: [
                UIAction(title: "insert first", handler: {[weak self] _ in
                    guard let self else { return }
                    self.operation(to: .list, position: .first, operation: .insert)
                }),
                UIAction(title: "insert last", handler: {[weak self] _ in
                    guard let self else { return }
                    self.operation(to: .list, position: .last, operation: .insert)
                }),
                UIAction(title: "remove first", handler: {[weak self] _ in
                    guard let self else { return }
                    self.operation(to: .list, position: .first, operation: .remove)
                }),
                UIAction(title: "remove last", handler: {[weak self] _ in
                    guard let self else { return }
                    self.operation(to: .list, position: .last, operation: .remove)
                }),
            ])),
            UIBarButtonItem(title: "grid3", menu: UIMenu(children: [
                UIAction(title: "insert first", handler: {[weak self] _ in
                    guard let self else { return }
                    self.operation(to: .grid3, position: .first, operation: .insert)
                }),
                UIAction(title: "insert last", handler: {[weak self] _ in
                    guard let self else { return }
                    self.operation(to: .grid3, position: .last, operation: .insert)
                }),
                UIAction(title: "remove first", handler: {[weak self] _ in
                    guard let self else { return }
                    self.operation(to: .grid3, position: .first, operation: .remove)
                }),
                UIAction(title: "remove last", handler: {[weak self] _ in
                    guard let self else { return }
                    self.operation(to: .grid3, position: .last, operation: .remove)
                }),
            ])),
            UIBarButtonItem(title: "grid5", menu: UIMenu(children: [
                UIAction(title: "insert first", handler: {[weak self] _ in
                    guard let self else { return }
                    self.operation(to: .grid5, position: .first, operation: .insert)
                }),
                UIAction(title: "insert last", handler: {[weak self] _ in
                    guard let self else { return }
                    self.operation(to: .grid5, position: .last, operation: .insert)
                }),
                UIAction(title: "remove first", handler: {[weak self] _ in
                    guard let self else { return }
                    self.operation(to: .grid5, position: .first, operation: .remove)
                }),
                UIAction(title: "remove last", handler: {[weak self] _ in
                    guard let self else { return }
                    self.operation(to: .grid5, position: .last, operation: .remove)
                }),
            ])),
        ]
    }
}

// MARK: - 🔐
private extension LXCollectionVC {
    enum OperationPosition {
        case first, last
    }
    enum OperationType {
        case insert, remove
    }
    func operation(to kind: SectionLayoutKind, position: OperationPosition, operation: OperationType) {
        var list: [LXTestModel]
        switch kind {
        case .list:
            list = self.dataList
        case .grid5:
            list = self.dataGrid5List
        case .grid3:
            list = self.dataGrid3List
        }
        switch operation {
        case .insert:
            switch position {
            case .first:
                if let item = list.first {
                    let idx = item.idx + 0.1
                    let tmp = LXTestModel(kind: kind, idx: idx)
                    list.insert(tmp, at: 0)
                }
            case .last:
                if let item = list.last {
                    let idx = item.idx + 0.1
                    let tmp = LXTestModel(kind: kind, idx: idx)
                    list.append(tmp)
                }
            }
        case .remove:
            switch position {
            case .first: list.removeFirst()
            case .last: list.removeLast()
            }
        }
        switch kind {
        case .list:
            self.dataList = list
        case .grid5:
            self.dataGrid5List = list
        case .grid3:
            self.dataGrid3List = list
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
            let list: [LXTestModel];
            switch kind {
            case .list:
                list = self.dataList
            case .grid3:
                list = self.dataGrid3List
            case .grid5:
                list = self.dataGrid5List
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
