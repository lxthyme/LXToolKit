//
//  LXSingleVC.swift
//  DJTest
//
//  Created by lxthyme on 2023/12/26.
//
import UIKit
import LXToolKit
import Flutter

class LXSingleVC: LXBaseFlutterVC {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    private var count = 0
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LXSingleVC {}

// MARK: 👀Public Actions
extension LXSingleVC {
    func onCountUpdate(newCount: Int) {
        if let channel {
            channel.invokeMethod("setCount", arguments: newCount)
        }
    }
}

// MARK: 🔐Private Actions
private extension LXSingleVC {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXSingleVC {
    func prepareFlutter() {
        channel?.invokeMethod("setCount", arguments: DataModel.shared.count)
        channel?.setMethodCallHandler {[weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            guard let self else { return }
            dlog("-->[Flutter]call: \(call.method)-\(call.arguments)")
            if call.method == "incrementCount" {
                self.count += 1
                result(true)
            } else if call.method == "next" {
                let nativeVC = UIViewController()
                self.navigationController?.pushViewController(nativeVC, animated: true)
                result(nil)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
    }
    func prepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        // [<#table#>].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {}
}
