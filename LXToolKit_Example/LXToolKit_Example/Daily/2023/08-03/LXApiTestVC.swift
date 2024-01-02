//
//  LXApiTestVC.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/6/16.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
// import Result
import Moya
import RxSwift
import LXToolKit

class LXApiTestVC: LXBaseVC {
    // MARK: UI
    // MARK: Vaiables
    let provider = LXMainProvider.provider
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()

        self.title = "ApiTest"
//        loadData()
//        loadData2()
        loadData()
    }

}

// MARK: LoadData
extension LXApiTestVC {}

// MARK: Public Actions
extension LXApiTestVC {}

// MARK: Private Actions
private extension LXApiTestVC {
    func loadData() {
        provider
            .newUserFloat()
            .subscribe { response in
            // switch result {
            //     case .success(let response):
                    dlog("Response: ", response)
                // case .failure(let moyaError):
                //     print("Error: ", moyaError)
            }
            .disposed(by: rx.disposeBag)
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
        // [<#table#>].forEach(self.view.addSubview)
        masonry()
    }

    func masonry() {}
}
