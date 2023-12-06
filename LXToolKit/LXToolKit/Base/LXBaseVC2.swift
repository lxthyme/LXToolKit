//
//  LXBaseVC.swift
//  test
//
//  Created by lxthyme on 2023/3/23.
//
import UIKit
import Hero
import SVProgressHUD
import DZNEmptyDataSet
import RswiftResources
import RxSwift
import RxRelay
import Localize_Swift

// struct LXEmptyDataSet {
//     var title: String? = R.string.localizable.commonNoResults()// {
//     //     didSet {
//     //         titleAttributeString = nil
//     //     }
//     // }
//     var titleAttributeString: NSAttributedString? = NSAttributedString(string: R.string.localizable.commonNoResults())// {
//     //     didSet {
//     //         title = nil
//     //     }
//     // }
//     var description: String?// {
//     //     didSet {
//     //         descriptionAttributeString = nil
//     //     }
//     // }
//     var descriptionAttributeString: NSAttributedString?// {
//     //     didSet {
//     //         description = nil
//     //     }
//     // }
//     var image: UIImage? = R.image.image_no_result()
//     var imageTintColor = BehaviorRelay<UIColor?>(value: nil)
//     let btnTapAction = PublishSubject<Void>()
//     var backgroundColor: UIColor = .clear
//     var verticalOffset: CGFloat = -60
//     var allowScroll = true
// }

@objc(LXBaseVC_KitEx)
open class LXBaseVC2: UIViewController, Navigatable {
    // MARK: 📌UI
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = ""//R.string.localizable.commonSearch()
        sb.isTranslucent = false
        sb.searchBarStyle = .minimal

        // theme.tintColor = themeService.attribute { $0.secondary }
        // theme.barTintColor = themeService.attribute { $0.primaryDark }

        if let tf = sb.textField {
            // tf.theme.textColor = themeService.attribute { $0.text }
            // tf.theme.keyboardAppearance = themeService.attribute { $0.keyboardAppearance }
        }
        sb.rx.textDidBeginEditing.asObservable().subscribe(onNext: { [weak self] () in
            sb.setShowsCancelButton(true, animated: true)
        }).disposed(by: rx.disposeBag)

        sb.rx.textDidEndEditing.asObservable().subscribe(onNext: { [weak self] () in
            sb.setShowsCancelButton(false, animated: true)
        }).disposed(by: rx.disposeBag)

        sb.rx.cancelButtonClicked.asObservable().subscribe(onNext: { [weak self] () in
            sb.resignFirstResponder()
        }).disposed(by: rx.disposeBag)

        sb.rx.searchButtonClicked.asObservable().subscribe(onNext: { [weak self] () in
            sb.resignFirstResponder()
        }).disposed(by: rx.disposeBag)
        return sb
    }()
    lazy var backBarButton: UIBarButtonItem = {
        let item = UIBarButtonItem()
        item.title = ""
        return item
    }()
    lazy var closeBarButton: UIBarButtonItem = {
        let item = UIBarButtonItem(image: nil,//R.image.icon_navigation_close(),
                                   style: .plain,
                                   target: self,
                                   action: nil)
        return item
    }()
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.spacing = 0
        return stackView
    }()
    // MARK: 🔗Vaiables
    public var navigator: Navigator = .default
    var vm: LXBaseVM?

    let isLoading = BehaviorRelay(value: false)
    let error = PublishSubject<Error>()

    var automaticallyAdjustsLeftBarButtonItem = true
    var canOpenFlex = true

    var navigationTitle: String = "" {
        didSet {
            navigationItem.title = navigationTitle
        }
    }

    let spaceBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

    // let emptySetButtonTap = PublishSubject<Void>()
    // var emptySetTitle = R.string.localizable.commonNoResults.key.localized()
    // var emptyDataSetDescription = ""
    // var emptyDataSetImage = R.image.image_no_result()
    // var emptyDataSetImageTintColor = BehaviorRelay<UIColor?>(value: nil)
    var emptyDataSet = LXEmptyDataSet()

    let languageChanged = BehaviorRelay<Void>(value: ())

    let orientationEvent = PublishSubject<Void>()
    let motionShakeEvent = PublishSubject<Void>()


    // MARK: 🛠Life Cycle
    deinit {
        LogKit.traceLifeCycle(.vc, typeName: xl.typeNameString, type: .deinit)
        LogKit.resourcesCount()
    }
    public convenience init(vm: LXBaseVM?, navigator: Navigator) {
        self.init(nibName: nil, bundle: nil)
        self.navigator = navigator
        self.vm = vm
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if automaticallyAdjustsLeftBarButtonItem {
            adjustLeftBarButtonItem()
        }
    }
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        LogKit.resourcesCount()
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
        basePrepareVM()
        basePrepareGesture()
        basePrepareNotification()
        basePrepareUI()
        baseMasonry()
    }
    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        LogKit.traceLifeCycle(.vc, typeName: xl.typeNameString, type: .didReceiveMemoryWarning)
    }
    @objc public func updateUI() {}
}

public extension LXBaseVC2 {
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            motionShakeEvent.onNext(())
        }
    }
}

