//
//  LXPost2VC.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/8/10.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import LXToolKit

private class MyView: UIView {
    // MARK: UI
    // MARK: Vaiables
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)

        prepareUI()
    }

}

// MARK: LoadData
extension MyView {}

// MARK: Public Actions
extension MyView {}

// MARK: Private Actions
private extension MyView {}

// MARK: - UI Prepare & Masonry
private extension MyView {
    func prepareUI() {
        self.backgroundColor = .white
        // [<#table#>].forEach(self.addSubview)
        masonry()
    }

    func masonry() {}
}

class LXPost2VC: LXBaseVC {
    private typealias CustomView = MyView
    // MARK: UI
    private lazy var myView: CustomView = {
        return CustomView()
    }()
    // MARK: Vaiables
    // MARK: Life Cycle
    override func loadView() {
        view = myView
    }
    // override func viewWillAppear(_ animated: Bool) {
    //     super.viewWillAppear(animated)
    // }
    // override func viewDidAppear(_ animated: Bool) {
    //     super.viewDidAppear(animated)
    // }
    // override func viewWillDisappear(_ animated: Bool) {
    //     super.viewWillDisappear(animated)
    // }
    // override func viewDidDisappear(_ animated: Bool) {
    //     super.viewDidDisappear(animated)
    // }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: LoadData
extension LXPost2VC {}

// MARK: Public Actions
extension LXPost2VC {}

// MARK: Private Actions
private extension LXPost2VC {}

// MARK: - UI Prepare & Masonry
private extension LXPost2VC {
    func prepareUI() {
        //[<#table#>].forEach(self.view.addSubview)
        masonry()
    }

    func masonry() {}
}
