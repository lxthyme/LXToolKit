//
//  LXWebVC.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2023/3/22.
//  Copyright © 2023 CocoaPods. All rights reserved.
//
import UIKit
import SnapKit

class LXWebVC: UIViewController {
    // MARK: 📌UI
    private lazy var webView: LXStrenchableWebView = {
        let v = LXStrenchableWebView(frame: CGRectZero)
        return v
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
        loadData()
    }

}

// MARK: 🌎LoadData
extension LXWebVC {
    func loadData() {
        if let request = URLRequest(urlString: "https://www.baidu.com") {
            webView.load(request)
        }
    }
}

// MARK: 👀Public Actions
extension LXWebVC {}

// MARK: 🔐Private Actions
private extension LXWebVC {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXWebVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        // self.title = "<#title#>"

        [webView].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {
        webView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalTo(0)
            $0.height.greaterThanOrEqualTo(200)
        }
    }
}
