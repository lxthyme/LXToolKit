//
//  LXRxSwiftTestVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/9/20.
//
import UIKit
import LXToolKit
import RxSwift

class LXRxSwiftTestVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var btnLogin: UIButton = {
        let btn = UIButton(type: .custom)

        btn.setTitle("Login", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8

        // btn.addTarget(self, action: #selector(<#btnAction(sender:)#>), for: .touchUpInside)
        // @objc func <#btnAction#>(sender: UIButton) {}
        return btn
    }()
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
        prepareVM()
    }

}

// MARK: 🌎LoadData
extension LXRxSwiftTestVC {
    func dataFill() {}
}

// MARK: 👀Public Actions
extension LXRxSwiftTestVC {}

// MARK: 🔐Private Actions
private extension LXRxSwiftTestVC {
    func testM1() {
        struct Repository {
            var name: String?
        }
        let table = UITableView()
        let searchBar = UISearchBar()
        let searchResult = searchBar.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { text -> Observable<[Repository]> in
                if text.isEmpty {
                    return .just([])
                }
                return .just([])
            }
            .observe(on: MainScheduler.instance)

        searchResult
            .bind(to: table.rx.items(cellIdentifier: "Cell")) {(idx, repo, cell) in
                cell.textLabel?.text = repo.name
            }
            .disposed(by: rx.disposeBag)
    }
    func testM2() {
        let btn = UIButton()
        btn.rx.tap
            .subscribe { _ in
                dlog("btn tapped!")
            }
            .disposed(by: rx.disposeBag)

        let scrollView = UIScrollView()
        scrollView.rx.contentOffset
            .subscribe { contentOffset in
                dlog("contentOffset: \(contentOffset)")
            }
            .disposed(by: rx.disposeBag)

        // let notifiObserver = NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: nil) { notification in
        //     dlog("notification: \(notification)")
        // }
        // /// deinit
        // NotificationCenter.default.removeObserver(notifiObserver)
        NotificationCenter.default.rx
            .notification(UIApplication.willEnterForegroundNotification)
            .subscribe { notification in
                dlog("notification: \(notification)")
            }
            .disposed(by: rx.disposeBag)
    }
    func testM3() {
        let tfName = UITextField()
        let labNameInvalidTips = UILabel()
        let tfPwd = UITextField()
        let labPwdInvalidTips = UILabel()
        let tfPwdConfirm = UITextField()
        let btnLogin = UIButton()

        let nameValid = tfName.rx.text.orEmpty
            .map { $0.count >= 10 }
            .share(replay: 1)

        nameValid
            .bind(to: tfPwd.rx.isEnabled)
            .disposed(by: rx.disposeBag)
        nameValid
            .bind(to: labNameInvalidTips.rx.isHidden)
            .disposed(by: rx.disposeBag)

        let pwdValid = tfPwd.rx.text.orEmpty
            .map { $0.count >= 10 }
            .share(replay: 1)

        pwdValid
            .bind(to: labPwdInvalidTips.rx.isHidden)
            .disposed(by: rx.disposeBag)

        let allValid = Observable
            // .combineLatest(nameValid, pwdValid) { $0 && $1 }
            .combineLatest(nameValid, pwdValid, resultSelector: { $0 && $1 })
            .share(replay: 1)

        allValid
            .bind(to: btnLogin.rx.isEnabled)
            .disposed(by: rx.disposeBag)

        btnLogin.rx.tap
            .subscribe { _ in
                dlog("go to login...")
            }
            .disposed(by: rx.disposeBag)

    }
}

// MARK: - 🍺UI Prepare & Masonry
extension LXRxSwiftTestVC {
    override func prepareVM() {
        super.prepareVM()
        btnLogin.rx.tap
            .asDriver()
            .drive(onNext: { _ in
            // .subscribe { _ in
                dlog("btnLogin tapped!")
            })
            .disposed(by: rx.disposeBag)
    }
    override func prepareUI() {
        super.prepareUI()
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        [btnLogin].forEach(self.view.addSubview)

        masonry()
    }

    override func masonry() {
        super.masonry()
        btnLogin.snp.makeConstraints {
            $0.top.equalTo(100)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(44)
        }
    }
}
