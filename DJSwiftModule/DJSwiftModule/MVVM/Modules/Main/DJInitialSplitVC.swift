//
//  DJInitialSplitVC.swift
//  test
//
//  Created by lxthyme on 2023/3/26.
//
import UIKit
import LXToolKit

class DJInitialSplitVC: LXBaseTableVC {
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
extension DJInitialSplitVC {
    func dataFill() {}
}

// MARK: 👀Public Actions
extension DJInitialSplitVC {}

// MARK: 🔐Private Actions
private extension DJInitialSplitVC {}

// MARK: - 🍺UI Prepare & Masonry
extension DJInitialSplitVC {
    override func prepareUI() {
        super.prepareUI()
        self.view.backgroundColor = .white
        emptyDataSet.title = R.string.localizable.initialNoResults()
        table.headRefreshControl = nil
        table.footRefreshControl = nil

        // [<#table#>].forEach(self.view.addSubview)

        masonry()
    }

    override func masonry() {
        super.masonry()
    }
}
