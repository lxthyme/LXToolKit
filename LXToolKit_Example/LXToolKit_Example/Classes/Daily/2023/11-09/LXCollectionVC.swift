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
        v.isPagingEnabled = true

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
    private var dataList = Array(0..<10)
    private var dataGrid3List = Array(0..<10)
    private var dataGrid5List = Array(0..<10)
    private var dataSource: UICollectionViewDiffableDataSource<SectionLayoutKind, String>?
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
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
        let cellRegistration = UICollectionView.CellRegistration<LXCollectionCell, String> { cell, indexPath, item in
            // cell.labTitle.text = "\(item)"
            // cell.contentView.backgroundColor = .cornflowerBlue
            // cell.layer.borderColor = UIColor.black.cgColor
            // cell.layer.borderWidth = 1.0
            // cell.labTitle.textAlignment = .center
            // cell.labTitle.font = .preferredFont(forTextStyle: .title1)
            cell.dataFill("Row: \(item)")
        }
        dataSource = UICollectionViewDiffableDataSource<SectionLayoutKind, String>(collectionView: collectionView) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXCollectionVC {
    func prepareCollection() {
        if #available(iOS 14.0, *) {
            prepareCollectionDataSource()
        }
        var snapshot = NSDiffableDataSourceSnapshot<SectionLayoutKind, String>()
        let itemsPerSection = 10
        SectionLayoutKind.allCases.forEach { kind in
            snapshot.appendSections([kind])
            let itemOffset = kind.rawValue * itemsPerSection
            let itemUpperbound = itemOffset + itemsPerSection
            let list = Array(itemOffset..<itemUpperbound).map { "\(kind.name)-\($0)" }
            snapshot.appendItems(list, toSection: kind)
        }
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    func prepareUI() {
        self.view.backgroundColor = .white
        navigationItem.title = ""

        [collectionView].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
