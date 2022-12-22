//
//  LXBaseVC.swift
//  SwiftPro
//
//  Created by DamonJow on 2018/10/26.
//  Copyright © 2018 DamonJow. All rights reserved.
//

import UIKit
import RswiftResources
import SnapKit
import Hero
import Localize_Swift
import SVProgressHUD

open class LXBaseVC: UIViewController {
    deinit {
        dlog("---------- >>>VC: \(self.xl.xl_typeName)\t\tdeinit <<<----------")
    }
    // MARK: 📌UI
    public lazy var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    open lazy var contentStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        return v
    }()
    public lazy var btnBack: UIBarButtonItem = {
        let view = UIBarButtonItem()
        view.title = ""
        return view
    }()
    public lazy var btnClosed: UIBarButtonItem = {
        // TODO:「lxthyme」💊<#extra#>
        // let btn = UIBarButtonItem(image: R.image.icon_navigation_close(),
        let btn = UIBarButtonItem(image: nil,
                                  style: .plain,
                                  target: self,
                                  action: nil)
        return btn
    }()
    // MARK: - lazy vars
    public var automaticallyAdjustsLeftBarButtonItem = true
    public var canOpenFlex = true
    public var navigationTitle = "" {
        didSet {
            navigationItem.title = navigationTitle
        }
    }
    // MARK: - Life Cycle
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if automaticallyAdjustsLeftBarButtonItem {
            adjustLeftBarButtonItem()
        }
        updateUI()
    }
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUI()
    }
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override open func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // TODO:「lxthyme」💊<#extra#>
        // logDebug("\(type(of: self)): Received Memory Warning")
    }

    open func updateUI() {}
}

//extension LXBaseVC {
//    override open func value(forUndefinedKey key: String) -> Any? {
//        dlog("-->value:forUndefinedKey:::: \(key))")
//        return nil
//    }
//    override open func setValue(_ value: Any?, forUndefinedKey key: String) {
//        super.setValue(value, forUndefinedKey: key)
//
//        dlog("-->setValue:forUndefinedKey:::: (\(key): \(value ?? ""))")
//    }
//}

// MARK: - 👀Public Actions
public extension LXBaseVC {}

// MARK: - 🔐Private Actions
private extension LXBaseVC {
    func btnClosedAction(sender: UIButton) {
        // TODO:「lxthyme」💊<#extra#>
        // Logger.debug("🛠1. onNext - btnClosed - tap: ")
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: 🔐Adjusting Navigation Item
private extension LXBaseVC {
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

// MARK: - 🍺UI Prepare & Masonry
private extension LXBaseVC {
    func prepareUI() {
        self.edgesForExtendedLayout = []
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
            // tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        if #available(iOS 15.0, *) {
            if let presentationController = presentationController as? UISheetPresentationController {
                // 显示时支持的尺寸
                presentationController.detents = [.large(), .medium()]
                // 显示一个指示器表示可以拖拽调整大小
                presentationController.prefersGrabberVisible = true
            }
        }

        self.view.backgroundColor = .white
        hero.isEnabled = true
        navigationItem.backBarButtonItem = btnBack

        [self.contentView].forEach(self.view.addSubview)
        [self.contentStackView].forEach(self.contentView.addSubview)
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
