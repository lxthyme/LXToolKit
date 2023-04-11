//
//  LXApiTestVC.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/6/16.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
//import Result
import Moya
import RxSwift
import LXToolKit

class LXApiTestVC: UIViewController {
    // MARK: UI
    // MARK: Vaiables
    // MARK: Life Cycle
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

        self.title = "ApiTest"
//        loadData()
//        loadData2()
        loadData3()
    }

}

// MARK: LoadData
extension LXApiTestVC {}

// MARK: Public Actions
extension LXApiTestVC {}

// MARK: Private Actions
private extension LXApiTestVC {
    func loadData() {
        apiProvider.request(MultiTarget(LXMainProvider.newUserFloat), callbackQueue: nil, progress: nil) { result in
            switch result {
                case .success(let response):
                    print("Response: ", response)
                case .failure(let moyaError):
                    print("Error: ", moyaError)
            }
        }
    }
    func loadData2() {
//        apiProvider.req
//        apiProvider.req(target: LXMainProvider.zen, callbackQueue: nil, progress: nil) { (result) in
//            print("result: ", result)
//        }
//        apiProvider
//            .req(target: LXMainProvider.newUserFloat)
//            .mapBaseModel(LXNewUserFloatModel.self)
//            .subscribe(onNext: { model in
//                print("1. Model: ", model)
//            }, onError: { error in
//                print("2. Error: ", error)
//            }, onCompleted: {
//                print("3. completed")
//            }, onDisposed: nil)
    }
    func loadData3() {
//        apiProvider.req(target: LXMainProvider.platformInfo)
//            .mapBaseModel(LXDashboardListModel.self)
//            .subscribe(onNext: { model in
//                print("1. Model: ", model)
//            }, onError: { error in
//                print("2. Error: ", error)
//            }, onCompleted: {
//                print("3. completed")
//            }, onDisposed: nil)
    }
}

// MARK: - UI Prepare & Masonry
private extension LXApiTestVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        //[<#table#>].forEach(self.view.addSubview)
        masonry()
    }

    func masonry() {}
}
