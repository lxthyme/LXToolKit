//
//  LXTableTestVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/9/19.
//
import UIKit
import LXToolKit

class LXTableTestVC: LXBaseTableVC {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    private lazy var dataSource: UITableViewDiffableDataSource<String, String> = {
        let dataSource = UITableViewDiffableDataSource<String, String>.init(tableView: table) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.xl.xl_identifier, for: indexPath)
            // if #available(iOS 14.0, *) {
            //     var content = cell.defaultContentConfiguration()
            //     content.text = "\(item)_"
            //     cell.contentConfiguration = content
            // } else {
            //     // Fallback on earlier versions
            // }
            cell.textLabel?.text = "\(item)_"
            return cell
        }
        dataSource.defaultRowAnimation = .fade
        return dataSource
    }()
    private lazy var dataSnapshot: NSDiffableDataSourceSnapshot<String, String> = {
        var snapshot = NSDiffableDataSourceSnapshot<String, String>()
        snapshot.appendSections(["1", "3", "5"])
        snapshot.appendItems(["11", "13", "15"], toSection: "1")
        snapshot.appendItems(["31", "33", "35"], toSection: "3")
        snapshot.appendItems(["51", "53", "55"], toSection: "5")
        return snapshot
    }()
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
        prepareVM()
        prepareTableView()

        dataSource.apply(dataSnapshot, animatingDifferences: true)
    }

}

// MARK: 🌎LoadData
extension LXTableTestVC {}

// MARK: 👀Public Actions
extension LXTableTestVC {}

// MARK: 🔐Private Actions
private extension LXTableTestVC {}

// MARK: - 🍺UI Prepare & Masonry
extension LXTableTestVC {
    override func prepareTableView() {
        super.prepareTableView()
    }
    override func prepareVM() {
        super.prepareVM()
        self.headerRefreshTrigger
            .flatMapLatest({[weak self] _ -> Observable<RxSwift.Event<Int>> in
                guard let self else { return RxObservable.just(-1).materialize() }
                guard let vm = self.vm else {
                    return RxObservable
                        .just(-2)
                        .materialize()
                }
                return RxObservable.just(1)
                    .delay(.seconds(1), scheduler: MainScheduler.instance)
                    .trackActivity(vm.headerLoading)
                    .materialize()
            })
            .subscribe { event in
                switch event {
                case .next(let result):
                    dlog("result: \(result)")
                default: break
                }
            }
            .disposed(by: rx.disposeBag)
    }
    override func prepareUI() {
        super.prepareUI()
        self.view.backgroundColor = .white
        table.contentInsetAdjustmentBehavior = .never
        // navigationItem.title = ""

        [table].forEach(self.view.addSubview)

        masonry()
    }

    override func masonry() {
        super.prepareUI()
        table.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
