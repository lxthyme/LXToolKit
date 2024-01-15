//
//  LXSingleVC.swift
//  DJTest
//
//  Created by lxthyme on 2023/12/26.
//
import UIKit
import LXToolKit
import Flutter
import LXFlutterKit

class LXSingleVC: LXFlutterVC {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
        prepareFlutter()

        DataModel.shared.count
            .filter {[weak self] _ in
                return self?.isVisible ?? false
            }
            .subscribe {[weak self] result in
                dlog("-->result[SingleVC]: \(result)")
                switch result {
                case .next(let count):
                    self?.onCountUpdate(newCount: count)
                default: break
                }
            }
            .disposed(by: rx.disposeBag)
    }

}

// MARK: 🌎LoadData
extension LXSingleVC {}

// MARK: 👀Public Actions
extension LXSingleVC {
    func onCountUpdate(newCount: Int) {
        // if let channel = entrypoint.channel.channel {
            self.channel.methodChannel?.xl_invokeMethod(method: LXFlutterMethod.MultiCounterFlutterScene.setCount, with: newCount)
        // }
    }
}

// MARK: 🔐Private Actions
private extension LXSingleVC {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXSingleVC {
    func prepareFlutter() {
        self.channel.methodChannel?.xl_invokeMethod(method: LXFlutterMethod.MultiCounterFlutterScene.setCount, with: DataModel.shared.count.value)
        self.channel.registerMultiCounterMethodChannel()

        channel.extraChannelName = [.default]
        channel.tryRegisterExtraDefaultMethodChannel()
    }
    func prepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        // [<#table#>].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {}
}
