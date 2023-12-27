//
//  ViewController.swift
//  DJTest
//
//  Created by lxthyme on 2023/9/19.
//

import UIKit
import SwiftUI
import LXToolKit_Example
import LXToolKitObjC_Example
import ActivityKit
import DJTestKit

class ViewController: LXBaseVC {
    // MARK: 📌UI
    private lazy var tvContent: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.textColor = .black
        tv.backgroundColor = .Material.lightBlueA100
        tv.textAlignment = .left
        tv.returnKeyType = .done
        tv.keyboardType = .default
        // tv.textContainer.maximumNumberOfLines = 0
        // tv.textContainer.lineBreakMode = .byTruncatingTail
        // tv.contentInset = .zero
        // let padding = tv.textContainer.lineFragmentPadding
        // tv.textContainerInset = UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        return tv
    }()
    private lazy var btnReset: UIButton = {
        let btn = UIButton(type: .custom)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.contentEdgeInsets = UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)
        btn.backgroundColor = .External.Material.cyan200
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8

        btn.setTitle("Reset Defaults", for: .normal)
        btn.setBackgroundColor(color: .cyan, forState: .normal)
        btn.setBackgroundColor(color: .cyan.withAlphaComponent(0.5), forState: .highlighted)

        return btn
    }()
    private lazy var btnGo: UIButton = {
        let btn = UIButton(type: .custom)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.contentEdgeInsets = UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)
        btn.backgroundColor = .External.Material.cyan200
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8

        btn.setTitle("Go", for: .normal)
        btn.setBackgroundColor(color: .cyan, forState: .normal)
        btn.setBackgroundColor(color: .cyan.withAlphaComponent(0.5), forState: .highlighted)

        return btn
    }()
    private lazy var btnResourcesCount: UIButton = {
        let btn = UIButton(type: .custom)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8

        btn.setTitle("RxSwift resourcesCount", for: .normal)
        btn.setBackgroundColor(color: .cyan, forState: .normal)
        btn.setBackgroundColor(color: .cyan.withAlphaComponent(0.5), forState: .highlighted)

        return btn
    }()
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        dataFill()
        refreshResourcesCount()
        testReadInfoKey()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        prepareVM()
        prepareUI()

        // goOutlineVC()

        startActivity()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: 🌎LoadData
extension ViewController {
    func dataFill() {
        let CFBundleVersion: String? = try? LXMacro.InfoPlistKey[.CFBundleVersion]
        let CFBundleShortVersionString: String? = try? LXMacro.InfoPlistKey[.CFBundleShortVersionString]
        tvContent.text = """
        Version: \(CFBundleVersion ?? "")(\(CFBundleShortVersionString ?? "''"))
        AutoJumpRoute: \(DJTestType.AutoJumpRouteRouter)
        LXToolKit_Example: \(DJTestType.LXToolKit_Example.userRouter)
        LXToolKitObjC_Example: \(DJTestType.LXToolKitObjC_Example.userRouter)
        DJSwiftModule: \(DJTestType.DJSwiftModule.userRouter)
        dynamicIsland: \(DJTestType.dynamicIsland.userRouter)
        djTest: \(DJTestType.djTest.userRouter)
        """
    }
}

// MARK: - 🔐
private extension ViewController {
    func goOutlineVC() {
        if #available(iOS 14.0, *) {
        let vc = LXOutlineVC()
        self.navigationController?.pushViewController(vc)
        }
    }
    func refreshResourcesCount() {
        let total = LogKit.resourcesCount()
        btnResourcesCount.setTitle("RxSwift resourcesCount: \(total)", for: .normal)
    }
    func testReadInfoKey() {
        let v: String? = try? LXMacro.InfoPlistKey[.CFBundleIdentifier]
        dlog("v: \(v ?? "")")
    }
}

// MARK: - 🔐Activity
private extension ViewController {
    func startActivity() {
        // guard ActivityAuthorizationInfo().areActivitiesEnabled else {
        //     dlog("灵动岛没有权限")
        //     return
        // }
        // let attr = LXToolKit_WidgetAttributes(name: "")
        // let initialContentState = LXToolKit_WidgetAttributes.ContentState(emoji: "100")
        // do {
        //     let myActivity = try Activity<LXToolKit_WidgetAttributes>.request(attributes: attr,
        //                                                                       content: .init(state: initialContentState, staleDate: nil),
        //                                                                       pushType: nil)
        //     dlog("-->灵动岛: \(myActivity.id)")
        //     self.setup
        // } catch (let error) {
        //     dlog("-->灵动岛开启时发生错误: \(error)")
        // }
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension ViewController {
    func prepareVM() {
        btnReset.rx.controlEvent(.touchUpInside)
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe {[weak self] _ in
                DJTestType.clearAllData()
                self?.dataFill()
            }
            .disposed(by: rx.disposeBag)
        btnGo.rx.controlEvent(.touchUpInside)
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe {[weak self] _ in
                self?.goOutlineVC()
            }
            .disposed(by: rx.disposeBag)
        btnResourcesCount.rx.controlEvent(.touchUpInside)
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe {[weak self] _ in
                self?.refreshResourcesCount()
                self?.testReadInfoKey()
            }
            .disposed(by: rx.disposeBag)
    }
    func prepareUI() {
        self.view.backgroundColor = .white;
        contentStackView.spacing = 10
        [btnGo, btnReset, btnResourcesCount, tvContent].forEach(contentStackView.addArrangedSubview)
        masonry()
    }
    func masonry() {
        contentStackView.snp.remakeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.bottom.equalTo(self.view.snp.bottomMargin).offset(-10)
        }
        btnGo.snp.makeConstraints {
            // $0.center.equalToSuperview()
            // $0.width.equalTo(80)
            $0.height.equalTo(40)
        }
        btnReset.snp.makeConstraints {
            // $0.top.equalTo(btnGo.snp.bottom).offset(10)
            // $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
        }
        btnResourcesCount.snp.makeConstraints {
            // $0.center.equalToSuperview()
            // $0.width.greaterThanOrEqualTo(80)
            $0.height.equalTo(40)
        }
        // tvContent.snp.makeConstraints {
        //     $0.top.equalTo(btnReset.snp.bottom).offset(10)
        //     $0.left.equalToSuperview().offset(10)
        //     $0.right.equalToSuperview().offset(-10)
        // }
    }
}
