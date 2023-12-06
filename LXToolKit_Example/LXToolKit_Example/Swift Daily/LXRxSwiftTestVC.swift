//
//  LXRxSwiftTestVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/9/20.
//
import UIKit
import LXToolKit
import RxSwift
import AlamofireImage

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
    private lazy var imgDownloader: ImageDownloader = {
        let downloader = ImageDownloader(configuration: ImageDownloader.defaultURLSessionConfiguration(),
                                         downloadPrioritization: .fifo,
                                         maximumActiveDownloads: 4,
                                         imageCache: AutoPurgingImageCache())
        return downloader
    }()
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

        // Task(priority: TaskPriority.userInitiated) {
        // async {
        _Concurrency.Task {
            await testM4()
        }
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
    func downloadImage(url: URL) async -> Image {
        let request = URLRequest(url: url)
        let result = await withCheckedContinuation { continuation in
            imgDownloader.download(request, completion: { response in
                if case .success(let img) = response.result {
                    dlog("img: \(url)")
                    continuation.resume(returning: img)
                }
            })
        }
        return result
    }
    // typealias LXResult = (url: String, img: Image)
    typealias LXResult = [String: Image]
    func loadImages(urls: [String]) async -> [String: Image] {
        await withTaskGroup(of: LXResult.self) { group in
            for urlString in urls {
                if let url = URL(string: urlString) {
                    group.addTask {
                        // (url: urlString, img: await self.downloadImage(url: url))
                        [urlString: await self.downloadImage(url: url)]
                    }
                }
            }

            var imageList: [String: Image] = [:]
            for await item in group {
                // imageList.append([
                //     url: img
                // ])
                imageList += item
            }
            return imageList
        }
    }
    func testM4() async {
        let urlList = [
            // "https://img.xjh.me/random_img.php?type=bg&ctype=nature&return=302",
            // "https://img.xjh.me/random_img.php?type=bg&ctype=nature&return=302",
            // "https://img.xjh.me/random_img.php?type=bg&ctype=nature&return=302",
            // "https://img.xjh.me/random_img.php?type=bg&ctype=nature&return=302",
            // "https://img.xjh.me/random_img.php?type=bg&ctype=nature&return=302",
            "https://loremflickr.com/320/240?random=1",
            "https://loremflickr.com/320/240?random=2",
            "https://loremflickr.com/320/240?random=3",
            "https://loremflickr.com/320/240?random=4",
            "https://loremflickr.com/320/240?random=5",
            "https://loremflickr.com/320/240?random=6",
            "https://loremflickr.com/320/240?random=7",
            "https://loremflickr.com/320/240?random=8",
        ]
        // async let imgList = await loadImages(urls: urlList)
        // dlog("imgList: \(await imgList.map { $0.0 })")
        if let url1 = URL(string: "https://loremflickr.com/320/240?random=1"),
           let url2 = URL(string: "https://loremflickr.com/320/240?random=2"),
           let url3 = URL(string: "https://loremflickr.com/320/240?random=3"),
           let url4 = URL(string: "https://loremflickr.com/320/240?random=4"),
           let url5 = URL(string: "https://loremflickr.com/320/240?random=5") {
            async let img1Async = downloadImage(url: url1)
            async let img2Async = downloadImage(url: url2)
            async let img3Async = downloadImage(url: url3)
            async let img4Async = downloadImage(url: url4)
            async let img5Async = downloadImage(url: url5)
            // let result = await (img1, img2, img3, img4, img5)
            // dlog("result: \(result)")
            let img1 = await img1Async
            dlog("img1: \(img1)")
            let img2 = await img2Async
            dlog("img2: \(img2)")
            let img3 = await img3Async
            dlog("img3: \(img3)")
            let img4 = await img4Async
            dlog("img4: \(img4)")
            let img5 = await img5Async
            dlog("img5: \(img5)")
        }
        // Task {
        //     let observer = PublishSubject<Int>()
        //     observer.onNext(1)
        //     observer.onNext(2)
        //     do {
        //         for try await value in observer.values {
        //             dlog("v: \(value)")
        //         }
        //     } catch {
        //         dlog("-->error: \(error)")
        //     }
        //     observer.onNext(3)
        //     observer.onNext(4)
        //     observer.onNext(5)
        // }
        // await tmp()
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXRxSwiftTestVC {
    func prepareVM() {
        btnLogin.rx.tap
            .asDriver()
            .drive(onNext: { _ in
            // .subscribe { _ in
                dlog("btnLogin tapped!")
            })
            .disposed(by: rx.disposeBag)
    }
    func prepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        [btnLogin].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {
        btnLogin.snp.makeConstraints {
            $0.top.equalTo(100)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(44)
        }
    }
}
