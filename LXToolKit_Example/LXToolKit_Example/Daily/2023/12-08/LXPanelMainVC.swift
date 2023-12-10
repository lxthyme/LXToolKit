//
//  LXPanelMainVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/12/8.
//
import UIKit
import LXToolKit

class LXPanelMainVC: LXBaseVC {
    // MARK: 📌UI
    lazy var alertController: AlertVC = {
        let font = UIFont.boldSystemFont(ofSize: 18)
        let alertController = AlertVC(title: "Are you sure? ⚠️", body: "This action can't be undone!", titleFont: nil, bodyFont: nil, buttonFont: nil)
        let cancelAction = AlertAction(title: "NO, SORRY! 😱", style: .cancel) {
            dlog("CANCEL!!")
        }
        let okAction = AlertAction(title: "DO IT! 🤘", style: .destructive) {
            dlog("OK!!")
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        return alertController
    }()
    private lazy var btnShow: UIButton = {
        let btn = UIButton(type: .custom)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.contentEdgeInsets = UIEdgeInsets(horizontal: 5, vertical: 3)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8

        btn.setTitle("Show", for: .normal)

        let color: UIColor = .XL.randomGolden
        btn.setBackgroundColor(color: color, forState: .normal)
        btn.setBackgroundColor(color: color.withAlphaComponent(0.4), forState: .selected)

        btn.addAction(UIAction(handler: {[weak self] _ in
            self?.showPanelContentVC()
        }), for: .touchUpInside)
        return btn
    }()
    private lazy var btnPresentationType: UIButton = {
        let btn = UIButton(type: .custom)
        btn.contentEdgeInsets = UIEdgeInsets(horizontal: 5, vertical: 3)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8

        btn.setTitle("presentationType", for: .normal)

        let color: UIColor = .XL.randomGolden
        btn.setBackgroundColor(color: color, forState: .normal)
        btn.setBackgroundColor(color: color.withAlphaComponent(0.4), forState: .selected)

        let opt: UIMenu.Options
        if #available(iOS 15.0, *) {
            opt = .singleSelection
        } else {
            opt = .displayInline
        }
        btn.showsMenuAsPrimaryAction = true
        btn.menu = UIMenu(options: opt, children: [
            UIAction(title: ".alert", state: self.presentationType == .alert ? .on : .off, handler: {[weak self] _ in
                self?.presentationType = .alert
            }),
            UIAction(title: ".popup", state: self.presentationType == .popup ? .on : .off, handler: {[weak self] _ in
                self?.presentationType = .popup
            }),
            UIAction(title: ".topHalf", state: self.presentationType == .topHalf ? .on : .off, handler: {[weak self] _ in
                self?.presentationType = .topHalf
            }),
            UIAction(title: ".bottomHalf", state: self.presentationType == .bottomHalf ? .on : .off, handler: {[weak self] _ in
                self?.presentationType = .bottomHalf
            }),
            UIAction(title: "fullScreen", state: self.presentationType == .fullScreen ? .on : .off, handler: {[weak self] _ in
                self?.presentationType = .fullScreen
            }),
            UIAction(title: "dynamic(center: .bottomCenter)", state: self.presentationType == .dynamic(center: .bottomCenter) ? .on : .off, handler: {[weak self] _ in
                self?.presentationType = .dynamic(center: .bottomCenter)
            }),
            UIAction(title: ".custom(width: 300, height: 300, center: .bottomCenter)", state: self.presentationType == .custom(width: .custom(size: 300), height: .custom(size: 300), center: .bottomCenter) ? .on : .off, handler: {[weak self] _ in
                self?.presentationType = .custom(width: .custom(size: 300), height: .custom(size: 300), center: .bottomCenter)
            }),
        ])
        return btn
    }()
    private lazy var btnTransitionType: UIButton = {
        let btn = UIButton(type: .custom)
        btn.contentEdgeInsets = UIEdgeInsets(horizontal: 5, vertical: 3)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8

        btn.setTitle("transitionType", for: .normal)

        let color: UIColor = .XL.randomGolden
        btn.setBackgroundColor(color: color, forState: .normal)
        btn.setBackgroundColor(color: color.withAlphaComponent(0.4), forState: .selected)

        let opt: UIMenu.Options
        if #available(iOS 15.0, *) {
            opt = .singleSelection
        } else {
            opt = .displayInline
        }
        let flipHorizontalAnimation = FlipHorizontalAnimation()
        btn.showsMenuAsPrimaryAction = true
        btn.menu = UIMenu(options: opt, children: [
            UIAction(title: ".crossDissolve", state: self.transitionType == .crossDissolve ? .on : .off, handler: {[weak self] _ in
                self?.transitionType = .crossDissolve
            }),
            UIAction(title: ".coverVertical", state: self.transitionType == .coverVertical ? .on : .off, handler: {[weak self] _ in
                self?.transitionType = .coverVertical
            }),
            UIAction(title: ".coverVerticalFromTop", state: self.transitionType == .coverVerticalFromTop ? .on : .off, handler: {[weak self] _ in
                self?.transitionType = .coverVerticalFromTop
            }),
            UIAction(title: ".coverHorizontalFromRight", state: self.transitionType == .coverHorizontalFromRight ? .on : .off, handler: {[weak self] _ in
                self?.transitionType = .coverHorizontalFromRight
            }),
            UIAction(title: "coverHorizontalFromLeft", state: self.transitionType == .coverHorizontalFromLeft ? .on : .off, handler: {[weak self] _ in
                self?.transitionType = .coverHorizontalFromLeft
            }),
            UIAction(title: "flipHorizontal", state: self.transitionType == .flipHorizontal ? .on : .off, handler: {[weak self] _ in
                self?.transitionType = .flipHorizontal
            }),
            UIAction(title: ".coverFromCorner(.bottomRight)", state: self.transitionType == .coverFromCorner(.bottomRight) ? .on : .off, handler: {[weak self] _ in
                self?.transitionType = .coverFromCorner(.bottomRight)
            }),
            UIAction(title: ".custom(flipHorizontalAnimation)", state: self.transitionType == .custom(flipHorizontalAnimation) ? .on : .off, handler: {[weak self] _ in
                self?.transitionType = .custom(flipHorizontalAnimation)
            }),
        ])
        return btn
    }()
    private lazy var btnDismissTransitionType: UIButton = {
        let btn = UIButton(type: .custom)
        btn.contentEdgeInsets = UIEdgeInsets(horizontal: 5, vertical: 3)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8

        btn.setTitle("dismissTransitionType", for: .normal)

        let color: UIColor = .XL.randomGolden
        btn.setBackgroundColor(color: color, forState: .normal)
        btn.setBackgroundColor(color: color.withAlphaComponent(0.4), forState: .selected)

        let opt: UIMenu.Options
        if #available(iOS 15.0, *) {
            opt = .singleSelection
        } else {
            opt = .displayInline
        }
        let flipHorizontalAnimation = FlipHorizontalAnimation()
        btn.showsMenuAsPrimaryAction = true
        btn.menu = UIMenu(options: opt, children: [
            UIAction(title: ".crossDissolve", state: self.dismissTransitionType == .crossDissolve ? .on : .off, handler: {[weak self] _ in
                self?.dismissTransitionType = .crossDissolve
            }),
            UIAction(title: ".coverVertical", state: self.dismissTransitionType == .coverVertical ? .on : .off, handler: {[weak self] _ in
                self?.dismissTransitionType = .coverVertical
            }),
            UIAction(title: ".coverVerticalFromTop", state: self.dismissTransitionType == .coverVerticalFromTop ? .on : .off, handler: {[weak self] _ in
                self?.dismissTransitionType = .coverVerticalFromTop
            }),
            UIAction(title: ".coverHorizontalFromRight", state: self.dismissTransitionType == .coverHorizontalFromRight ? .on : .off, handler: {[weak self] _ in
                self?.dismissTransitionType = .coverHorizontalFromRight
            }),
            UIAction(title: "coverHorizontalFromLeft", state: self.dismissTransitionType == .coverHorizontalFromLeft ? .on : .off, handler: {[weak self] _ in
                self?.dismissTransitionType = .coverHorizontalFromLeft
            }),
            UIAction(title: "flipHorizontal", state: self.dismissTransitionType == .flipHorizontal ? .on : .off, handler: {[weak self] _ in
                self?.dismissTransitionType = .flipHorizontal
            }),
            UIAction(title: ".coverFromCorner(.bottomRight)", state: self.dismissTransitionType == .coverFromCorner(.bottomRight) ? .on : .off, handler: {[weak self] _ in
                self?.dismissTransitionType = .coverFromCorner(.bottomRight)
            }),
            UIAction(title: ".custom(flipHorizontalAnimation)", state: self.dismissTransitionType == .custom(flipHorizontalAnimation) ? .on : .off, handler: {[weak self] _ in
                self?.dismissTransitionType = .custom(flipHorizontalAnimation)
            }),
        ])
        return btn
    }()
    private lazy var btnDismissAnimated: UIButton = {
        let btn = UIButton(type: .custom)
        btn.contentEdgeInsets = UIEdgeInsets(horizontal: 5, vertical: 3)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8

        btn.setTitle("dismissAnimated", for: .normal)

        let color: UIColor = .XL.randomGolden
        btn.setBackgroundColor(color: color, forState: .normal)
        btn.setBackgroundColor(color: color.withAlphaComponent(0.4), forState: .selected)

        btn.showsMenuAsPrimaryAction = true
        btn.menu = UIMenu(children: [
            UIAction(title: "On", state: self.dismissAnimated ? .on : .off, handler: {[weak self] _ in
                self?.dismissAnimated = true
            }),
            UIAction(title: "Off", state: !self.dismissAnimated ? .on : .off, handler: {[weak self] _ in
                self?.dismissAnimated = false
            }),
        ])

        return btn
    }()
    private lazy var presentationTypeStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .horizontal
        v.alignment = .fill
        // sv.distribution = .fill
        return v
    }()
    private lazy var btnShowPresentr: UIButton = {
        let btn = UIButton(type: .custom)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.contentEdgeInsets = UIEdgeInsets(horizontal: 5, vertical: 3)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8

        btn.setTitle("Show Presentr", for: .normal)

        let color: UIColor = .XL.randomGolden
        btn.setBackgroundColor(color: color, forState: .normal)
        btn.setBackgroundColor(color: color.withAlphaComponent(0.4), forState: .selected)

        btn.addAction(UIAction(handler: {[weak self] _ in
            // self?.showPanelContentVC()
            self?.showPresentr()
        }), for: .touchUpInside)
        return btn
    }()
    // MARK: 🔗Vaiables
    let presenter: Presenter = {
        let presenter = Presenter(presentationType: .alert)
        presenter.transitionType = TransitionType.coverHorizontalFromRight
        presenter.dismissOnSwipe = true
        return presenter
    }()
    let transition = LXModalTransition()
    private var presentationType: PresentationType = .topHalf //{
    //     didSet {
    //         btnPresentationType.setTitle("\(presentationType)", for: .normal)
    //     }
    // }
    private var transitionType: TransitionType? = nil //{
    //     didSet {
    //         btnTransitionType.setTitle("\(transitionType)", for: .normal)
    //     }
    // }
    private var dismissTransitionType: TransitionType? = nil //{
    //     didSet {
    //         btnDismissTransitionType.setTitle("\(dismissTransitionType)", for: .normal)
    //     }
    // }
    private var dismissAnimated = true //{
    //     didSet {
    //         btnDismissAnimated.setTitle("dismissAnimated: \(dismissAnimated)", for: .normal)
    //     }
    // }
    // MARK: 🛠Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)

        // showPanelContentVC()
        showPresentr()
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
    }

}

