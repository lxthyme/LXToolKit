//
//  LXFirstVC.swift
//  LXTest
//
//  Created by lxthyme on 2023/12/7.
//
import UIKit
import LXToolKit

class LXFirstVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var btnGo: UIButton = {
        let btn = UIButton(type: .custom)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.contentEdgeInsets = UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)
        btn.backgroundColor = .External.Material.cyan200
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8

        btn.setTitle("Go", for: .normal)
        btn.setBackgroundColor(color: .cyan, forState: .normal)
        btn.setBackgroundColor(color: .cyan.withAlphaComponent(0.5), forState: .highlighted)

        if #available(iOS 14.0, *) {
            btn.addAction(UIAction(handler: {[weak self] _ in
                let vc = ViewController()
                self?.navigationController?.pushViewController(vc)
            }), for: .touchUpInside)
        }

        return btn
    }()
    private lazy var btnResourcesCount: UIButton = {
        let btn = UIButton(type: .custom)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.contentEdgeInsets = UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8

        btn.setTitle("RxSwift resourcesCount", for: .normal)
        btn.setBackgroundColor(color: .cyan, forState: .normal)
        btn.setBackgroundColor(color: .cyan.withAlphaComponent(0.5), forState: .highlighted)

        if #available(iOS 14.0, *) {
            btn.addAction(UIAction(handler: {[weak self] _ in
                self?.refreshResourcesCount()
            }), for: .touchUpInside)
        }

        return btn
    }()
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)

        refreshResourcesCount()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LXFirstVC {}

// MARK: 👀Public Actions
extension LXFirstVC {}

// MARK: 🔐Private Actions
private extension LXFirstVC {
    func refreshResourcesCount() {
        let total = LogKit.resourcesCount()
        btnResourcesCount.setTitle("RxSwift resourcesCount: \(total)", for: .normal)
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXFirstVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        navigationItem.title = "LXFirstVC"

        [btnGo, btnResourcesCount].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {
        btnGo.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(80)
            $0.height.equalTo(40)
        }
        btnResourcesCount.snp.makeConstraints {
            $0.top.equalTo(btnGo.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.greaterThanOrEqualTo(80)
            $0.height.equalTo(40)
        }
    }
}
