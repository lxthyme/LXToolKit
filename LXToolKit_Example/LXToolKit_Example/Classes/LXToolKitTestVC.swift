//
//  LXToolKitTestVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/4/11.
//
import UIKit
import LXToolKit

class DataSource: UITableViewDiffableDataSource<String, Navigator.Scene> {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.snapshot().sectionIdentifiers[section];
    }
}

open class LXToolKitTestVC: LXBaseTableVC {
    // MARK: 📌UI
    // private var testVC = LXTestVC()
    // lazy var dataList: [LXNavigator.Scene] = {
    //     let staging = Configs.Network.useStaging
    //     let githubProvider = staging
    //         ? GithubNetworking.stubbingNetworking()
    //         : GithubNetworking.defaultNetworking()
    //     let trendingGithubProvider = staging
    //         ? TrendingGithubNetworking.stubbingNetworking()
    //         : TrendingGithubNetworking.defaultNetworking()
    //     let codetabsProvider = staging
    //         ? CodetabsNetworking.stubbingNetworking()
    //         : CodetabsNetworking.defaultNetworking()
    //     let provider = RestApi(githubProvider: githubProvider,
    //                            trendingGithubProvider: trendingGithubProvider,
    //                            codetabsProvider: codetabsProvider)
    //     let vm = LXBaseVM(provider: provider)
    //     return [
    //         .LXiOS15VC(viewModel: vm),
    //         .LXTable0120VC(viewModel: vm)
    //     ]
    // }()
    private var _dataSource: UITableViewDataSource?
    @available(iOS 14.0, *)
    private var dataSource: DataSource {
        if let ds = _dataSource as? DataSource {
            return ds
        }
        let dataSource = DataSource.init(tableView: table) { tableView, indexPath, scene in
            let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.xl.xl_identifier, for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.text = "\(scene.info.title)"
            content.secondaryText = "\(scene.info.desc)"
            cell.contentConfiguration = content
            return cell
        }
        dataSource.defaultRowAnimation = .fade
        _dataSource = dataSource
        return dataSource
    }
    private var _dataSnapshot: Any?
    @available(iOS 13.0, *)
    private var dataSnapshot: NSDiffableDataSourceSnapshot<String, Navigator.Scene> {
        if let ds = _dataSnapshot as? NSDiffableDataSourceSnapshot<String, Navigator.Scene> {
            return ds
        }
        // let staging = AppConfig.Network.useStaging
        // let githubProvider = staging
        // ? LXNetworking<GithubAPI>.stubbingNetworking()
        // :  LXNetworking<GithubAPI>.defaultNetworking()
        // let trendingGithubProvider = staging
        // ? LXNetworking<TrendingGithubAPI>.stubbingNetworking()
        // : LXNetworking<TrendingGithubAPI>.defaultNetworking()
        // let codetabsProvider = staging
        // ? LXNetworking<CodetabsApi>.stubbingNetworking()
        // : LXNetworking<CodetabsApi>.defaultNetworking()
        // let provider = RestApi(githubProvider: githubProvider,
        //                        trendingGithubProvider: trendingGithubProvider,
        //                        codetabsProvider: codetabsProvider)
        let vm = LXBaseVM()
        var snapshot = NSDiffableDataSourceSnapshot<String, Navigator.Scene>()
        snapshot.appendSections([
            "Swift Daily",
            "2023",
            "WWDC",
            "MVVM",
            "2022",
            "2021",
            "2020"
        ])
        snapshot.appendItems([
            .vc(identifier: DJSwiftTestCaseVC.xl.xl_typeName, vcProvider: { DJSwiftTestCaseVC() }),
            .vc(identifier: DJSwiftTestCaseVC.xl.xl_typeName, vcProvider: { DJSwiftTestCaseVC() }),
            .vc(identifier: LXRxSwiftTestVC.xl.xl_typeName, vcProvider: {[weak self] in
                guard let self else { return nil }
                return LXRxSwiftTestVC(vm: vm, navigator: self.navigator)
            }),
        ], toSection: "Swift Daily")
        snapshot.appendItems([
            .openURL(url: URL(string: "http://baidu.com")),
            .openURL(url: URL(string: "http://baidu.com"), inWebView: true),
            .tabs(vm: DJHomeTabBarVM(authorized: false)),
            .vc(identifier: "DJHomeTabBarVC + UISplitViewController", vcProvider: {
                let keyWindow = UIApplication.xl.keyWindow
                Application.shared.presentInitialScreen(in: keyWindow)
                return nil
            }),
            .vc(identifier: LXMVVMSampleVC.xl.xl_typeName, vcProvider: { LXMVVMSampleVC() }),
            .vc(identifier: HomeViewController.xl.xl_typeName, vcProvider: { HomeViewController() }),
            .vc(identifier: LXAttributedStringVC.xl.xl_typeName, vcProvider: { LXAttributedStringVC() }),
        ], toSection: "MVVM")
        snapshot.appendItems([
            .vc(identifier: LXAttributedStringVC.xl.xl_typeName, vcProvider: { LXAttributedStringVC() }),
        ], toSection: "WWDC")
        snapshot.appendItems([
            .vc(identifier: LX03_08_03VC.xl.xl_typeName, vcProvider: { LX03_08_03VC() }),
            .vc(identifier: LXHandyJSONTestVC.xl.xl_typeName, vcProvider: { () -> UIViewController? in
                let vm = LXFloatTestVM()
                let vc = LXHandyJSONTestVC(vm: vm, navigator: self.navigator)
                return vc
            }),
            .vc(identifier: LXWebVC.xl.xl_typeName, vcProvider: { LXWebVC() }),
            .vc(identifier: LXStrenchableWebVC.xl.xl_typeName,vcProvider: {[weak self] in
                guard let `self` = self else { return nil }
                return LXStrenchableWebVC(vm: vm, navigator: self.navigator)
            }),
            .vc(identifier: LXLabelVC.xl.xl_typeName, vcProvider: { LXLabelVC() }),
            .vc(identifier: LXActionSheetTestVC.xl.xl_typeName, vcProvider: { LXActionSheetTestVC() }),
            .vc(identifier: LXTableTestVC.xl.xl_typeName, vcProvider: { LXTableTestVC(vm: vm, navigator: self.navigator) }),
            .vc(identifier: LXCollectionVC.xl.xl_typeName, vcProvider: { LXCollectionVC() })
        ], toSection: "2023")
        snapshot.appendItems([
            .vc(identifier: LXTable0120VC.xl.xl_typeName,vcProvider: {[weak self] in
                guard let `self` = self else { return nil }
                return LXTable0120VC(vm: vm, navigator: navigator)
            }),
            // .LXiOS15ButtonTestVC,
            .vc(identifier: LXiOS15VC.xl.xl_typeName,vcProvider: {[weak self] in
                guard let `self` = self else { return nil }
                return LXiOS15VC(vm: vm, navigator: navigator)
            }),
            .vc(identifier: LXMasonryTestVCVC.xl.xl_typeName,vcProvider: {[weak self] in
                guard let `self` = self else { return nil }
                return LXMasonryTestVCVC(vm: vm, navigator: navigator)
            }),
            // .login(vm: LXLoginVM(with: provider)),
            // .events(vm: LXEventsVM(with: .user(user: User()), provider: provider)),
                .vc(identifier: LXWebViewTestVC.xl.xl_typeName,vcProvider: {[weak self] in
                    guard let `self` = self else { return nil }
                    return LXWebViewTestVC(vm: vm, navigator: navigator)
                }),
            .vc(identifier: LXLoggerTestVC.xl.xl_typeName, vcProvider: { LXLoggerTestVC() }),
            .vc(identifier: LXYYLabelMoreTestVC.xl.xl_typeName, vcProvider: {[weak self] in
                guard let `self` = self else { return nil }
                return LXYYLabelMoreTestVC(vm: vm, navigator: navigator)
            }),
            .vc(identifier: RxNetworksTestVC.xl.xl_typeName, vcProvider: { RxNetworksTestVC() }),
            // .HomeViewController(viewModel: vm),
            // .test(vm: vm),
            // .tabs(vm: vm as! DJHomeTabBarVM),
        ], toSection: "2022")
        snapshot.appendItems([
            .vc(identifier: LX0114VC.xl.xl_typeName, vcProvider: { LX0114VC() }),
            // .LXPhotoAlbumVC,
            .vc(identifier: LXPickerVC.xl.xl_typeName, vcProvider: { LXPickerVC() }),
            .vc(identifier: ExampleViewController.xl.xl_typeName, vcProvider: { ExampleViewController() }),
            .vc(identifier: LX0117VC.xl.xl_typeName, vcProvider: { LX0117VC() }),
            .vc(identifier: LXClsListVC.xl.xl_typeName, vcProvider: { LXClsListVC() }),
            .vc(identifier: LXCubeVC.xl.xl_typeName, vcProvider: { LXCubeVC() }),
            .vc(identifier: LXRx0225VC.xl.xl_typeName, vcProvider: { LXRx0225VC() }),
            .vc(identifier: LX0324EventsVC.xl.xl_typeName, vcProvider: { LX0324EventsVC() }),
            .vc(identifier: LXNestedTableVC.xl.xl_typeName, vcProvider: { LXNestedTableVC() }),
            .vc(identifier: LXTableTestVC.xl.xl_typeName, vcProvider: { LXTableTestVC() }),
            .vc(identifier: LX1019TestVC.xl.xl_typeName, vcProvider: { LX1019TestVC() }),
            .vc(identifier: LXHugTestVC.xl.xl_typeName, vcProvider: { LXHugTestVC() }),
            .vc(identifier: LXStack1206VC.xl.xl_typeName, vcProvider: { LXStack1206VC() }),
        ], toSection: "2021")
        snapshot.appendItems([
            .vc(identifier: LXMultiRequestTestVC.xl.xl_typeName, vcProvider: { LXMultiRequestTestVC() }),
            .vc(identifier: LXOffScreenVC.xl.xl_typeName, vcProvider: { LXOffScreenVC() }),
            .vc(identifier: LXResolveIMPVC.xl.xl_typeName, vcProvider: { LXResolveIMPVC() }),
            .vc(identifier: LXRequiredVC.xl.xl_typeName, vcProvider: { LXRequiredVC() }),
            .vc(identifier: LXRequiredVC1.xl.xl_typeName, vcProvider: { LXRequiredVC1() }),
            .vc(identifier: LXTransitionVC.xl.xl_typeName, vcProvider: { LXTransitionVC() }),
            .vc(identifier: LXProxyTestVC.xl.xl_typeName, vcProvider: { LXProxyTestVC() }),
            .vc(identifier: LXTestStringVC.xl.xl_typeName, vcProvider: { LXTestStringVC() }),
            .vc(identifier: LXPresentVC.xl.xl_typeName, vcProvider: { LXPresentVC() }),
            .vc(identifier: LXTestVC.xl.xl_typeName, vcProvider: { LXTestVC() }),
            .vc(identifier: LXStackViewVC.xl.xl_typeName, vcProvider: { LXStackViewVC() }),
            .vc(identifier: LXWikipediaImageSearchVC.xl.xl_typeName, vcProvider: { LXWikipediaImageSearchVC() }),
            .vc(identifier: LXStackTestVC.xl.xl_typeName, vcProvider: { LXStackTestVC() }),
            .vc(identifier: LXButtonTestVC.xl.xl_typeName, vcProvider: { LXButtonTestVC() }),
            .vc(identifier: LXImageTestVC.xl.xl_typeName, vcProvider: { LXImageTestVC() }),
            .vc(identifier: LXDaily1117VC.xl.xl_typeName, vcProvider: { LXDaily1117VC() }),
            .vc(identifier: LXKingfisherVC.xl.xl_typeName, vcProvider: { LXKingfisherVC() }),
            .vc(identifier: LXStackMessageVC.xl.xl_typeName, vcProvider: { LXStackMessageVC() }),
            .vc(identifier: LXLockTestVC.xl.xl_typeName, vcProvider: { LXLockTestVC() }),
            .vc(identifier: LXTTTTT.xl.xl_typeName, vcProvider: { LXTTTTT() }),
            .vc(identifier: LXMusicVC.xl.xl_typeName, vcProvider: { LXMusicVC() }),
            .vc(identifier: LXSongVC.xl.xl_typeName, vcProvider: { LXSongVC() }),
            .vc(identifier: LXLightedVC.xl.xl_typeName, vcProvider: { LXLightedVC() }),
        ], toSection: "2020")
        _dataSnapshot = snapshot
        return snapshot
    }
    // MARK: 🔗Vaiables
    public var autoJumpRoute: Navigator.Scene?
    // MARK: 🛠Life Cycle
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // let vc =
        //            LXApiTestVC()
        //            LXMultiRequestTestVC()
        //            LXOffScreenVC()
        //            LXResolveIMPVC()
        //            LXRequiredVC()
        //            LXLightedVC()
        //            LXProxyTestVC()
        //            LXTestStringVC()
        //            LXPresentVC()
        //            LXTestVC()
        //            LXStackViewVC()
        //            LXWikipediaImageSearchVC()
        //            LXStackTestVC()
        //            LXImageTestVC()
        //            LXDaily1117VC()
        //            LXStackTestVC()
        //            LXStackMessageVC()
        //            LXMusicVC()
        //            LXSongVC()
        //            LX0114VC()
        //            LXPickerVC()
        //            LX0117VC()
        // LXCubeVC()
        //            LXRx0225VC()
        // LXLoggerTestVC()
        // LXStrenchableWebVC()
        // UIViewController()
        
