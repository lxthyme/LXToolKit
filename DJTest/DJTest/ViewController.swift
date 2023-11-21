//
//  ViewController.swift
//  DJTest
//
//  Created by lxthyme on 2023/9/19.
//

import UIKit
import SwiftUI
import LXToolKit_Example
import LXToolKitObjC_Example
import ActivityKit
import DJTestKit

extension DJTestType {
    var vc: UIViewController? {
        switch self {
            // case .LXToolKit:
            //     return LXToolKitTestVC()
        case .LXToolKit_Example:
            return LXToolKitTestVC()
            // case .LXToolKitObjC:
            //     return LXToolKitTestVC()
        case .LXToolKitObjC_Example:
            return LXToolKitObjCTestVC()
        case .DJSwiftModule:
            let window = UIApplication.xl.keyWindow
            Application.shared.presentInitialScreen(in: window)
        case .dynamicIsland:
            return if #available(iOS 16.2, *) {
                UIHostingController(rootView: EmojiRangersView())
            } else {
                // Fallback on earlier versions
                UIViewController()
            }
        case .djTest(_, let vc, _):
            return vc()
        }
        return nil
    }

}

class DataSource: UITableViewDiffableDataSource<String, DJTestType> {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.snapshot().sectionIdentifiers[section];
    }
}

class ViewController: LXBaseTableVC {
    // MARK: 📌UI
    private var _dataSource: UITableViewDataSource?
    @available(iOS 14.0, *)
    private var dataSource: DataSource {
        if let ds = _dataSource as? DataSource {
            return ds
        }
        let dataSource = DataSource.init(tableView: table) { tableView, indexPath, scene in
            let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.xl.xl_identifier, for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.text = "\(scene.title)"
            // content.secondaryText = "\(scene.desc)"
            cell.contentConfiguration = content
            return cell
        }
        dataSource.defaultRowAnimation = .fade
        _dataSource = dataSource
        return dataSource
    }
    private var _dataSnapshot: Any?
    var autoJumpRoute: DJTestType?
    @available(iOS 13.0, *)
    private var dataSnapshot: NSDiffableDataSourceSnapshot<String, DJTestType> {
        if let ds = _dataSnapshot as? NSDiffableDataSourceSnapshot<String, DJTestType> {
            return ds
        }
        var snapshot = NSDiffableDataSourceSnapshot<String, DJTestType>()
        snapshot.appendSections(["lxthyme", "DJTest"])
        snapshot.appendItems([
            .LXToolKit_Example,
            .LXToolKitObjC_Example,
            .DJSwiftModule,
            .dynamicIsland,
        ], toSection: "lxthyme")
        snapshot.appendItems([
            .djTest(title: "LXAMapTestVC",vc: { LXAMapTestVC() }),
            .djTest(title: "LXOutlineVC", vc: { LXOutlineVC() }),
        ].reversed(), toSection: "DJTest")
        _dataSnapshot = snapshot
        return snapshot
    }
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prepareUI()
        prepareTableView()

        let route1Int = UserDefaults.standard.integer(forKey: DJTestType.AutoJumpRoute)
        if let route1 = DJTestType.fromInt(idx: route1Int) {
            // autoJumpRoute = route1
            // autoJumpRoute = DJTestType.dynamicIsland
            // .LXToolKit_Example
                // .LXToolKitObjC_Example
            gotoScene(by: route1)
        }

        startActivity()
    }
}

// MARK: 🌎LoadData
extension ViewController {}

// MARK: 👀Public Actions
extension ViewController {}

// MARK: - 🔐Activity
private extension ViewController {
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

// MARK: 🔐Private Actions
private extension ViewController {
    func gotoScene(by scene: DJTestType?, route2 tmp: String = "") {
        guard let scene else { return }
        UserDefaults.standard.set(scene.intValue(), forKey: DJTestType.AutoJumpRoute)
        guard let vc = scene.vc else {
            dlog("-->gotoScene error on scene: \(scene)")
            return
        }
        // UserDefaults.standard.set(vc.xl.xl_typeName, forKey: scene.userDefaultsKey())
        var route2 = tmp
        if route2.isEmpty {
            route2 = UserDefaults.standard.string(forKey: scene.userDefaultsKey()) ?? ""
        }
        if let vc = vc as? LXToolKitTestVC {
            vc.autoJumpRoute =
                .subitem(title: "LXToolKit_Example." + route2, vc: .vcString(vcString:
                                                    "LXToolKit_Example." +
                                                  // "LXOutlineVC"
                                                  // "LXLabelVC"
                                                  // "LXStack1206VC"
                                                  // "LXTableTestVC"
                                                  // "LXRxSwiftTestVC"
                                                  route2
                                                 ))
        } else if let vc = vc as? LXToolKitObjCTestVC {
            vc.autoJumpRoute =
            // "LXLabelTestVC"
            // "LXPopTestVC"
            // "DJCommentVC"
            // "LXViewAnimationARCTestVC"
            // "LXCollectionTestVC"
            route2
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDelegate {
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
        let random = Int.random(in: 0..<10)
        if random == 6 {
            fatalError("test fatalError with random: \(random)")
        }
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
extension ViewController {
    override func prepareTableView() {
        super.prepareTableView()

        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.xl.xl_identifier)
        table.xl.registerHeaderOrFooter(UITableViewHeaderFooterView.self)
        if #available(iOS 14.0, *) {
            DispatchQueue.main.async {
                self.dataSource.apply(self.dataSnapshot, animatingDifferences: true)
            }
        } else {
            // Fallback on earlier versions
            // table.dataSource = self
        }
    }
    override func prepareUI() {
        super.prepareUI()
        self.view.backgroundColor = .white
        [table].forEach(self.view.addSubview)
        masonry()
    }
    override func masonry() {
        super.masonry()
        table.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

#Preview("ViewController") {
    return ViewController()
}
