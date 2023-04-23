//
//  APIManager.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import Moya

enum APIManager {
    case recommend
    case search(name: String)
}

// MARK: - 👀
extension APIManager: TargetType {
    var baseURL: URL {
        return URL(string: "")!
    }

    var path: String {
        switch self {
            case .recommend: return ""
            case .search: return ""
        }
    }

    var method: Moya.Method {
        switch self {
            case .recommend: return .get
            case .search: return .post
        }
    }

    var sampleData: Data {
        return "".data(using: .utf8)!
    }

    var task: Task {
        switch self {
            case .recommend:
                return .requestPlain
            case .search(name: let name):
                return .requestParameters(
                    parameters: ["name": name],
                    encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        return [
            "Content-Type":"application/json",
            "version":"1.0.0"
        ]
    }


}