        // self.navigationController?.pushViewController(vc, animated: true)
        //        self.present(testVC, animated: true, completion: nil)
    }
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        prepareUI()
        prepareTableView()
        
        //        let _ = LXBaseVC()
        let identifier = self.xl.xl_typeName
        dlog("identifier: \(identifier)")
        let aa = "abccccc"
        dlog("\(aa.self): \(aa)")
        
        //        testArray()
        //        testDictionary()
        
        // testModel()
        // testTask()
        // testTaskGroup()
        gotoScene(by: autoJumpRoute)
    }
}

// MARK: 🌎LoadData
extension LXToolKitTestVC {}

// MARK: 👀Public Actions
extension LXToolKitTestVC {}

// MARK: 🔐Private Actions
private extension LXToolKitTestVC {}

// MARK: - 🔐Private Actions
private extension LXToolKitTestVC {
    func goRouter() {
        //         let navigator = XLNavigator()
        //         if let user = XLUserModel.currentUser() {
        // //            let provider = GithubNetworking.stubbingNetworking()
        //             let provider = GithubNetworking.defaultNetworking()
        //             let restApi = RestApi(with: provider)
        //             let vm = XLEventsVM(with: .user(user: user), provider: restApi)
        //             navigator.show(segue: .events(vm: vm), sender: self)
        //         }
        // let staging = AppConfig.Network.useStaging
        // let githubProvider = staging
        // ? LXNetworking<GithubAPI>.stubbingNetworking()
        // :  LXNetworking<GithubAPI>.defaultNetworking()
        // let trendingGithubProvider = staging
        // ? LXNetworking<TrendingGithubAPI>.stubbingNetworking()
        // : LXNetworking<TrendingGithubAPI>.defaultNetworking()
        // let codetabsProvider = staging
        // ? LXNetworking<CodetabsApi>.stubbingNetworking()
        // : LXNetworking<CodetabsApi>.defaultNetworking()
        // let provider = RestApi(githubProvider: githubProvider,
        //                        trendingGithubProvider: trendingGithubProvider,
        //                        codetabsProvider: codetabsProvider)
        let vm = LXBaseVM()
        let navigator = Navigator.default
        let scene: Navigator.Scene = .vc(vcProvider: {[weak self] in
            guard let `self` = self else { return nil }
            return LXiOS15VC(vm: vm, navigator: self.navigator)
        })
        navigator.show(segue: scene, sender: self)
    }
    @objc func btnTestAction(sender: UIButton) {
        // let vc =
        //  // LXSongVC()
        //  // LXNestedTableVC()
        //  // LXTableTestVC()
        //  // LX1019TestVC()
        //  // LXHugTestVC()
        //  // LXStack1206VC()
        //  // LXTable0120VC()
        //  LXiOS15VC()
        //  self.navigationController?.setNavigationBarHidden(true, animated: false)
        //  self.navigationController?.pushViewController(vc, animated: true)
        // self.navigationController?.pushViewController(vc, animated: true)
        goRouter()
        // testTaskGroup()
    }
    func gotoScene(by scene: Navigator.Scene?) {
        guard let scene else { return }
        let navigator = Navigator.default
        navigator.show(segue: scene, sender: self)
    }
}

