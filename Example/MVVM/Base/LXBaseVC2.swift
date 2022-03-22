//
//  LXBaseVC2.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/3/11.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import LXToolKit

class LXBaseVC2<VM: LXBaseVM>: LXBaseVC {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    var vm: LXBaseVM?
    var navigator: LXNavigator!
    // MARK: 🛠Life Cycle
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    init(vm: VM?, navigator: LXNavigator) {
        self.vm = vm
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }
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
extension LXBaseVC2 {}

// MARK: 👀Public Actions
extension LXBaseVC2 {}

// MARK: 🔐Private Actions
private extension LXBaseVC2 {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXBaseVC2 {
    func prepareUI() {
        self.view.backgroundColor = .white

        // [<#table#>].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {}
}