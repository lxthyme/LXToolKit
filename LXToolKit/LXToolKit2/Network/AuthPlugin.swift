//
//  AuthPlugin.swift
//  Vaffle_demo
//
//  Created by LXThyme on 2019/1/10.
//  Copyright © 2019 DamonJow. All rights reserved.
//

import Foundation
import Moya
import CryptoSwift

class TokenSource {
    var token: String?
    init() {}
}
protocol AuthorizedTargetType: TargetType {
    var needAuth: Bool { get }
}

struct AuthPlugin: PluginType {
    let tokenClosure: () ->String?
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard let t = target as? AuthorizedTargetType,
            t.needAuth,
            let token_t = tokenClosure() else { return request }
        var newRequest = request
        let timestamp = Date.nowTimeStamp
        let token = token_t + "\(timestamp)" + NSUUID().uuidString
//        token = token.md5().uppercased()
        newRequest.addValue(token, forHTTPHeaderField: "token233")
        return newRequest
    }
}
