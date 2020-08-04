//
//  LXBaseApiProvider.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/6/16.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Moya
import RxSwift
//import HandyJSON
import LXToolKit


let apiProvider = MoyaProvider<MultiTarget>(
//    endpointClosure: MoyaProvider.defaultEndpointMapping,
//    endpointClosure: endpointClosure,
//    requestClosure: MoyaProvider<MultiTarget>.defaultRequestMapping,
//    stubClosure: MoyaProvider.delayedStub(1),
//    callbackQueue: nil,
//    manager: MoyaProvider<MultiTarget>.defaultAlamofireManager(),
    plugins: [
        networkPlugin
    ]
//    trackInflights: false
)

enum LXApiProvider2 {
    case zen
}

extension LXApiProvider2: APIService2 {
    var path: String {
        switch self {
            case .zen:
            return ""
        }
    }
    var params: [String : Any]? {
        switch self {
            case .zen:
                return [:]
        }
    }
}
