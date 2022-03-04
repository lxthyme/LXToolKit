//
//  LXBaseMVVMVC.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/2/10.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import DZNEmptyDataSet
import Hero
import Localize_Swift
// import GoogleMobileAds
import SVProgressHUD
import Rswift
import SnapKit

struct LXEmptyDataSet: Equatable {
    var identifier = "233"
    var btnTap = PublishSubject<Void>()
    var title = R.string.localizabled.commonNoResults()
    var description = ""
    var img = R.image.image_no_result()
    var imgTintColor = BehaviorRelay<UIColor?>(value: nil)

    static func == (lhs: LXEmptyDataSet, rhs: LXEmptyDataSet) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

class LXBaseMVVMVC: LXBaseVC, LXNavigatable {
    deinit {
        dlog("---------- >>>VC: \(self.xl.xl_typeName)\t\tdeinit <<<----------")
        LXPrint.resourcesCount()
    }
    // MARK: 📌UI
    lazy var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    lazy var contentStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        return v
    }()
    lazy var btnClosed: UIBarButtonItem = {
        let btn = UIBarButtonItem(image: R.image.icon_navigation_close(),
                                  style: .plain,
                                  target: self,
                                  action: nil)
        btn.rx.tap
            .asObservable()
            .subscribe(onNext: {[weak self] _ in
                guard let `self` = self else { return }
                Logger.debug("🛠1. onNext - btnClosed - tap: ")
                self.navigator.dismiss(sender: self)
            })
            .disposed(by: rx.disposeBag)
        return btn
    }()
    lazy var btnBack: UIBarButtonItem = {
        let view = UIBarButtonItem()
        view.title = ""
        return view
    }()
    // MARK: 🔗Vaiables
    var viewModel: LXBaseVM?
    var navigator: LXNavigator!

    let isLoading = BehaviorRelay(value: false)
    let error = PublishSubject<ApiError>()

    var automaticallyAdjustsLeftBarButtonItem = true
    var canOpenFlex = true

    var navigationTitle = "" {
        didSet {
            navigationItem.title = navigationTitle
        }
    }

    let emptyDataSetButtonTap = PublishSubject<Void>()
    var emptyDataSetTitle = R.string.localizabled.commonNoResults()
    var emptyDataSetDescription = ""
    var emptyDataSetImage = R.image.image_no_result()
    var emptyDataSetImageTintColor = BehaviorRelay<UIColor?>(value: nil)

    let languageChanged = BehaviorRelay<Void>(value: ())

    let orientationEvent = PublishSubject<Void>()
    let motionShakeEvent = PublishSubject<Void>()
    // MARK: 🛠Life Cycle
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    init(viewModel: LXBaseVM?, navigator: LXNavigator) {
        self.viewModel = viewModel
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if automaticallyAdjustsLeftBarButtonItem {
            adjustLeftBarButtonItem()
        }
        updateUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUI()

        LXPrint.resourcesCount()
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
        prepareGesture()
        prepareNotification()
        prepareUI()
        updateUI()
        bindViewModel()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        logDebug("\(type(of: self)): Received Memory Warning")
    }
    func updateUI() {}
    func bindViewModel() {
        viewModel?.loading.asObservable().bind(to: isLoading).disposed(by: rx.disposeBag)
        viewModel?.parsedError.asObservable().bind(to: error).disposed(by: rx.disposeBag)

        languageChanged.subscribe(onNext: { [weak self] () in
            self?.emptyDataSetTitle = R.string.localizabled.commonNoResults()
        }).disposed(by: rx.disposeBag)

        isLoading.subscribe(onNext: { isLoading in
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        }).disposed(by: rx.disposeBag)
    }
}

// MARK: 🌎LoadData
extension LXBaseMVVMVC {}

// MARK: 👀Public Actions
extension LXBaseMVVMVC {
    func startAnimating() {
        SVProgressHUD.show()
    }
    func stopAnimating() {
        SVProgressHUD.dismiss()
    }
}

