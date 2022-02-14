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
    lazy var backBarButton: UIBarButtonItem = {
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
    var emptyDataSetTitle = R.string.localizabled.commonNoResults.key.localized()
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
        prepareGesture()
        prepareNotification()
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LXBaseMVVMVC {}

// MARK: 👀Public Actions
extension LXBaseMVVMVC {}

// MARK: - 👀Notification Action
extension LXBaseMVVMVC {
    func orientationChanged() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            // self.updateUI()
        }
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

// MARK: 🔐Private Actions
private extension LXBaseMVVMVC {
    func adjustLeftBarButtonItem() {
        if self.navigationController?.viewControllers.count ?? 0 > 1 { // Pushed
            self.navigationItem.leftBarButtonItem = nil
        } else if self.presentingViewController != nil { // presented
            self.navigationItem.leftBarButtonItem = btnClosed
        }
    }
    @objc func closeAction(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
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
    }
    func prepareUI() {
        self.view.backgroundColor = .white

        // [<#table#>].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {}
}
