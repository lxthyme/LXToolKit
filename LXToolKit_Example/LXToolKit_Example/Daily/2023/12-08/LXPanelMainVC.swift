//
//  LXPanelMainVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/12/8.
//
import UIKit
import LXToolKit

class LXPanelMainVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var btnShow: UIButton = {
        let btn = UIButton(type: .custom)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.contentEdgeInsets = UIEdgeInsets(horizontal: 5, vertical: 3)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8

        btn.setTitle("Show", for: .normal)
        btn.setTitleColor(.black, for: .normal)

        let color: UIColor = .XL.randomGolden
        btn.setBackgroundColor(color: color, forState: .normal)
        btn.setBackgroundColor(color: color.withAlphaComponent(0.4), forState: .selected)

        btn.addAction(UIAction(handler: {[weak self] _ in
            self?.showPanelContentVC()
        }), for: .touchUpInside)
        return btn
    }()
    // MARK: 🔗Vaiables
    let transition = LXModalTransition()
    // MARK: 🛠Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)

        showPanelContentVC()
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
extension LXPanelMainVC {
    func dataFill() {}
}

// MARK: 👀Public Actions
extension LXPanelMainVC {}

// MARK: 🔐Private Actions
private extension LXPanelMainVC {
    func showPanelContentVC() {
        let vc = LXPanelContentVC()
        vc.transitioningDelegate = transition
        // self.view.addSubview(vc.view)
        // self.addChild(vc)

        // vc.view.frame = self.view.bounds
        transition.interactiveTransition.transitionToVC(toVC: vc)
        self.present(vc, animated: true)
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXPanelMainVC {
    func prepareUI() {
        self.view.backgroundColor = .XL.randomGolden
        // navigationItem.title = ""

        [btnShow].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {
        btnShow.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
