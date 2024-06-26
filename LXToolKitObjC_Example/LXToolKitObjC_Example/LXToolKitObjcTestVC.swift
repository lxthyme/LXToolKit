//
//  LXToolKitObjCTestSwiftVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/4/11.
//
import UIKit
import LXToolKit
import DJTestKit

class DataSource: UITableViewDiffableDataSource<String, LXOutlineItem> {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.snapshot().sectionIdentifiers[section];
    }
}

open class LXToolKitObjCTestSwiftVC: LXBaseVC {
    // MARK: 📌UI
    private static let sectionHeaderElementKind = "sectionHeaderElementKind"
    private static let sectionFooterElementKind = "sectionFooterElementKind"
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<String, LXOutlineItem>!
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareCollectionView()
        prepareUI()
    }
    open override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
    }
}

// MARK: 🌎LoadData
extension LXToolKitObjCTestSwiftVC {}

// MARK: 👀Public Actions
extension LXToolKitObjCTestSwiftVC {}

// MARK: 🔐Private Actions
@available(iOS 14.0, *)
private extension LXToolKitObjCTestSwiftVC {
    func generateLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .sidebar)
        config.headerMode = .supplementary
        // config.footerMode = <#.supplementary#>
        // config.backgroundColor = .white
        return  UICollectionViewCompositionalLayout.list(using: config)
    }
    func generateCollectionView() -> UICollectionView {
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: generateLayout())
        // cv.backgroundColor = <#.systemGroupedBackground#>
        cv.delegate = self
        return cv
    }
    func generateDataSource() -> UICollectionViewDiffableDataSource<String, LXOutlineItem> {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, LXOutlineItem> { cell, indexPath, opt in
            var config = cell.defaultContentConfiguration()
            config.text = opt.opt.section.title
            cell.contentConfiguration = config
        }
        // collectionView.register(<#LXBadgeSupplementaryView#>.self, forSupplementaryViewOfKind: <#ViewController.sectionFooterElementKind#>, withReuseIdentifier: <#LXBadgeSupplementaryView#>.xl.xl_identifier)
        let headerRegistration = UICollectionView.SupplementaryRegistration<LXCollectionHeaderFooterView>(elementKind: UICollectionView.elementKindSectionHeader) {[weak self] supplementaryView, elementKind, indexPath in
            // guard let model = self?.dataSource.itemIdentifier(for: indexPath) else { return }
            // supplementaryView.labTitle.text = "\(model.badgeCount)"
            supplementaryView.dataFill(elementKind)
        }
        let dataSource = UICollectionViewDiffableDataSource<String, LXOutlineItem>(collectionView: collectionView) { collectionView, indexPath, opt in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: opt)
        }
        dataSource.supplementaryViewProvider = {[weak self] collectionView, elementKind, indexPath in
            if(elementKind == UICollectionView.elementKindSectionHeader) {
                return self?.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
            }
            return nil
        }
        return dataSource
    }
    func generateSnapshot() -> NSDiffableDataSourceSnapshot<String, LXOutlineItem> {
        var snapshot = NSDiffableDataSourceSnapshot<String, LXOutlineItem>()
        snapshot.appendSections([
            "MVVM",
            "2023",
            "2022",
        ])
        snapshot.appendItems(LXToolKitObjcRouter.routerMVVM.subitems ?? [], toSection: "MVVM")
        snapshot.appendItems(LXToolKitObjcRouter.router2023.subitems ?? [], toSection: "2023")
        snapshot.appendItems(LXToolKitObjcRouter.router2022.subitems ?? [], toSection: "2022")
        return snapshot
    }
}

// MARK: - 🔐Private Actions
private extension LXToolKitObjCTestSwiftVC {
    func gotoScene(by outlineOpt: LXOutlineItem?) {
        let navigator = Navigator.default
        if let outlineOpt,
           let scene = outlineOpt.scene {
            let vc = navigator.show(segue: scene, sender: self)
            vc?.title = outlineOpt.opt.section.title
            DJAutoRouter.router2.updateRouter(section: outlineOpt.opt.section)
        }
    }
}

// MARK: - ✈️UICollectionViewDelegate
extension LXToolKitObjCTestSwiftVC: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        if #available(iOS 14.0, *) {
            let scene = dataSource.itemIdentifier(for: indexPath)
            gotoScene(by: scene)
        } else {
            // Fallback on earlier versions
            dlog("-->Error!")
        }
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXToolKitObjCTestSwiftVC {
    func prepareCollectionView() {
        if #available(iOS 14.0, *) {
            collectionView = generateCollectionView()
            dataSource = generateDataSource()
            let snapshot = generateSnapshot()
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    func prepareUI() {
        self.view.backgroundColor = .white
        // self.title = "<#title#>"

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
#Preview("LXToolKitObjCTestSwiftVC") {
    LXToolKitObjCTestSwiftVC()
}
