//
//  LXTestVC.swift
//  BaiLianMobileApp
//
//  Created by lxthyme on 2022/7/12.
//  Copyright © 2022 bailian. All rights reserved.
//
import UIKit
// import RxSwift
// import Alamofire
// import HandyJSON
// import Moya
// import Toast_Swift
import SnapKit
// import YYCache

@objc(DJBusinessModuleSwiftVC)
open class LXTestVC: UIViewController {
    // MARK: 📌UI
    private lazy var btnRxNetworks: UIButton = {
        let btn = UIButton(type: .custom)

        btn.setTitle("RxNetworks", for: .normal)
        btn.setTitleColor(.blue, for: .normal)

        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 4

        btn.addTarget(self, action: #selector(btnRxNetworks(sender:)), for: .touchUpInside)
        return btn
    }()
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: 🌎LoadData
extension LXTestVC {}

// MARK: 👀Public Actions
extension LXTestVC {}

// MARK: 🔐Private Actions
private extension LXTestVC {
    @objc func btnRxNetworks(sender: UIButton) {
        let vc = HomeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXTestVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        // self.title = "<#title#>"

        // [self.btnRxNetworks].forEach(self.view.addSubview)
        self.view.addSubview(self.btnRxNetworks)
        print("btnRxNetworks: \(self.btnRxNetworks)")
        print("self.view: \(self.view)")

        masonry()
    }

    func masonry() {
        btnRxNetworks.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
