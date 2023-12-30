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

class LXSingleVC: LXBaseFlutterVC {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
        prepareFlutter()

        DataModel.shared.count
            .subscribe {[weak self] count in
                dlog("-->result[SingleVC]: \(count)")
                self?.onCountUpdate(newCount: count)
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
            self.channel.methodChannel.xl_invokeMethod(method: LXFlutterMethod.MultiCounterFlutterScene.setCount, with: newCount)
        // }
    }
}

// MARK: 🔐Private Actions
private extension LXSingleVC {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXSingleVC {
    func prepareFlutter() {
        self.channel.methodChannel.xl_invokeMethod(method: LXFlutterMethod.MultiCounterFlutterScene.setCount, with: DataModel.shared.count.value)
        self.channel.registerMultiCounterMethodChannel()
    }
    func prepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        // [<#table#>].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {}
}
