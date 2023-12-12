//
//  LXRequiredVC.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/8/10.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import LXToolKit

private class MyView: UIView {
    // MARK: UI
    lazy var btnNext: UIButton = {
        let btn = UIButton(type: .custom)

        btn.setTitle("Next", for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 4

        btn.backgroundColor = .cyan

        btn.addTarget(self, action: #selector(btnNextAction(sender:)), for: .touchUpInside)
        return btn
    }()
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
private extension MyView {
    @objc func btnNextAction(sender: UIButton) {}
}

// MARK: - UI Prepare & Masonry
private extension MyView {
    func prepareUI() {
        self.backgroundColor = .white
        [btnNext].forEach(self.addSubview)
        masonry()
    }

    func masonry() {
        btnNext.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

class LXRequiredVC: LXBaseVC {
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
extension LXRequiredVC {}

// MARK: Public Actions
extension LXRequiredVC {}

// MARK: Private Actions
private extension LXRequiredVC {}

// MARK: - UI Prepare & Masonry
private extension LXRequiredVC {
    func prepareUI() {
        myView.btnNext.backgroundColor = .red
        //[<#table#>].forEach(self.view.addSubview)
        masonry()
    }

    func masonry() {}
}
