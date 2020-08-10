//
//  LXRequiredVC.swift
//  LXToolKit
//
//  Created by LXThyme Jason on 2020/8/10.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class LXRequiredVC: UIViewController {
    // MARK: UI
    // MARK: Vaiables
    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: LoadData
extension LXRequiredVC {}

// MARK: Public Actions
extension LXRequiredVC {}

// MARK: Private Actions
private extension LXRequiredVC {}

// MARK: - UI Prepare & Masonry
private extension LXRequiredVC {
    func prepareUI() {
        //[<#table#>].forEach(self.view.addSubview)
        masonry()
    }

    func masonry() {}
}
