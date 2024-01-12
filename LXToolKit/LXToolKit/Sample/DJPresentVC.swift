//
//  DJPresentVC.swift
//  LXToolKit
//
//  Created by lxthyme on 2024/1/13.
//
import UIKit

class DJPresentVC: LXBaseVC {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension DJPresentVC {}

// MARK: 👀Public Actions
extension DJPresentVC {}

// MARK: 🔐Private Actions
private extension DJPresentVC {}

// MARK: - 🍺UI Prepare & Masonry
private extension DJPresentVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        // [<#table#>].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {}
}
