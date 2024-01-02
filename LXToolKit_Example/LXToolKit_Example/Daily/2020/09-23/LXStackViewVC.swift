//
//  LXStackViewVC.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/23.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import LXToolKit

private class MyView: LXBaseView {
    // MARK: 📌UI
    private lazy var labTitle: UILabel = {
        let label = UILabel()
        label.text = "titletitletitle"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center

        var title = "titletitletitle"
        var unfold = "详情"
        var fold = "收起"
        var string = title + unfold
        var attr = NSMutableAttributedString(string: string)
        attr.addAttributes([
            NSAttributedString.Key.link: "https://google.com"
        ], range: (string as NSString).range(of: unfold))
        label.attributedText = attr
        return label
    }()
    private lazy var labSubtitle: UILabel = {
        let label = UILabel()
        label.text = "[1]Lorem ipsum dolor sit amet consectetur adipisicing elit. Ex praesentium fugiat eligendi est explicabo, voluptatum facilis sint placeat sapiente vel veritatis culpa qui at, iure esse labore quam cupiditate reprehenderit."
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.backgroundColor = UIColor.XL.hexString("#000", transparency: 0.1)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    private lazy var labSubtitle2: UILabel = {
        let label = UILabel()
        label.text = "[2]Lorem ipsum dolor sit amet consectetur adipisicing elit. Ex praesentium fugiat eligendi est explicabo, voluptatum facilis sint placeat sapiente vel veritatis culpa qui at, iure esse labore quam cupiditate reprehenderit."
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.backgroundColor = UIColor.XL.hexString("#000", transparency: 0.1)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    private lazy var btnToggle: UIButton = {
        let btn = UIButton(type: .custom)

        btn.setTitle("详情", for: .normal)
        btn.setTitle("折叠", for: UIControl.State.selected)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitleColor(.black, for: .selected)

//        btn.setBackgroundColor(<#.magenta#>, forState: .normal)
//        btn.setBackgroundColor(<#.gray#>, forState: .selected)

        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 4

        btn.addTarget(self, action: #selector(btnToggleAction(sender:)), for: .touchUpInside)
        return btn
    }()
    private lazy var bototmView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.XL.hexString("#000", transparency: 0.3)
        return v
    }()
    private lazy var collapseStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.alignment = .fill
        v.spacing = 20

        v.backgroundColor = .red
        return v
    }()
    private lazy var collapseBarStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.alignment = .leading
        return v
    }()
    // MARK: 🔗Vaiables
    weak var vc: LXStackViewVC?
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
    @objc func btnToggleAction(sender: UIButton) {
        let isHidden = !labSubtitle.isHidden
        labSubtitle.isHidden = isHidden
        btnToggle.isSelected = isHidden
    }
}

// MARK: - 🍺UI Prepare & Masonryry
private extension MyView {
    func prepareUI() {
        self.backgroundColor = .white
//        self.backgroundColor = UIColor(hex: "#000", alpha: 0.3)
//        self.backgroundColor = .lightGray
        [labTitle].forEach(collapseBarStackView.addArrangedSubview)
        [collapseBarStackView, labSubtitle, labSubtitle2].forEach(collapseStackView.addArrangedSubview)
        [collapseStackView, btnToggle, bototmView].forEach(self.addSubview)
        masonry()
    }

    func masonry() {
        collapseStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        btnToggle.snp.makeConstraints {
            $0.centerY.equalTo(collapseBarStackView)
            $0.left.equalTo(labTitle.snp.right).offset(8)
        }
        bototmView.snp.makeConstraints {
            $0.top.equalTo(collapseStackView.snp.bottom)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(2)
        }
    }
}

class LXStackViewVC: LXBaseVC {
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
extension LXStackViewVC {}

// MARK: 👀Public Actions
extension LXStackViewVC {}

// MARK: 🔐Private Actions
private extension LXStackViewVC {}
