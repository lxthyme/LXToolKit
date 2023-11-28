//
//  LXAttributedStringVC.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/6/3.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class LXAttributedStringVC: UIViewController {
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
extension LXAttributedStringVC {}

// MARK: 👀Public Actions
extension LXAttributedStringVC {}

// MARK: 🔐Private Actions
private extension LXAttributedStringVC {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXAttributedStringVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        // self.title = "<#title#>"

        // [<#table#>].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {}
}
