//
//  LXTestListCycleVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2024/1/27.
//
import UIKit

class LXTestListCycleVC: UIViewController {
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
extension LXTestListCycleVC {}

// MARK: 👀Public Actions
extension LXTestListCycleVC {}

// MARK: 🔐Private Actions
private extension LXTestListCycleVC {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXTestListCycleVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        // [<#table#>].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {}
}
