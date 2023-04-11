//
//  LXSwiftVC.swift
//  LXToolKitObjc_Example
//
//  Created by lxthyme on 2022/7/31.
//  Copyright © 2022 lxthyme. All rights reserved.
//
import UIKit

class LXSwiftVC: UIViewController {
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
extension LXSwiftVC {}

// MARK: 👀Public Actions
extension LXSwiftVC {}

// MARK: 🔐Private Actions
private extension LXSwiftVC {
    func test() {
        // self.view.bou.insetBy(dx: <#T##CGFloat#>, dy: <#T##CGFloat#>)
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXSwiftVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        // self.title = "<#title#>"

        // [<#table#>].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {}
}
