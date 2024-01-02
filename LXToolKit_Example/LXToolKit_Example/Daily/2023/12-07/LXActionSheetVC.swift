//
//  LXActionSheetVC.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/12/7.
//
import UIKit
import LXToolKit

class LXActionSheetVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var btnShowActionSheet: UIButton = {
        let btn = UIButton(type: .custom)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.contentEdgeInsets = UIEdgeInsets(horizontal: 5, vertical: 3)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8

        btn.setTitle("Show ActionSheet", for: .normal)
        btn.setBackgroundColor(color: .XL.randomGolden, forState: .normal)
        btn.setBackgroundColor(color: .XL.randomGolden.withAlphaComponent(0.3), forState: .highlighted)

        btn.addAction(UIAction(handler: {[weak self] _ in
            self?.showActionSheet2()
        }), for: .touchUpInside)

        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LXActionSheetVC {
    func dataFill() {}
}

// MARK: 👀Public Actions
extension LXActionSheetVC {}

// MARK: 🔐Private Actions
private extension LXActionSheetVC {
    func showActionSheet() {
        let alert = UIAlertController(title: "tit\nle", message: "me\nss\nag\ne", preferredStyle: .actionSheet)

        let customView = UIControl()
        // customView.frame = CGRect(x: 10, y: 10, width: alert.view.width - 20, height: 120)
        customView.backgroundColor = .XL.randomGolden
        customView.addAction(UIAction(handler: { _ in
            alert.dismiss(animated: true)
        }), for: .touchUpInside)
        alert.view.addSubview(customView)
        customView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
            $0.height.equalTo(300)
        }

        alert.addAction(title: "Title1") { _ in
        }
        alert.addAction(title: "Title2") { _ in
        }

        self.present(alert, animated: true)
    }
    func showActionSheet2() {
        let vc = UIViewController()
        vc.view.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        vc.view.backgroundColor = .XL.randomGolden
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXActionSheetVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        [btnShowActionSheet].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {
        btnShowActionSheet.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
