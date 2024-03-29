//
//  LXDaily1117VC.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2020/11/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Moya
import LXToolKit
import SnapKit

class LXDaily1117VC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
        test02()
    }

}

// MARK: 🌎LoadData
extension LXDaily1117VC {}

// MARK: 👀Public Actions
extension LXDaily1117VC {}

typealias APIParameterTester = (path: String, method: Moya.Method, params: [String: Any]?)

// MARK: 🔐Private Actions
private extension LXDaily1117VC {
    func test() {
//        let _: APIParameterTester = (path: "", method: .post, params: [:])
//        _ = APIParameter(path: "", method: .post, params: [:])
//        _ = APIParameter(path: "", params: [:])
//        _ = APIParameter(path: "", params: nil)
//        _ = APIParameter(path: "", params: nil, headers: [:], mockObj: [:])
    }
    func test02() {
        // let cell = LXBaseTableCell(style: .default, reuseIdentifier: LXBaseTableCell.XL.reuseIdentifier)
        // dlog("1.")
        // cell.baseModel = LXAnyModel()
        // dlog("2.")
        // cell.baseModel = nil
        // dlog("3.")
        // cell.baseModel = LXAnyModel()
    }

    func test03() {
        _ = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        _ = UIColor.XL.rgba(red: 1, green: 1, blue: 1, transparency: 1)
        _ = UIColor.XL.random
        self.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
//        DispatchQueue.xl.lx
        _ = DispatchQueue.XL.background
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXDaily1117VC {
    func prepareUI() {
        self.view.backgroundColor = UIColor.white
        // self.title = "<#title#>"

        // [<#table#>].forEach(self.view.addSubview)
        masonry()
    }

    func masonry() {}
}
