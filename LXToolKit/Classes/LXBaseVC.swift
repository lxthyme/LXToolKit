//
//  LXBaseVC.swift
//  LXToolKit
//
//  Created by LXThyme Jason on 2019/11/12.
//

import UIKit

class LXBaseVC: UIViewController {
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
    }

}

// MARK: LoadData
extension LXBaseVC {}

// MARK: Public Actions
extension LXBaseVC {}

// MARK: Private Actions
private extension LXBaseVC {}

// MARK: - UI Prepare & Masonry
private extension LXBaseVC {
    func prepareUI() {
        //[<#table#>].forEach(self.view.addSubview)
        masonry()
    }

    func masonry() {}
}
