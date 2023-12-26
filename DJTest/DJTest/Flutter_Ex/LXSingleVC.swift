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
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
        prepareFlutter()

        DataModel.shared.rx
            .observe(\.count)
            .subscribe {[weak self] result in
                dlog("-->result[1]: \(result)")
                switch result {
                case .next(let count):
                    self?.onCountUpdate(newCount: count)
                default: break
                }
            }
            .disposed(by: rx.disposeBag)
        DataModel.shared.countChangedBlock = {[weak self] count in
            dlog("-->result[2]: \(count)")
            self?.onCountUpdate(newCount: count)
        }
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
                let count = DataModel.shared.increament()
                result(nil)
            } else if call.method == "next" {
                let nativeVC = LXHostVC()
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
