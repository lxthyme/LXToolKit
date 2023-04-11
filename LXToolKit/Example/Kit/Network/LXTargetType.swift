//
//  LXTargetType.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/21.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
import UIKit
import LXToolKit
import Foundation
import Moya

//public typealias LXAPIParameter = (method: Moya.Method = .post, path: String?, params: [String: Any]?)
struct LXAPIParameter {
    let method: Moya.Method = .post
    let path: String
    let headers: [String: String] = [:]
    let params: [String: AnyObject]
    let sampleData: [String: AnyObject] = [:]
}

protocol LXTargetType: TargetType {
    var parameters: LXAPIParameter { get }
}
// MARK: - 👀
extension LXTargetType {
    var baseURL: URL {
        return URL(string: "")!
    }
    var method: Moya.Method {
        // return parameters.method
        return .get
    }
    var path: String {
        return parameters.path
    }
    var headers: [String : String]? {
        var headers = parameters.headers
        if let token = AuthManager.shared.token {
            var tokenString = ""
            switch token.type() {
            case .basic(let token): tokenString = "Basic \(token)"
            case .oAuth(let token): tokenString = "token \(token)"
            case .personal(let token): tokenString = "token \(token)"
            case .unauthorized: break
            }
            headers["Authorization"] = tokenString
        }
        return headers
    }
    var task: Task {
        return .requestParameters(parameters: parameters.params, encoding: URLEncoding.default)
    }
    var sampleData: Data {
        let d = try? JSONSerialization.data(withJSONObject: parameters.sampleData, options: .prettyPrinted)
        return d ?? "{}".data(using: .utf8)!
    }
}

// enum API: LXTargetType {
//     case test
//     var parameters: LXAPIParameter {
//         switch self {
//             case .test:
//                 return LXAPIParameter(path: "", params: [:])
//         }
//     }
// }
