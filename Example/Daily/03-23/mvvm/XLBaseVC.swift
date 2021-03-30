//
//  XLBaseVC.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/24.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import DZNEmptyDataSet
import NVActivityIndicatorView
import Hero
import Localize_Swift

struct XLEmptyDataSet: Equatable {
    var identifier = "233"
    var btnTap = PublishSubject<Void>()
    var title = R.string.localizabled.commonNoResults()
    var description = ""
    var img = R.image.image_no_result()
    var imgTintColor = BehaviorRelay<UIColor?>(value: nil)

    static func == (lhs: XLEmptyDataSet, rhs: XLEmptyDataSet) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

class XLBaseVC: UIViewController, XLNavigatable, NVActivityIndicatorViewable {
    deinit {
        Logger.debug("\(type(of: self)): Deinited")
        Logger.resourcesCount()
    }
    // MARK: 📌UI
    private lazy var btnBack: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.title = ""
        return btn
    }()
    private lazy var btnClosed: UIBarButtonItem = {
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
    private lazy var spaceBarBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        return btn
    }()
    private lazy var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    lazy var contentStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.alignment = .fill
        v.spacing = 0
        return v
    }()
    // MARK: 🔗Vaiables
    var vm: XLBaseVM?
    var navigator: XLNavigator!

    let isLoading = BehaviorRelay(value: false)
    let error = PublishSubject<ApiError>()

    var automaticallyAdjustsLeftBarButtonItem = true
    var canOpenFlex = true

    var navigationTitle = "" {
        didSet {
            navigationItem.title = navigationTitle
        }
    }

    var emptyDataSet = XLEmptyDataSet()
    let languageChanged = BehaviorRelay<Void>(value: ())

    let orientationEvent = PublishSubject<Void>()
    let motionShakeEvent = PublishSubject<Void>()
    // MARK: 🛠Life Cycle
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    init(with vm: XLBaseVM?, navigator: XLNavigator) {
        self.vm = vm
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if automaticallyAdjustsLeftBarButtonItem {
            adjustLeftBarBtnItem()
        }
        updateUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        updateUI()
        Logger.resourcesCount()
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
        basePrepareUI()
        basePrepareNotification()
        basePrepareDebugGesture()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        Logger.warn("didReceiveMemoryWarning: \(type(of: self))")
    }
}

// MARK: 🌎LoadData
@objc extension XLBaseVC {
    func updateUI() {}
    func bindViewModel() {
        vm?.loading.asObservable()
            .bind(to: isLoading)
            .disposed(by: rx.disposeBag)
//        vm?.parsedError.asObservable()
//            .bind(to: error)
//            .disposed(by: rx.disposeBag)

        languageChanged
            .subscribe(onNext: {[weak self] _ in
                guard let `self` = self else { return }
                Logger.debug("🛠1. onNext - languageChanged:")
                self.emptyDataSet.title = R.string.localizabled.commonNoResults()
            })
            .disposed(by: rx.disposeBag)

        isLoading.subscribe(onNext: { isLoading in
            Logger.debug("🛠1. onNext - isLoading: \(isLoading)")
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        })
        .disposed(by: rx.disposeBag)
    }
}

// MARK: 👀Public Actions
extension XLBaseVC {
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            motionShakeEvent.onNext(())
        }
    }
    func didBecomeActive() {
        updateUI()
    }
    func orientationChanged() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.updateUI()
        }
    }
    func adjustLeftBarBtnItem() {
        if self.navigationController?.viewControllers.count ?? 0 > 1 {
            /// pushed
            self.navigationItem.leftBarButtonItem = nil
        } else if self.presentingViewController != nil {
            /// presented
            self.navigationItem.leftBarButtonItem = btnClosed
        }
    }
}

// MARK: 🔐Private Actions
private extension XLBaseVC {
    @objc func handleOneFingerSwipe(swipeRecognizer: UISwipeGestureRecognizer) {
        if swipeRecognizer.state == .recognized, canOpenFlex {
//            LibsManager.shared.showFlex()
        }
    }

