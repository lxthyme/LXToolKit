//
//  DJActivityVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/10/23.
//
import UIKit

class DJActivityVC: UIViewController {
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
extension DJActivityVC {}

// MARK: 👀Public Actions
extension DJActivityVC {}

// MARK: 🔐Private Actions
private extension DJActivityVC {
}

// MARK: - 🍺UI Prepare & Masonry
private extension DJActivityVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        // [<#table#>].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {}
}