// MARK: 🌎LoadData
extension LXPanelMainVC {
    func dataFill() {}
}

// MARK: 👀Public Actions
extension LXPanelMainVC {}

// MARK: 🔐Private Actions
private extension LXPanelMainVC {
    func showPanelContentVC() {
        let vc = LXPanelContentVC()
        vc.transitioningDelegate = transition
        // self.view.addSubview(vc.view)
        // self.addChild(vc)

        // vc.view.frame = self.view.bounds
        transition.interactiveTransition.transitionToVC(toVC: vc)
        self.present(vc, animated: true)
    }
    func showPresentr() {
        presenter.presentationType = presentationType
        presenter.transitionType = transitionType
        presenter.dismissTransitionType = dismissTransitionType
        presenter.dismissAnimated = dismissAnimated

        presenter.presentVC(presentingVC: self, presentedVC: alertController, animated: true)
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXPanelMainVC {
    func prepareUI() {
        self.view.backgroundColor = .XL.randomGolden
        // navigationItem.title = ""

        contentStackView.spacing = 10
        [btnPresentationType, btnTransitionType, btnDismissTransitionType, btnDismissAnimated].forEach(presentationTypeStackView.addArrangedSubview)
        [presentationTypeStackView, btnShowPresentr, btnShow].forEach(contentStackView.addArrangedSubview)

        masonry()
    }

    func masonry() {
        contentStackView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(self.view.snp.bottomMargin)
        }
        presentationTypeStackView.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        btnShow.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        btnShowPresentr.snp.makeConstraints {
            $0.height.equalTo(40)
        }
    }
}
