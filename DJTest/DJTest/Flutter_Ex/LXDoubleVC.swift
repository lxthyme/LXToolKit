//
//  LXDoubleVC.swift
//  DJTest
//
//  Created by lxthyme on 2023/12/26.
//
import UIKit
import LXToolKit
import LXFlutterKit

class LXDoubleVC: LXBaseVC {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    private lazy var topVC: LXSingleVC = {
        let channel = FlutterManager.Channel(entrypoint: .topMain, channelName: .multiCounter)
        return LXSingleVC(with: channel)
    }()
    private let bottomVC: LXSingleVC = {
        let channel = FlutterManager.Channel(entrypoint: .bottomMain, channelName: .multiCounter)
        return LXSingleVC(with: channel)
    }()
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LXDoubleVC {}

// MARK: 👀Public Actions
extension LXDoubleVC {}

// MARK: 🔐Private Actions
private extension LXDoubleVC {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXDoubleVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        addChild(topVC)
        addChild(bottomVC)
        let safeFrame = self.view.safeAreaLayoutGuide.layoutFrame
        let halfHeight = safeFrame.height / 2.0
        topVC.view.frame = CGRect(
          x: safeFrame.minX, y: safeFrame.minY, width: safeFrame.width, height: halfHeight)
        bottomVC.view.frame = CGRect(
          x: safeFrame.minX, y: topVC.view.frame.maxY, width: safeFrame.width, height: halfHeight)
        self.view.addSubview(topVC.view)
        self.view.addSubview(bottomVC.view)
        topVC.didMove(toParent: self)
        bottomVC.didMove(toParent: self)

        // [<#table#>].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {}
}
