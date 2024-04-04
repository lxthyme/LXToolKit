//
//  LXFlutterVC.swift
//  LXTest
//
//  Created by lxthyme on 2024/1/15.
//
import UIKit
import FlutterPluginRegistrant
import LXFlutterKit

class LXFlutterVC: LXBaseFlutterVC {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(with channel: FlutterManager.Channel) {
        channel.engine = FlutterManager.shared.registerFromGroup(withEntryPoint: channel.entrypoint.value);
        guard let engine = channel.engine else { fatalError("flutter engine can't be nil. -->enging: \(channel.engine?.description ?? "--")") }
        GeneratedPluginRegistrant.register(with: engine)
        super.init(with: channel)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LXFlutterVC {}

// MARK: 👀Public Actions
extension LXFlutterVC {}

// MARK: 🔐Private Actions
private extension LXFlutterVC {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXFlutterVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        // [<#table#>].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {}
}
