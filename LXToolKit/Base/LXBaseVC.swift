//
//  LXBaseVC.swift
//  SwiftPro
//
//  Created by DamonJow on 2018/10/26.
//  Copyright © 2018 DamonJow. All rights reserved.
//

import UIKit

open class LXBaseVC: UIViewController {
    deinit {
        dlog("---------- >>>VC: \(self.xl.xl_typeName)\t\tdeinit <<<----------")
    }
    // MARK: - lazy vars
//    lazy var dataList: [Any] = {
//        let ds = Array(repeating: "", count: 20)
//        return ds
//    }()
    // MARK: - initialize
//    required public init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        dlog("---------- \(self.xl_typeName).Xib\t\tinit ----------")
//    }
//    public init() {
//        super.init(nibName: nil, bundle: nil)
//    }
    // MARK: - Life Cycle
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override open func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
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

// MARK: - 🍺UI Prepare & Masonry
private extension LXBaseVC {
    func prepareUI() {
        self.edgesForExtendedLayout = []
        self.automaticallyAdjustsScrollViewInsets = true
        if #available(iOS 11.0, *) {
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
    }
    func masonry() {}
}