// MARK: 🌎LoadData
public extension LXBaseVC2 {
    @objc func bindViewModel() {
        vm?.loading.asObservable()
            .bind(to: isLoading)
            .disposed(by: rx.disposeBag)
        vm?.parsedError.asObservable()
            .bind(to: error)
            .disposed(by: rx.disposeBag)
        languageChanged.subscribe(onNext: { [weak self] () in
            // self?.emptyDataSet.title = R.string.localizable.commonNoResults()
        })
            .disposed(by: rx.disposeBag)

        isLoading.subscribe(onNext: { isLoading in
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        })
            .disposed(by: rx.disposeBag)
    }
}

// MARK: 👀Public Actions
extension LXBaseVC2 {
    func startAnimating() {
        SVProgressHUD.show()
    }
    func stopAnimating() {
        SVProgressHUD.dismiss()
    }
}

// MARK: 🔐Private Actions
private extension LXBaseVC2 {
    func adjustLeftBarButtonItem() {
        if self.navigationController?.viewControllers.count ?? 0 > 1 { // Pushed
            self.navigationItem.leftBarButtonItem = nil
        } else if self.presentingViewController != nil { // Presented
            self.navigationItem.leftBarButtonItem = closeBarButton
        }
    }
}

// MARK: - 🔐Notification Action
private extension LXBaseVC2 {
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
private extension LXBaseVC2 {
    @objc func handleOneFingerSwipe(swipeRecognizer: UISwipeGestureRecognizer) {
        if swipeRecognizer.state == .recognized, canOpenFlex {
            // LibsManager.shared.showFlex()
        }
    }
    @objc func handleTwoFingerSwipe(swipeRecognizer: UISwipeGestureRecognizer) {
        if swipeRecognizer.state == .recognized {
            // LibsManager.shared.showFlex()
            HeroDebugPlugin.isEnabled = !HeroDebugPlugin.isEnabled
        }
    }
}
// MARK: - ✈️DZNEmptyDataSetSource
extension LXBaseVC2: DZNEmptyDataSetSource {
    public func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        if let attr = emptyDataSet.titleAttributeString {
            return attr
        } else if let title = emptyDataSet.title {
            return NSAttributedString(string: title)
        }
        return nil
    }
    public func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        if let attr = emptyDataSet.descriptionAttributeString {
            return attr
        } else if let description = emptyDataSet.description {
            return NSAttributedString(string: description)
        }
        return nil
    }
    public func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return emptyDataSet.image
    }
    public func imageTintColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return emptyDataSet.imageTintColor.value
    }
    public func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return emptyDataSet.backgroundColor
    }
    public func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return emptyDataSet.verticalOffset
    }
}

// MARK: - ✈️DZNEmptyDataSetDelegate
extension LXBaseVC2: DZNEmptyDataSetDelegate {
    public func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return !isLoading.value
    }
    public func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return emptyDataSet.allowScroll
    }
    public func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        emptyDataSet.btnTapAction.onNext(())
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXBaseVC2 {
    func basePrepareNotification() {
        // Observe device orientation change
        NotificationCenter.default.rx
            .notification(UIDevice.orientationDidChangeNotification)
            .mapToVoid()
            .bind(to: orientationEvent)
            .disposed(by: rx.disposeBag)
        // Observe application did become active notification
        NotificationCenter.default.rx
            .notification(UIApplication.didBecomeActiveNotification)
            .subscribe { [weak self] notification in
                self?.didBecomeActive()
            }
            .disposed(by: rx.disposeBag)
        NotificationCenter.default.rx
            .notification(UIAccessibility.reduceMotionStatusDidChangeNotification)
            .subscribe { notification in
                LogKit.kitLog("Motion Status changed")
            }
            .disposed(by: rx.disposeBag)
        NotificationCenter.default.rx
            .notification(Notification.Name(LCLLanguageChangeNotification))
            .subscribe { [weak self] notification in
                self?.languageChanged.accept(())
            }
            .disposed(by: rx.disposeBag)
        orientationEvent
            .subscribe(onNext:  { [weak self] () in
                self?.orientationChanged()
            })
            .disposed(by: rx.disposeBag)
    }
    func basePrepareGesture() {
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
                // let theme = themeService.type.toggled()
                // themeService.switch(theme)
                LogKit.logRxSwift(.onNext, items: "🛠1. onNext: \(event)")
            })
            .disposed(by: rx.disposeBag)
    }
    func basePrepareVM() {
        closeBarButton.rx.tap.asObservable()
            .subscribe(onNext:  { [weak self] () in
                self?.navigator.dismiss(sender: self)
            })
            .disposed(by: rx.disposeBag)
    }
    func basePrepareUI() {
        self.view.backgroundColor = .white
        hero.isEnabled = true
        navigationItem.backBarButtonItem = backBarButton

        // view.theme.backgroundColor = themeService.attribute { $0.primaryDark }
        // backBarButton.theme.tintColor = themeService.attribute { $0.secondary }
        // closeBarButton.theme.tintColor = themeService.attribute { $0.secondary }
        // theme.emptyDataSetImageTintColorBinder = themeService.attribute { $0.text }

        self.view.addSubview(contentView)
        self.contentView.addSubview(contentStackView)
    }
    func baseMasonry() {
        contentView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

public extension LXBaseVC2 {
    var xl_inset: CGFloat {
        // return AppConfig.BaseDimensions.inset
        return 6
    }
    func xl_emptyView(withHeight height: CGFloat) -> UIView {
        let view = UIView()
        view.snp.makeConstraints {
            $0.height.equalTo(height)
        }
        return view
    }
}
