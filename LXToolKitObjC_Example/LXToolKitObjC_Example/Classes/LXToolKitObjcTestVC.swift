//
//  LXToolKitObjcTestVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/4/11.
//
import UIKit
import LXToolKit
import DJTestKit

class DataSource: UITableViewDiffableDataSource<String, LXOutlineOpt> {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.snapshot().sectionIdentifiers[section];
    }
}

open class LXToolKitObjcTestVC: LXBaseTableVC {
    // MARK: 📌UI
    private var dataSource: DataSource!
    @available(iOS 13.0, *)
    private var dataSnapshot: NSDiffableDataSourceSnapshot<String, LXOutlineOpt>!
    // MARK: 🔗Vaiables
    public var autoJumpRoute: LXOutlineOpt?
    // MARK: 🛠Life Cycle
    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
        prepareTableView()

        gotoScene(by: autoJumpRoute)
    }
}

// MARK: 🌎LoadData
extension LXToolKitObjcTestVC {}

// MARK: 👀Public Actions
extension LXToolKitObjcTestVC {}

// MARK: 🔐Private Actions
@available(iOS 14.0, *)
private extension LXToolKitObjcTestVC {
    func generateDataSource() -> DataSource {
        let dataSource = DataSource.init(tableView: table) { tableView, indexPath, scene in
            let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.xl.xl_identifier, for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.text = scene.title
            // content.secondaryText = "\(scene.info.desc)"
            cell.contentConfiguration = content
            return cell
        }
        dataSource.defaultRowAnimation = .fade
        return dataSource
    }
    func generateSnapshot() -> NSDiffableDataSourceSnapshot<String, LXOutlineOpt> {
        var snapshot = NSDiffableDataSourceSnapshot<String, LXOutlineOpt>()
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
private extension LXToolKitObjcTestVC {
    func gotoScene(by outlineOpt: LXOutlineOpt?) {
        let navigator = Navigator.default
        if let scene = outlineOpt?.scene,
           let vc = navigator.show(segue: scene, sender: self) {
            DJTestType.LXToolKitObjC_Example.updateDefaults(vcName: vc.xl.xl_typeName)
        }
    }
}

// MARK: - ✈️UITableViewDataSource
// extension LXToolKitObjcTestVC: UITableViewDataSource {
//     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//         return dataList.count
//     }
//     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//         let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.xl.xl_identifier, for: indexPath)
//         let info = dataList[indexPath.row].info
//         if #available(iOS 14.0, *) {
//             var config = UIListContentConfiguration.cell()
//             config.text = info.title
//             config.secondaryText = info.desc
//             cell.contentConfiguration = config
//         } else {
//             cell.textLabel?.text = info.title
//             cell.detailTextLabel?.text = info.desc
//         }
//         return cell
//     }
// }
// MARK: - ✈️UITableViewDelegate
extension LXToolKitObjcTestVC: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if #available(iOS 13.0, *) {
            let tmp = dataSnapshot.sectionIdentifiers[section]
            return tmp
        } else {
            // Fallback on earlier versions
            return ""
        }
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

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
extension LXToolKitObjcTestVC {
    public override func prepareTableView() {
        super.prepareTableView()
        table.delegate = self
        if #available(iOS 14.0, *) {
            dataSource = generateDataSource()
            dataSnapshot = generateSnapshot()
            DispatchQueue.main.async {
                self.dataSource.apply(self.dataSnapshot, animatingDifferences: true)
            }
        } else {
            // Fallback on earlier versions
            // table.dataSource = self
        }
    }
    open override func prepareUI() {
        super.prepareUI()
        self.view.backgroundColor = .white
        // self.title = "<#title#>"

        [table].forEach(self.view.addSubview)

        masonry()
    }

    open override func masonry() {
        super.masonry()
        table.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

#Preview("LXToolKitObjcTestVC") {
    LXToolKitObjcTestVC()
}
