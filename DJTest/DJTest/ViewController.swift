//
//  ViewController.swift
//  DJTest
//
//  Created by lxthyme on 2023/6/28.
//

import UIKit
import LXToolKit_Example
import LXToolKitObjC_Example

enum DJTestType {
    // case LXToolKit
    case LXToolKit_Example
    // case LXToolKitObjC
    case LXToolKitObjC_Example
    case DJSwiftModule
    // case DJRSwiftResource
    var title: String {
        switch self {
            // case .LXToolKit:
            //     return "LXToolKit"
        case .LXToolKit_Example:
            return "LXToolKit_Example"
            // case .LXToolKitObjC:
            //     return "LXToolKitObjC"
        case .LXToolKitObjC_Example:
            return "LXToolKitObjC_Example"
        case .DJSwiftModule:
            return "DJSwiftModule"
        }
    }
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
            let window = UIApplication.shared.keyWindow
            let app = Application.shared;
            app.previousRootVC = window?.rootViewController
            app.presentInitialScreen(in: window)
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
        snapshot.appendSections(["2022", "2023"])
        snapshot.appendItems([
            .LXToolKit_Example,
            .LXToolKitObjC_Example,
            .DJSwiftModule
        ], toSection: "2022")
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

        autoJumpRoute =
            .LXToolKit_Example
            // .LXToolKitObjC_Example
         gotoScene(by: autoJumpRoute)
    }
}

// MARK: 🌎LoadData
extension ViewController {}

// MARK: 👀Public Actions
extension ViewController {}

// MARK: 🔐Private Actions
private extension ViewController {
    func gotoScene(by scene: DJTestType?) {
        if #available(iOS 14.0, *),
           let vc = scene?.vc {
            if let vc2 = vc as? LXToolKitTestVC {
                // vc2.autoJumpRoute =
                    // .vcString(vcString: "LXOutlineVC")
                    // .vcString(vcString: "LXLabelVC")
                    // .vcString(vcString: "LXStack1206VC")
            } else if let vc2 = vc as? LXToolKitObjCTestVC {
                vc2.autoJumpRoute =
                // "LXLabelTestVC"
                "LXPopTestVC"
                // "DJCommentVC"
            }
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            // Fallback on earlier versions
            dlog("-->Error!")
        }
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
