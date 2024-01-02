//
//  DJInitialSplitVC.swift
//  test
//
//  Created by lxthyme on 2023/3/26.
//
import UIKit

class DJInitialSplitVC: LXBaseTableVC {
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
private extension DJInitialSplitVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        emptyDataSet.title = R.string.localizable.initialNoResults()
        table.headRefreshControl = nil
        table.footRefreshControl = nil

        // [<#table#>].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {}
}
