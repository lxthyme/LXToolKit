//
//  LXResolveIMPVC.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/8/7.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class LXResolveIMPVC: UIViewController {
    // MARK: UI
    // MARK: Vaiables
    // MARK: Life Cycle
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

        test1()
    }

}

// MARK: LoadData
extension LXResolveIMPVC {}

// MARK: Public Actions
extension LXResolveIMPVC {}

// MARK: Private Actions
private extension LXResolveIMPVC {
    func test1() {
        let obj = LXResolveTestObj()
        obj.testUnRealized()
    }
}

// MARK: - UI Prepare & Masonry
private extension LXResolveIMPVC {
    func prepareUI() {
        //[<#table#>].forEach(self.view.addSubview)
        masonry()
    }

    func masonry() {}
}
