//
//  LXFirstVC.swift
//  test_Example
//
//  Created by lxthyme on 2023/5/26.
//  Copyright © 2023 CocoaPods. All rights reserved.
//
import UIKit
import test

open class LXFirstVC: LXBaseVC {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }
    override open func prepareUI() {
        self.view.backgroundColor = .white
        // self.title = "<#title#>"

        // [<#table#>].forEach(self.view.addSubview)

        masonry()
    }

    override open func masonry() {
        super.masonry()
    }
}

// MARK: 🌎LoadData
extension LXFirstVC {}

// MARK: 👀Public Actions
extension LXFirstVC {}

// MARK: 🔐Private Actions
private extension LXFirstVC {}

// MARK: - 🍺UI Prepare & Masonry
extension LXFirstVC {
    // func prepareUI() {
    //     self.view.backgroundColor = .white
    //     // self.title = "<#title#>"
    //
    //     // [<#table#>].forEach(self.view.addSubview)
    // 
    //     masonry()
    // }
    // 
    // override open func masonry() {
    //     super.masonry()
    // }
}
