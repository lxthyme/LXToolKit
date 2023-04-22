//
//  LXMVVMSampleVC.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import LXToolKit

private class MyView: LXBaseView {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    private weak var vc: LXMVVMSampleVC?
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override private init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(vc: LXMVVMSampleVC) {
        self.init(frame: .zero)

        self.vc = vc

        prepareUI()
    }

}

// MARK: 🌎LoadData
extension MyView {}

// MARK: 👀Public Actions
extension MyView {}

// MARK: 🔐Private Actions
private extension MyView {}

// MARK: - 🍺UI Prepare & Masonryry
private extension MyView {
    func prepareUI() {
        var a = [1, 2, 3, 4, 5]
        let b = a[1...3]
        let c = Array(b)
        self.backgroundColor = .white
        //[<#table#>].forEach(self.addSubview)
        masonry()
    }

    func masonry() {}
}

class LXMVVMSampleVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var myView: CustomView = {
        let cv = CustomView(vc: self)
        return cv
    }()
    // MARK: 🔗Vaiables
    private typealias CustomView = MyView
    // MARK: 🛠Life Cycle
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

// MARK: 🌎LoadData
extension LXMVVMSampleVC {}

// MARK: 👀Public Actions
extension LXMVVMSampleVC {}

// MARK: 🔐Private Actions
private extension LXMVVMSampleVC {}

// MARK: - 🍺UI Prepare & Masonryry
extension LXMVVMSampleVC {
    override func prepareUI() {
        super.prepareUI()
        //[<#table#>].forEach(self.view.addSubview)
        masonry()
    }

    override func masonry() {
        super.masonry()
    }
}