extension LXToolKitTestVC {
    func testModel() {
        //        LXGitHubTestModel.test()
        // LXMJExtensionTestModel.test()
    }
    func test2() {
        let params: [String: Any]? = [:]
        let json = params?.keys.sorted()
            .reduce("", { $0 + $1 + (params?[$1].debugDescription ?? "") }) ?? ""
        if #available(iOS 11.0, *) {
            let _ = try? JSONSerialization.data(withJSONObject: [], options: .sortedKeys)
        } else {
            // Fallback on earlier versions
        }
        dlog("json: \(json)")
    }
    func testArray() {
        let a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        ({
            let search = 5
            let r_contains = a.contains(search)
            let r_firstIndex = a.firstIndex(of: search)
            let r_firstIndex_where = a.firstIndex(where: { $0 == search })
            let r_first_where = a.first(where: { $0 == search })
            dlog("r_contains: \(r_contains)", "r_firstIndex: \(r_firstIndex)", "r_firstIndex_where: \(r_firstIndex_where)", "r_first_where: \(r_first_where)")
        })()
        
        ({
            let search = 51
            let r_contains = a.contains(search)
            let r_firstIndex = a.firstIndex(of: search)
            let r_firstIndex_where = a.firstIndex(where: { $0 == search })
            let r_first_where = a.first(where: { $0 == search })
            dlog("r_contains: \(r_contains)", "r_firstIndex: \(r_firstIndex)", "r_firstIndex_where: \(r_firstIndex_where)", "r_first_where: \(r_first_where)")
        })()
        
        ({
            let r_min = a.min()
            let r_min_by1 = a.min(by: { $0 > $1 })
            let r_min_by2 = a.min(by: { $0 < $1 })
            dlog("r_min: \(r_min)", "r_min_by1: \(r_min_by1)", "r_min_by2: \(r_min_by2)")
            
            let r_max = a.max()
            let r_max_by1 = a.max(by: { $0 > $1 })
            let r_max_by2 = a.max(by: { $0 < $1 })
            dlog("r_max: \(r_max)", "r_max_by1: \(r_max_by1)", "r_max_by2: \(r_max_by2)")
        })()
        
        ({
            let aVersion = "3.14.10"
            let bVersion = "3.130.10"
            
            let r1 = aVersion.versionToInt().lexicographicallyPrecedes(bVersion.versionToInt())
            let r2 = bVersion.versionToInt().lexicographicallyPrecedes(aVersion.versionToInt())
            dlog("lexicographicallyPrecedes: \(r1)\t\t\(r2)")
        })()
        
        ({
            var a = [30, 40, 20, 30, 30, 60, 10]
            
            let r = a.partition(by: { $0 > 30 })
            dlog("partition r: \(r) >>> a: \(a)")
        })()
        
        ({
            let a = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
            
            let prefix_while = a.prefix(while: { $0 > 3 })
            let prefix_maxLength = a.prefix(3)
            let prefix_upTo = a.prefix(upTo: 3)
            let prefix_through = a.prefix(through: 3)
            dlog("prefix_while: \(prefix_while)",
                 "prefix_maxLength: \(prefix_maxLength)",
                 "prefix_upTo: \(prefix_upTo)",
                 "prefix_through: \(prefix_through)")
            
            let suffix_maxLength = a.suffix(3)
            let suffix_from = a.suffix(from: 3)
            
            dlog("suffix_maxLength: \(suffix_maxLength)", "suffix_from: \(suffix_from)")
        })()
        
        ({
            for x in sequence(first: 1, next: { $0 + 1}).prefix(5) {
                dlog("prefix x: \(x)")
            }
            
            for x in sequence(first: 2, next: { $0 * $0 }).prefix(while: { $0 < 100 }) {
                dlog("prefix_while x: \(x)")
            }
            
            for x in sequence(first: self.view, next: { $0?.superview }) {
                dlog("view x: \(x)")
            }
        })()
        
        ({
            let a = 1...3
            let b = 1...10
            let r_elementsEqual = a.elementsEqual(b)
            let r_elementsEqual2 = a.elementsEqual([1, 2, 3])
            let r2_elementsEqual_by = a.elementsEqual(b, by: {(e1, e2) in
                dlog("E: (\(e1), \(e2))")
                return e1 == e2
            })
            dlog("r_elementsEqual: \(r_elementsEqual)",
                 "r_elementsEqual2: \(r_elementsEqual2)",
                 "r2_elementsEqual_by: \(r2_elementsEqual_by)")
        })()
        
        ({
            let r_separator = a.split(separator: 3)
            let r_whereSeparator = a.split(whereSeparator: { $0 % 3 == 0 })
            let r_omittingEmptySubsequences = a.split(separator: 3, maxSplits: 2, omittingEmptySubsequences: false)
            
            dlog("r_separator: \(r_separator)",
                 "r_whereSeparator: \(r_whereSeparator)",
                 "r_omittingEmptySubsequences: \(r_omittingEmptySubsequences)")
            
            let line = "BLANCHE:   I don't want realism. I want magic!"
            dlog(line.split(separator: " "))
            dlog(line.split(separator: " ", maxSplits: 1))
            dlog(line.split(separator: " ", omittingEmptySubsequences: false))
        })()
        
        ({
            let r_while = a.drop(while: { $0 < 6 })
            let r_dropFirst = a.dropFirst(3)
            let r_dropLast = a.dropLast(3)
            
            var b = a
            b.removeAll(where: { $0 % 3 != 0 })
            dlog("r_while: \(r_while)",
                 "r_dropFirst: \(r_dropFirst)",
                 "r_dropLast: \(r_dropLast)",
                 "a: \(a)",
                 "",
                 "b: \(b)")
        })()
        
        ({
            let r = a.firstIndex(of: 3)
            dlog("r: \(r)")
        })()
        
        ({
            let b = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
            let r = zip(a, b)
            let r_zip_map = r.map { $0 + $1 }
            dlog("r: \(r)",
                 "r_zip_map: \(r_zip_map)")
        })()
    }
    
    func testDictionary() {
        let a: [String: String] = ["a": "vA", "b": "vB", "c": "vC", "d": "vD"]
        let b = ["d": "bbD", "e": "bbE", "f": "bbF"]
        
        let s1 = ({
            var b = a
            b["a"] = nil
            
            dlog("b: \(b)")
        })
        
        let s2 = ({
            var c = a
            c.merge(b, uniquingKeysWith: { $1 })
            dlog("c: \(c)")
        })
        
        let s3 = ({
            let frequncies = "hello".frequencies
            let r = frequncies.filter { $0.value > 1 }
            dlog("frequncies: \(frequncies)",
                 "r: \(r)"
            )
        })
        // s1()
        s2()
        s3()
    }
    @available(iOS 15.0.0, *)
    func foo() async {
        withUnsafeCurrentTask { task in
            if let task = task {
                print("Cancelled: \(task.isCancelled)")
                
                print("priority: \(task.priority)")
            } else {
                print("No task")
            }
        }
    }
    @available(iOS 15.0.0, *)
    func testTask() {
        
        // withUnsafeCurrentTask { task in
        //     print("task: \(task)")
        // }
        // Task {
        //     await foo()
        // }
    }
}

