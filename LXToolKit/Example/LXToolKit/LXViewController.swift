//
//  LXViewController.swift
//  LXToolKit
//
//  Created by LX314 on 11/12/2019.
//  Copyright (c) 2019 LX314. All rights reserved.
//

import UIKit
import LXToolKit
import DJBusinessModuleSwift

class LXViewController: LXBaseTableViewVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        prepareUI()
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXViewController {
    func prepareUI() {
        [table].forEach(self.view.addSubview)
        masonry()
    }
    func masonry() {
        table.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
