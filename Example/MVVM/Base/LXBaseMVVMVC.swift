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
import SVProgressHUD
// import GoogleMobileAds

struct LXEmptyDataSet: Equatable {
    var identifier = "233"
    var btnTap = PublishSubject<Void>()
    var title = R.string.localizable.commonNoResults()
    var description = ""
    var img = R.image.image_no_result()
    var imgTintColor = BehaviorRelay<UIColor?>(value: nil)

    static func == (lhs: LXEmptyDataSet, rhs: LXEmptyDataSet) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

open class LXBaseMVVMVC: LXBaseVC, LXNavigatable {
    deinit {
        dlog("---------- >>>VC: \(self.xl.xl_typeName)\t\tdeinit <<<----------")
        LXPrint.resourcesCount()
    }
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    public var viewModel: LXBaseVM?
    public var navigator: LXNavigator!

    public let isLoading = BehaviorRelay(value: false)
    public let error = PublishSubject<ApiError>()

    public let emptyDataSetButtonTap = PublishSubject<Void>()
    public var emptyDataSetTitle = R.string.localizable.commonNoResults()
    public var emptyDataSetDescription = ""
    public var emptyDataSetImage = R.image.image_no_result()
    public var emptyDataSetImageTintColor = BehaviorRelay<UIColor?>(value: nil)

    public let languageChanged = BehaviorRelay<Void>(value: ())

    public let orientationEvent = PublishSubject<Void>()
    public let motionShakeEvent = PublishSubject<Void>()
    // MARK: 🛠Life Cycle
    required public init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    public init(viewModel: LXBaseVM?, navigator: LXNavigator) {
        self.viewModel = viewModel
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        LXPrint.resourcesCount()
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
        prepareGesture()
        prepareNotification()
        prepareUI()
        updateUI()
        bindViewModel()
    }
    public func bindViewModel() {
        viewModel?.loading.asObservable().bind(to: isLoading).disposed(by: rx.disposeBag)
        viewModel?.parsedError.asObservable().bind(to: error).disposed(by: rx.disposeBag)

        languageChanged.subscribe(onNext: { [weak self] () in
            self?.emptyDataSetTitle = R.string.localizable.commonNoResults()
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

// MARK: - 👀
extension LXBaseMVVMVC {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
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
        btnClosed.rx.tap
            .asObservable()
            .subscribe(onNext: {[weak self] _ in
                guard let `self` = self else { return }
                Logger.debug("🛠1. onNext - btnClosed - tap: ")
                self.navigator.dismiss(sender: self)
            })
            .disposed(by: rx.disposeBag)

        masonry()
    }

    func masonry() {}
}
