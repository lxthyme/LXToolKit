//
//  LXButtonTestVC.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2020/10/19.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class LXButtonTestVC: UIViewController {
    // MARK: 📌UI
    private lazy var btnTest: UIButton = {
        let btn = UIButton(type: .custom)

        /// 1.
        btn.setTitle("normal", for: .normal)
        btn.setTitle("selected", for: .selected)
        btn.setTitle("highlighted", for: .highlighted)
        btn.setTitle("disabled", for: .disabled)

        /// 2.
        btn.setTitle("[.normal, .selected]", for: [.normal, .selected])
        btn.setTitle("[.normal, .highlighted]", for: [.normal, .highlighted])
        btn.setTitle("[.normal, .disabled]", for: [.normal, .disabled])

        btn.setTitle("[.selected, .normal]", for: [.selected, .normal])
        btn.setTitle("[.selected, .highlighted]", for: [.selected, .highlighted])
        btn.setTitle("[.selected, .disabled]", for: [.selected, .disabled])

        btn.setTitle("[.highlighted, .normal]", for: [.highlighted, .normal])
        btn.setTitle("[.highlighted, .selected]", for: [.highlighted, .selected])
        btn.setTitle("[.highlighted, .disabled]", for: [.highlighted, .disabled])

        btn.setTitle("[.disabled, .normal]", for: [.disabled, .normal])
        btn.setTitle("[.disabled, .selected]", for: [.disabled, .selected])
        btn.setTitle("[.disabled, .highlighted]", for: [.disabled, .highlighted])

        /// 3.
        btn.setTitle("[.normal, .selected, .highlighted]", for: [.normal, .selected, .highlighted])
        btn.setTitle("[.normal, .selected, .disabled]", for: [.normal, .selected, .disabled])
        btn.setTitle("[.normal, .highlighted, .disabled]", for: [.normal, .highlighted, .disabled])

        /// 4.
        btn.setTitle("[.normal, .selected, .highlighted, .disabled]", for: [.normal, .selected, .highlighted, .disabled])

        btn.setTitleColor(.black, for: .normal)
//        btn.setTitleColor(<#.blue#>, for: .selected)

//        btn.setBackgroundColor(<#.magenta#>, forState: .normal)
//        btn.setBackgroundColor(<#.gray#>, forState: .selected)

//        btn.titleLabel?.font = UIFont.systemFont(ofSize: <#T##CGFloat#>)
//        btn.layer.masksToBounds = true
//        btn.layer.cornerRadius = <#4#>

//        <#btn.addTarget(self, action: #selector(btnSigninAction(sender:)), for: .touchUpInside)#>
//        <#@objc func btnSigninAction(sender: UIButton) {}#>
        return btn
    }()
    private lazy var segmentV1Control: UISegmentedControl = {
        let s = UISegmentedControl(items: [
            ".normal",
            ".selected",
            ".highlighted",
            ".disabled",
        ])
        s.selectedSegmentIndex = 0
        s.isMomentary = false
        s.apportionsSegmentWidthsByContent = true
        s.addTarget(self, action: #selector(segmentV1Changed(sender:)), for: .valueChanged)

        return s
    }()
    private lazy var segmentV21Control: UISegmentedControl = {
        let s = UISegmentedControl(items: [
            "[.normal, .selected]",
            "[.normal, .highlighted]",
            "[.normal, .disabled]",
        ])
        s.selectedSegmentIndex = 0
        s.isMomentary = false
        s.apportionsSegmentWidthsByContent = true
        s.addTarget(self, action: #selector(segmentV21Changed(sender:)), for: .valueChanged)

        return s
    }()
    private lazy var segmentV22Control: UISegmentedControl = {
        let s = UISegmentedControl(items: [
        "[.selected, .normal]",
        "[.selected, .highlighted]",
        "[.selected, .disabled]",
        ])
        s.selectedSegmentIndex = 0
        s.isMomentary = false
        s.apportionsSegmentWidthsByContent = true
        s.addTarget(self, action: #selector(segmentV22Changed(sender:)), for: .valueChanged)

        return s
    }()
    private lazy var segmentV23Control: UISegmentedControl = {
        let s = UISegmentedControl(items: [
        "[.highlighted, .normal]",
        "[.highlighted, .selected]",
        "[.highlighted, .disabled]",
        ])
        s.selectedSegmentIndex = 0
        s.isMomentary = false
        s.apportionsSegmentWidthsByContent = true
        s.addTarget(self, action: #selector(segmentV23Changed(sender:)), for: .valueChanged)

        return s
    }()
    private lazy var segmentV24Control: UISegmentedControl = {
        let s = UISegmentedControl(items: [
        "[.disabled, .normal]",
        "[.disabled, .selected]",
        "[.disabled, .highlighted]",
        ])
        s.selectedSegmentIndex = 0
        s.isMomentary = false
        s.apportionsSegmentWidthsByContent = true
        s.addTarget(self, action: #selector(segmentV24Changed(sender:)), for: .valueChanged)

        return s
    }()
    private lazy var segmentV3Control: UISegmentedControl = {
        let s = UISegmentedControl(items: [
            "[.normal, .selected, .highlighted]",
            "[.normal, .selected, .disabled]",
            "[.normal, .highlighted, .disabled]",
        ])
        s.selectedSegmentIndex = 0
        s.isMomentary = false
        s.apportionsSegmentWidthsByContent = true
        s.addTarget(self, action: #selector(segmentV3Changed(sender:)), for: .valueChanged)

        return s
    }()
    private lazy var segmentV4Control: UISegmentedControl = {
        let s = UISegmentedControl(items: [
            "[.normal, .selected, .highlighted, .disabled]",
        ])
        s.selectedSegmentIndex = 0
        s.isMomentary = false
        s.apportionsSegmentWidthsByContent = true
        s.addTarget(self, action: #selector(segmentV4Changed(sender:)), for: .valueChanged)

        return s
    }()
    // MARK: 🔗Vaiables
    private var states: [UIControl.State] = [
        .normal,
        .selected,
        .highlighted,
        .disabled,
        [.normal, .selected],
        [.normal, .highlighted],
        [.normal, .disabled],
        [.selected, .normal],
        [.selected, .highlighted],
        [.selected, .disabled],
        [.highlighted, .normal],
        [.highlighted, .selected],
        [.highlighted, .disabled],
        [.disabled, .normal],
        [.disabled, .selected],
        [.disabled, .highlighted],
        [.normal, .selected, .highlighted],
        [.normal, .selected, .disabled],
        [.normal, .highlighted, .disabled],
        [.normal, .selected, .highlighted, .disabled],
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LXButtonTestVC {}

// MARK: 👀Public Actions
extension LXButtonTestVC {}

// MARK: 🔐Private Actions
private extension LXButtonTestVC {
    @objc func segmentV1Changed(sender: UISegmentedControl) {
        let selectedIdx = sender.selectedSegmentIndex
//        btnTest.s
    }
    @objc func segmentV21Changed(sender: UISegmentedControl) {
        let selectedIdx = sender.selectedSegmentIndex
    }
    @objc func segmentV22Changed(sender: UISegmentedControl) {
        let selectedIdx = sender.selectedSegmentIndex
    }
    @objc func segmentV23Changed(sender: UISegmentedControl) {
        let selectedIdx = sender.selectedSegmentIndex
    }
    @objc func segmentV24Changed(sender: UISegmentedControl) {
        let selectedIdx = sender.selectedSegmentIndex
    }
    @objc func segmentV3Changed(sender: UISegmentedControl) {
        let selectedIdx = sender.selectedSegmentIndex
    }
    @objc func segmentV4Changed(sender: UISegmentedControl) {
        let selectedIdx = sender.selectedSegmentIndex
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXButtonTestVC {
    func prepareUI() {
        self.view.backgroundColor = UIColor.white
        // self.title = "<#title#>"

        // [<#table#>].forEach(self.view.addSubview)
        masonry()
    }

    func masonry() {}
}
