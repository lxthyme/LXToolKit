//
//  LXBaseVMVC2.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/1/17.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class LXBaseVMVC2: UIViewController {
    // MARK: 📌UI
    private lazy var emptyView: LXEmptyView = {
        let v = LXEmptyView()
        v.backgroundColor = .white
        return v
    }()
    // MARK: 🔗Vaiables
    private lazy var retryInputObservable = PublishSubject<Void>()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LXBaseVMVC2 {}

// MARK: 👀Public Actions
extension LXBaseVMVC2 {
    func requestAgin() {}

    func requestErrorWithEmptyConfig(errorType: ActionError) {
        self.emptyView.removeFromSuperview()
        self.emptyView.retryBlock = {
            self.requestAgin()
        }
        switch errorType {
            case .notEnabled:
                break
            case .underlyingError(let error):
                break
        }
    }
}

// MARK: 🔐Private Actions
private extension LXBaseVMVC2 {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXBaseVMVC2 {
    func prepareUI() {
        self.view.backgroundColor = UIColor.white
        // self.title = "<#title#>"

        // [<#table#>].forEach(self.view.addSubview)
        masonry()
    }

    func masonry() {}
}
