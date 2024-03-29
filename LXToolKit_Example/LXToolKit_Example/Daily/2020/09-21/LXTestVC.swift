//
//  LXTestVC.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/21.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import LXToolKit

private class MyView: LXBaseView {
    // MARK: 📌UI
    private lazy var btnCenter: UIButton = {
        let btn = UIButton(type: .custom)

        btn.setTitle("Center", for: .normal)
//        btn.setTitle("<#selectedTitle#>", for: UIControl.State.selected)
        btn.setTitleColor(.black, for: .normal)
//        btn.setTitleColor(<#.blue#>, for: .selected)

//        btn.setBackgroundColor(<#.magenta#>, forState: .normal)
//        btn.setBackgroundColor(<#.gray#>, forState: .selected)

//        btn.titleLabel?.font = UIFont.systemFont(ofSize: <#T##CGFloat#>)
//        btn.layer.masksToBounds = true
//        btn.layer.cornerRadius = <#4#>

        btn.addTarget(self, action: #selector(btnCenterAction(sender:)), for: .touchUpInside)
        return btn
    }()
    // MARK: 🔗Vaiables
    weak var vc: LXTestVC?
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)

        prepareUI()
    }

}

// MARK: 🌎LoadData
extension MyView {}

// MARK: 👀Public Actions
extension MyView {}

// MARK: 🔐Private Actions
private extension MyView {
    @objc func btnCenterAction(sender: UIButton) {
        self.vc?.dismiss(animated: true, completion: nil)
    }
}

// MARK: - 🍺UI Prepare & Masonryry
private extension MyView {
    func prepareUI() {
        self.backgroundColor = .white
        [btnCenter].forEach(self.addSubview)
        masonry()
    }

    func masonry() {
        btnCenter.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

class LXTestVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var myView: CustomView = {
        let cv = CustomView()
        cv.vc = self
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
    // MARK: - 🍺UI Prepare & Masonryry
    func prepareUI() {
        // [<#table#>].forEach(self.view.addSubview)
        masonry()
    }

    func masonry() {}
}

// MARK: 🌎LoadData
extension LXTestVC {}

// MARK: 👀Public Actions
extension LXTestVC {}

// MARK: 🔐Private Actions
private extension LXTestVC {}