    @objc func handleTwoFingerSwipe(swipeRecognizer: UISwipeGestureRecognizer) {
        if swipeRecognizer.state == .recognized {
//            LibsManager.shared.showFlex()
            HeroDebugPlugin.isEnabled = !HeroDebugPlugin.isEnabled
        }
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension XLBaseVC {
    func basePrepareNotification() {
        /// Observe device orientation change
        NotificationCenter.default.rx
            .notification(UIDevice.orientationDidChangeNotification)
            .mapToVoid()
            .bind(to: orientationEvent)
            .disposed(by: rx.disposeBag)
        orientationEvent
            .subscribe(onNext: {[weak self] event in
                guard let `self` = self else { return }
                Logger.debug("🛠1. onNext - orientationEvent: \(event)")
                self.orientationChanged()
            })
            .disposed(by: rx.disposeBag)

        /// Observe application did become active notification
        NotificationCenter.default.rx
            .notification(UIApplication.didBecomeActiveNotification)
            .subscribe(onNext: {[weak self] event in
                guard let `self` = self else { return }
                Logger.debug("🛠1. onNext - didBecomeActiveNotification: \(event)")
                self.didBecomeActive()
            })
            .disposed(by: rx.disposeBag)

        NotificationCenter.default.rx
            .notification(UIAccessibility.reduceMotionStatusDidChangeNotification)
            .subscribe(onNext: { event in
                Logger.debug("🛠1. onNext - Motion Status changed: \(event)")
            })
            .disposed(by: rx.disposeBag)

        /// Observe application did change language notification
        NotificationCenter.default.rx
            .notification(NSNotification.Name(LCLLanguageChangeNotification))
            .subscribe(onNext: {[weak self] event in
                guard let `self` = self else { return }
                Logger.debug("🛠1. onNext - LCLLanguageChangeNotification: \(event)")
                self.languageChanged.accept(())
            })
            .disposed(by: rx.disposeBag)
    }
    func basePrepareDebugGesture() {
        /// One finger swipe gesture for opening Flex
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleOneFingerSwipe(swipeRecognizer:)))
        swipeGesture.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(swipeGesture)

        /// Two finger swipe gesture for opening Flex and Hero debug
        let twoSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleTwoFingerSwipe(swipeRecognizer:)))
        twoSwipeGesture.numberOfTouchesRequired = 2
        self.view.addGestureRecognizer(twoSwipeGesture)
    }
    func basePrepareUI() {
        hero.isEnabled = true
        self.view.backgroundColor = UIColor.white
        navigationItem.backBarButtonItem = btnBack
        motionShakeEvent
            .subscribe(onNext: { _ in
                Logger.debug("🛠1. onNext - motionShakeEvent")
            })
            .disposed(by: rx.disposeBag)

        contentView.addSubview(contentStackView)
        self.view.addSubview(contentView)
        baseMasonry()
        updateUI()
    }

    func baseMasonry() {
        view.snp.setLabel("LXBaseVC.View")
        contentView.snp.setLabel("LXBaseVC.contentView")
        contentStackView.snp.setLabel("LXBaseVC.contentStackView")
        contentView.snp.makeConstraints {
            if #available(iOS 11.0, *) {
                $0.edges.equalTo(self.view.safeAreaLayoutGuide)
            } else {
                // Fallback on earlier versions
                $0.edges.equalToSuperview()
            }
        }
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - 🔐
private extension XLBaseVC {
    func emptyView(with height: CGFloat) -> UIView {
        let view = UIView()
        view.snp.makeConstraints {
            $0.height.equalTo(height)
        }
        return view
    }
}

// MARK: - 👀
extension Reactive where Base: XLBaseVC {
    var emptyDataSetImageTintColorBinder: Binder<UIColor?> {
        return Binder(self.base) { (view, attr) in
            view.emptyDataSet.imgTintColor.accept(attr)
        }
    }
}

// MARK: - ✈️DZNEmptyDataSetSource
extension XLBaseVC: DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let title = vm?.emptyDataSet.value?.title ?? ""
        return NSAttributedString(string: title)
    }
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let desc = vm?.emptyDataSet.value?.description ?? ""
        return NSAttributedString(string: desc)
    }
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return vm?.emptyDataSet.value?.img ?? R.image.empty_placeholde_image()
    }
    func imageTintColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return vm?.emptyDataSet.value?.imgTintColor.value ?? .blue
    }
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return .clear
    }
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -60
    }
}

// MARK: - ✈️DZNEmptyDataSetDelegate
extension XLBaseVC: DZNEmptyDataSetDelegate {
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return !isLoading.value
    }
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    func emptyDataSet(_ scrollView: UIScrollView!, didTap view: UIView!) {
        emptyDataSet.btnTap.onNext(())
    }
}
