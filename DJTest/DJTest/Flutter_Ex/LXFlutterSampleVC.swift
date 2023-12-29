//
//  LXFlutterSampleVC.swift
//  DJTest
//
//  Created by lxthyme on 2023/12/29.
//
import UIKit
import LXFlutterKit

class LXFlutterSampleVC: LXBaseFlutterVC {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
        prepareFlutter()
    }

}

// MARK: 🌎LoadData
extension LXFlutterSampleVC {}

// MARK: 👀Public Actions
extension LXFlutterSampleVC {
    static func vcFrom(entrypoint: FlutterManager.EntryPoint, channelName: FlutterManager.ChannelName) -> LXFlutterSampleVC {
        let channel = FlutterManager.Channel(entrypoint: entrypoint, channelName: channelName)
        let vc = LXFlutterSampleVC(with: channel)
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}

// MARK: 🔐Private Actions
private extension LXFlutterSampleVC {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXFlutterSampleVC {
    func prepareFlutter() {

    }
    func prepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        // [<#table#>].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {}
}
