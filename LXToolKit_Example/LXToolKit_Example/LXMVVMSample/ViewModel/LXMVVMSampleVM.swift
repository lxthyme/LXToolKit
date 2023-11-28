//
//  LXMVVMSampleVM.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
import Foundation
import Moya
import RxSwift
import HandyJSON
import LXToolKit
import RxCocoa
import RxRelay

class LXMVVMSampleVM: LXBaseViewModel {

    func requestRecome(completed: @escaping (_ model: LXResultModel) ->Void) {
//        provider.request(.recommend) { result in
//            switch result {
//                case .success(let response):
//                    do {
//                        if let model = JSONDeserializer<LXResultModel>.deserializeFrom(json: try response.mapString()) {
//                            ///
//                            dlog(model)
//                        }
//                    } catch {
//                        dlog(error)
//                }
//                case .failure(let error):
//                    dlog(error)
//            }
//        }
//        provider.rx
        let pp = MoyaProvider<APIManager>()
    }

    func search(name: String) {
        provider.request(.search(name: "李白")) { result in
            switch result {
                case .success(let response):
                    do {
                        let json = try response.mapJSON() as? NSDictionary ?? [:]
                        dlog(json)
                    } catch {
                        dlog(error)
                }
                case .failure(let error):
                    dlog(error)
            }
        }
    }
}
