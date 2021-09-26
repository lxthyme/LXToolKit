//
//  LXNestedCell.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2021/9/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class LXNestedCell: UIViewController {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LXNestedCell {}

// MARK: 👀Public Actions
extension LXNestedCell {}

// MARK: 🔐Private Actions
private extension LXNestedCell {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXNestedCell {
    func prepareUI() {
        self.view.backgroundColor = UIColor.white
        // self.title = "<#title#>"

        //[<#table#>].forEach(self.view.addSubview)
        masonry()
    }

    func masonry() {}
}
