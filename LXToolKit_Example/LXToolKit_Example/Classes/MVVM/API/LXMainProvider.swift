//
//  LXMainProvider.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/6/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import LXToolKit

public let LX_Base_URL = "http://172.100.13.250:3003"
enum LXMainProvider: APIService {
    static var provider: LXNetworking<LXMainProvider> {
        return AppConfig.Network.useStaging
        ? LXNetworking<LXMainProvider>.stubbingNetworking()
        : LXNetworking<LXMainProvider>.defaultNetworking()
    }
    case zen
    case newUserFloat
    case platformInfo
    var provider: LXNetworking<LXMainProvider> {
        return AppConfig.Network.useStaging
        ? LXNetworking<LXMainProvider>.stubbingNetworking()
        : LXNetworking<LXMainProvider>.defaultNetworking()
    }
    var baseURL: URL {
        return URL(string: LX_Base_URL)!
    }
    var parameter: APIParameter {
        switch self {
            case .zen:
//                return ("/api/zen", ["zen": 233])
                return APIParameter(path: "/api/zen", params: ["zen": 233])
            case .newUserFloat:
                return APIParameter(path: "/api/newuser/float", params: ["user": 234])
            case .platformInfo:
                return APIParameter(path: "/api/platform/info", params: [:])
        }
    }
}

// MARK: - 👀
extension LXNetworking where U == LXMainProvider {
    func newUserFloat() -> Single<Response> {
        return request(.newUserFloat)
            .asSingle()
    }
}
