//
//  LXMasonryTestVCVC.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/2/23.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import LXToolKit

class LXMasonryTestVCVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var panelView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    private lazy var labPanelLeft: UILabel = {
        let label = UILabel()
        label.text = "PanelLeft"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.backgroundColor = UIColor.XL.random
        return label
    }()
    private lazy var labPanelRight: UILabel = {
        let label = UILabel()
        label.text = "PanelRight"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.backgroundColor = UIColor.XL.random
        return label
    }()
    private lazy var labLeft: UILabel = {
        let label = UILabel()
        label.text = "Left"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.backgroundColor = UIColor.XL.random
        return label
    }()
    private lazy var labRight: UILabel = {
        let label = UILabel()
        label.text = "Right"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.backgroundColor = UIColor.XL.random
        return label
    }()
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
extension LXMasonryTestVCVC {}

// MARK: 👀Public Actions
extension LXMasonryTestVCVC {}

// MARK: 🔐Private Actions
private extension LXMasonryTestVCVC {}

// MARK: - 🍺UI Prepare & Masonry
extension LXMasonryTestVCVC {
    func basicMasonry() {
        labPanelLeft.snp.makeConstraints {
            $0.top.bottom.left.equalToSuperview()
            $0.width.equalTo(100)
        }
        labPanelRight.snp.makeConstraints {
            $0.top.bottom.right.equalToSuperview()
            $0.left.equalTo(labPanelLeft.snp.right)
            $0.width.equalTo(250)
        }
        panelView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(300)
            $0.centerX.equalToSuperview()
        }
    }
    func basicMasonryFit1_2() {
        labPanelLeft.snp.makeConstraints {
            $0.top.bottom.left.equalToSuperview()
        }
        labPanelRight.snp.makeConstraints {
            $0.top.bottom.right.equalToSuperview()
            $0.left.equalTo(labPanelLeft.snp.right)
            $0.width.equalTo(labRight).multipliedBy(1 / 2.0)
        }
        panelView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(300)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(350)
        }
    }
    /// Fun 1
    func masonryFun1() {
        labLeft.snp.makeConstraints {
            $0.top.equalTo(panelView.snp.bottom)
            $0.centerX.equalToSuperview().offset(-125)
            $0.width.equalTo(100)
        }
        labRight.snp.makeConstraints {
            $0.top.equalTo(labLeft)
            $0.left.equalTo(labLeft.snp.right)
            $0.width.equalTo(250)
        }
    }
    /// Fun 1.5
    func masonryFun1_5() {
        labLeft.snp.makeConstraints {
            $0.top.equalTo(panelView.snp.bottom)
            $0.centerX.equalTo(labRight).multipliedBy(1 / 2.0)
            $0.width.equalTo(100)
        }
        labRight.snp.makeConstraints {
            $0.top.equalTo(labLeft)
            $0.left.equalTo(labLeft.snp.right)
            $0.width.equalTo(250)
        }
    }
    /// Fun 2
    func masonryFun2() {
        labLeft.snp.makeConstraints {
            $0.top.equalTo(panelView.snp.bottom)
            $0.right.equalTo(labRight.snp.left)
            $0.width.equalTo(100)
        }
        labRight.snp.makeConstraints {
            $0.top.equalTo(labLeft)
            $0.centerX.equalToSuperview().offset(50)
            $0.width.equalTo(250)
        }
    }
    /// Fun 2.5
    func masonryFun2_5() {
        labLeft.snp.makeConstraints {
            $0.top.equalTo(panelView.snp.bottom)
            $0.right.equalTo(labRight.snp.left)
            $0.width.equalTo(100)
        }
        labRight.snp.makeConstraints {
            $0.top.equalTo(labLeft)
            $0.centerX.equalTo(labLeft).multipliedBy(-1 / 5.0)
            $0.width.equalTo(250)
        }
    }
    func masonyFit1() {
        labLeft.snp.makeConstraints {
            $0.top.equalTo(panelView.snp.bottom)
            $0.right.equalTo(labRight.snp.left)
            $0.width.equalTo(labPanelLeft)
        }
        labRight.snp.makeConstraints {
            $0.top.equalTo(labLeft)
            $0.width.equalTo(labPanelRight)
            $0.centerX.equalTo(labLeft)// .multipliedBy(4)
        }
    }
}

private extension LXMasonryTestVCVC {
    func prepareUI() {
        navigationItem.title = "两个 View 组合的 CenterX 测试"
        self.view.backgroundColor = .white

        [labPanelLeft, labPanelRight].forEach(panelView.addSubview)
        [panelView, labLeft, labRight].forEach(view.addSubview)

        // basicMasonry()
        // 👍
        // masonryFun1()
        // masonryFun2()
        // testing...
        // masonryFun1_5()

        basicMasonryFit1_2()
        masonryFun2_5()
    }
}
