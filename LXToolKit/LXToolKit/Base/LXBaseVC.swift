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
import NSObject_Rx
import Localize_Swift

public struct LXEmptyDataSet {
    public var title: String?// = R.string.localizable.commonNoResults()// {
    //     didSet {
    //         titleAttributeString = nil
    //     }
    // }
    public var titleAttributeString: NSAttributedString?// = NSAttributedString(string: R.string.localizable.commonNoResults())// {
    //     didSet {
    //         title = nil
    //     }
    // }
    public var description: String?// {
    //     didSet {
    //         descriptionAttributeString = nil
    //     }
    // }
    public var descriptionAttributeString: NSAttributedString?// {
    //     didSet {
    //         description = nil
    //     }
    // }
    public var image: UIImage?// = R.image.image_no_result()
    public var imageTintColor = BehaviorRelay<UIColor?>(value: nil)
    public let btnTapAction = PublishSubject<Void>()
    public var backgroundColor: UIColor = .clear
    public var verticalOffset: CGFloat = -60
    public var allowScroll = true
}

@objc(LXBaseSwiftVC)
open class LXBaseVC: LXBaseDeinitVC, Navigatable {
    // MARK: 📌UI
    public lazy var searchBar: UISearchBar = {
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
    public lazy var backBarButton: UIBarButtonItem = {
        let item = UIBarButtonItem()
        item.title = ""
        return item
    }()
    public lazy var closeBarButton: UIBarButtonItem = {
        let item = UIBarButtonItem(image: nil,//R.image.icon_navigation_close(),
                                   style: .plain,
                                   target: self,
                                   action: nil)
        return item
    }()
    public lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    public lazy var contentStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        return sv
    }()
    // MARK: 🔗Vaiables
    public var navigator: Navigator = .default
    public var vm: LXBaseVM?

    public let isLoading = BehaviorRelay(value: false)
    public let error = PublishSubject<Error>()

    public var automaticallyAdjustsLeftBarButtonItem = true
    public var canOpenFlex = true

    public var navigationTitle: String = "" {
        didSet {
            navigationItem.title = navigationTitle
        }
    }

    public let spaceBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

    // let emptySetButtonTap = PublishSubject<Void>()
    // var emptySetTitle = R.string.localizable.commonNoResults.key.localized()
    // var emptyDataSetDescription = ""
    // var emptyDataSetImage = R.image.image_no_result()
    // var emptyDataSetImageTintColor = BehaviorRelay<UIColor?>(value: nil)
    public var emptyDataSet = LXEmptyDataSet()

    public let languageChanged = BehaviorRelay<Void>(value: ())

    public let orientationEvent = PublishSubject<Void>()
    public let motionShakeEvent = PublishSubject<Void>()


    // MARK: 🛠Life Cycle
    // public required init?(coder: NSCoder) {
    //     fatalError("init(coder:) has not been implemented")
    // }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    public required init(vm: LXBaseVM?, navigator: Navigator) {
        // self.init(nibName: nil, bundle: nil)
        super.init(nibName: nil, bundle: nil)
        self.navigator = navigator
        self.vm = vm
        // super.init(nibName: nil, bundle: nil)
        // self.init(vm: <#T##LXBaseVM?#>, navigator: <#T##Navigator#>)
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if automaticallyAdjustsLeftBarButtonItem {
            adjustLeftBarButtonItem()
        }
    }
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

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

public extension LXBaseVC {
    // @objc open
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            motionShakeEvent.onNext(())
        }
    }
}

// MARK: 🌎LoadData
extension LXBaseVC {
    @objc open func bindViewModel() {
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
            if isLoading {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss(withDelay: 0.2)
            }
        })
        .disposed(by: rx.disposeBag)

        error
            .subscribe {[weak self] error in
                guard let self else { return }
                LogKit.logRxSwift(.onSubscribe, items: "-->error[\(self.xl.typeNameString)]: \(error)")
        }
        .disposed(by: rx.disposeBag)
    }
}

// MARK: 👀Public Actions
extension LXBaseVC {
    func startAnimating() {
        SVProgressHUD.show()
    }
    func stopAnimating() {
        SVProgressHUD.dismiss()
    }
}

// MARK: 🔐Private Actions
private extension LXBaseVC {
    func adjustLeftBarButtonItem() {
        if self.navigationController?.viewControllers.count ?? 0 > 1 { // Pushed
            self.navigationItem.leftBarButtonItem = nil
        } else if self.presentingViewController != nil { // Presented
            self.navigationItem.leftBarButtonItem = closeBarButton
        }
    }
}

// MARK: - 🔐Actions
private extension LXBaseVC {
    func orientationChanged() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.updateUI()
        }
    }
    func didBecomeActive() {
        self.updateUI()
    }
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
extension LXBaseVC: DZNEmptyDataSetSource {
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
extension LXBaseVC: DZNEmptyDataSetDelegate {
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

extension LXBaseVC {
    public var inset: CGFloat {
        // return AppConfig.BaseDimensions.inset
        return 6
    }
    func emptyView(withHeight height: CGFloat) -> UIView {
        let view = UIView()
        view.snp.makeConstraints {
            $0.height.equalTo(height)
        }
        return view
    }
}
// MARK: - 🍺UI Prepare & Masonry
private extension LXBaseVC {
    func basePrepareNotification() {
        NotificationCenter.default.rx
            .notification(UIDevice.orientationDidChangeNotification)
            .mapToVoid()
            .bind(to: orientationEvent)
            .disposed(by: rx.disposeBag)
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
    func basePrepareVM() {
        closeBarButton.rx.tap.asObservable()
            .subscribe(onNext:  { [weak self] () in
                self?.navigator.dismiss(sender: self)
            })
            .disposed(by: rx.disposeBag)

        motionShakeEvent
            .subscribe(onNext: { () in
                // let theme = themeService.type.toggled()
                // themeService.switch(theme)
            })
            .disposed(by: rx.disposeBag)

        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleOneFingerSwipe(swipeRecognizer:)))
        swipeGesture.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(swipeGesture)

        let twoSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleTwoFingerSwipe(swipeRecognizer:)))
        twoSwipeGesture.numberOfTouchesRequired = 2
        self.view.addGestureRecognizer(twoSwipeGesture)
    }
    func basePrepareUI() {
        self.view.backgroundColor = .white
        // hero.isEnabled = true
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
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}
