//
//  LXDynamicLandVC.swift
//  DJTest
//
//  Created by lxthyme on 2024/3/15.
//
import UIKit
import LXToolKit
import SwifterSwift

@available(iOS 16.2, *)
class LXDynamicLandVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var btnStart: UIButton = {
        let btn = UIButton(type: .custom)
        btn.contentEdgeInsets = UIEdgeInsets(horizontal: 10, vertical: 6)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8

        btn.setTitle("Start", for: .normal)
        btn.setTitleColor(.XL.randomGolden, for: .normal)

        let random: UIColor = .XL.randomLight
        btn.setBackgroundColor(color: random, forState: .normal)
        btn.setBackgroundColor(color: random.withAlphaComponent(0.5), forState: .selected)

        // btn.addTarget(self, action: #selector(btnStart(sender:)), for: .touchUpInside)
        // @objc func btnStart(sender: UIButton) {}
        btn.addAction(UIAction(handler: {[weak self]_ in
            if #available(iOS 16.2, *) {
                ActivityVM.shareInstance.startActivity()
            }
        }), for: .touchUpInside)
        return btn
    }()
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: 🌎LoadData
@available(iOS 16.2, *)
extension LXDynamicLandVC {}

// MARK: 👀Public Actions
@available(iOS 16.2, *)
extension LXDynamicLandVC {}

// MARK: 🔐Private Actions
@available(iOS 16.2, *)
private extension LXDynamicLandVC {}

// MARK: - 🍺UI Prepare & Masonry
@available(iOS 16.2, *)
private extension LXDynamicLandVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        [btnStart].forEach(self.contentStackView.addArrangedSubview)

        masonry()
    }

    func masonry() {
        contentStackView.snp.remakeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
