//
//  LXUserProvider.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/6/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import LXToolKit

enum LXUserProvider: APIService {
    case newUserFloat
    var provider: LXNetworking<LXUserProvider> {
        return AppConfig.Network.useStaging
        ? LXNetworking<LXUserProvider>.stubbingNetworking()
        : LXNetworking<LXUserProvider>.defaultNetworking()
    }
    var baseURL: URL {
        return URL(string: LX_Base_URL)!
    }
    var parameter: APIParameter {
        switch self {
            case .newUserFloat:
                return APIParameter(path: "/api/newuser/float", params: ["user": 234])
        }
    }
}
