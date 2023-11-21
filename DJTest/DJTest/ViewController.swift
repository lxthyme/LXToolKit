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

extension DJTestType {
    var vc: UIViewController? {
        switch self {
            // case .LXToolKit:
            //     return LXToolKitTestVC()
        case .LXToolKit_Example:
            return LXToolKitTestVC()
            // case .LXToolKitObjC:
            //     return LXToolKitTestVC()
        case .LXToolKitObjC_Example:
            return LXToolKitObjCTestSwiftVC()
        case .DJSwiftModule:
            let window = UIApplication.xl.keyWindow
            Application.shared.presentInitialScreen(in: window)
        case .dynamicIsland:
            return if #available(iOS 16.2, *) {
                UIHostingController(rootView: EmojiRangersView())
            } else {
                // Fallback on earlier versions
                UIViewController()
            }
        case .djTest(_, let vc, _):
            return vc()
        }
        return nil
    }

}

class ViewController: LXBaseVC {
    // MARK: 📌UI
    private lazy var btnGo: UIButton = {
        let btn = UIButton(type: .custom)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8

        btn.setTitle("Go", for: .normal)
        btn.setTitleColor(.black, for: .normal)

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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - 🔐
private extension ViewController {
    func goOutlineVC() {
        let vc = LXOutlineVC()
        self.navigationController?.pushViewController(vc)
    }
}

// MARK: - 🍺UI Prepare & Masonry
extension ViewController {
    override func prepareVM() {
        super.prepareVM()
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
        [btnGo].forEach(self.view.addSubview)
        masonry()
    }
    override func masonry() {
        super.masonry()
        btnGo.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