// MARK: - 👀Notification Action
extension LXBaseMVVMVC {
    func orientationChanged() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.updateUI()
        }
    }
    func didBecomeActive() {
        self.updateUI()
    }
}

// MARK: - 👀Gesture Action
extension LXBaseMVVMVC {
    @objc func handleOneFingerSwipe(swipeRecognizer: UISwipeGestureRecognizer) {
        if swipeRecognizer.state == .recognized, canOpenFlex {
            LibsManager.shared.showFlex()
        }
    }

    @objc func handleTwoFingerSwipe(swipeRecognizer: UISwipeGestureRecognizer) {
        if swipeRecognizer.state == .recognized {
            LibsManager.shared.showFlex()
            HeroDebugPlugin.isEnabled = !HeroDebugPlugin.isEnabled
        }
    }
}

// MARK: 🔐Adjusting Navigation Item
private extension LXBaseMVVMVC {
    func adjustLeftBarButtonItem() {
        // Pushed
        if self.navigationController?.viewControllers.count ?? 0 > 1 {
            self.navigationItem.leftBarButtonItem = nil
        } else if self.presentingViewController != nil {
            // presented
            self.navigationItem.leftBarButtonItem = btnClosed
        }
    }
    @objc func closeAction(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
// MARK: - 👀
extension LXBaseMVVMVC {
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            motionShakeEvent.onNext(())
        }
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXBaseMVVMVC {
    func prepareNotification() {
        // Observe device orientation change
        NotificationCenter.default.rx
            .notification(UIDevice.orientationDidChangeNotification).mapToVoid()
            .bind(to: orientationEvent)
            .disposed(by: rx.disposeBag)

        orientationEvent
            .subscribe { [weak self] (event) in
                self?.orientationChanged()
            }
            .disposed(by: rx.disposeBag)

        // Observe application did become active notification
        NotificationCenter.default
            .rx.notification(UIApplication.didBecomeActiveNotification)
            .subscribe { [weak self] (event) in
                self?.didBecomeActive()
            }.disposed(by: rx.disposeBag)

        NotificationCenter.default
            .rx.notification(UIAccessibility.reduceMotionStatusDidChangeNotification)
            .subscribe(onNext: { (event) in
                logDebug("Motion Status changed")
            }).disposed(by: rx.disposeBag)

        // Observe application did change language notification
        NotificationCenter.default
            .rx.notification(NSNotification.Name(LCLLanguageChangeNotification))
            .subscribe { [weak self] (event) in
                self?.languageChanged.accept(())
            }.disposed(by: rx.disposeBag)
    }
    func prepareGesture() {
        // One finger swipe gesture for opening Flex
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleOneFingerSwipe(swipeRecognizer:)))
        swipeGesture.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(swipeGesture)

        // Two finger swipe gesture for opening Flex and Hero debug
        let twoSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleTwoFingerSwipe(swipeRecognizer:)))
        twoSwipeGesture.numberOfTouchesRequired = 2
        self.view.addGestureRecognizer(twoSwipeGesture)

        motionShakeEvent
            .subscribe(onNext: {[weak self] event in
                // guard let `self` = self else { return }
                let theme = themeService.type.toggled()
                themeService.switch(theme)
                dlog("🛠1. onNext: \(event)")
            })
            .disposed(by: rx.disposeBag)
    }
    func prepareUI() {
        self.view.backgroundColor = .white
        hero.isEnabled = true
        navigationItem.backBarButtonItem = btnBack

        [self.contentView].forEach(self.view.addSubview)
        [self.contentStackView].forEach(self.contentView.addSubview)

        masonry()
    }

    func masonry() {
        self.view.snp.setLabel("\(self.view.xl.xl_typeName).view")
        self.contentView.snp.setLabel("\(self.contentView.xl.xl_typeName).contentView")
        self.contentStackView.snp.setLabel("\(self.contentStackView.xl.xl_typeName)")
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
