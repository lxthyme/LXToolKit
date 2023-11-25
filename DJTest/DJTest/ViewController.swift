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

        // btn.addTarget(self, action: #selector(<#btnAction(sender:)#>), for: .touchUpInside)
        // @objc func <#btnAction#>(sender: UIButton) {}
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

        // btn.addTarget(self, action: #selector(<#btnAction(sender:)#>), for: .touchUpInside)
        // @objc func <#btnAction#>(sender: UIButton) {}
        return btn
    }()
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        prepareVM()
        prepareUI()
        
        goOutlineVC()

        startActivity()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
extension ViewController {
    override func prepareVM() {
        super.prepareVM()
        btnReset.rx.controlEvent(.touchUpInside)
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe { _ in
                DJTestType.clearAllData()
            }
            .disposed(by: rx.disposeBag)
        btnGo.rx.controlEvent(.touchUpInside)
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe {[weak self] _ in
                self?.goOutlineVC()
            }
            .disposed(by: rx.disposeBag)
    }
    override func prepareUI() {
        super.prepareUI()
        self.view.backgroundColor = .white;
        [btnGo, btnReset].forEach(self.view.addSubview)
        masonry()
    }
    override func masonry() {
        super.masonry()
        btnGo.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(80)
            $0.height.equalTo(40)
        }
        btnReset.snp.makeConstraints {
            $0.top.equalTo(btnGo.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
}