// MARK: - 👀
extension LXToolKitTestVC {
    @available(iOS 15.0.0, *)
    struct TaskGroupSample {
        func work(_ value: Int) async -> Int {
            print("Start work \(value)")
            // await Task.sleep(UInt64(value) * NSEC_PER_SEC)
            print("Work \(value) done!")
            return value
        }
        func start() async {
            print("Start")
            await withTaskGroup(of: Int.self, body: { group in
                for i in 0 ..< 3 {
                    group.addTask {
                        await work(i)
                    }
                }
                print("Task added!")
                
                for await result in group {
                    print("Get result: \(result)")
                }
                print("Task ended!")
            })
            
            print("End!")
        }
    }
}

extension String {
    func versionToInt() -> [Int] {
        return self.components(separatedBy: ".")
            .map { Int($0) ?? 0 }
    }
}

extension Sequence where Element: Hashable {
    var frequencies: [Element: Int] {
        let frequencyPairs = self.map { ($0, 1) }
        return Dictionary(frequencyPairs, uniquingKeysWith: +)
    }
}

// MARK: - ✈️UITableViewDataSource
// extension LXToolKitTestVC: UITableViewDataSource {
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
extension LXToolKitTestVC: UITableViewDelegate {
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
extension LXToolKitTestVC {
    public override func prepareTableView() {
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

#Preview("LXToolKitTestVC") {
    LXToolKitTestVC()
}
