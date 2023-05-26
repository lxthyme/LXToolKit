//
//  APIManager.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import Moya

public enum APIManager {
    case recommend
    case search(name: String)
}

// MARK: - 👀
extension APIManager: TargetType {
    public var baseURL: URL {
        return URL(string: "")!
    }

    public var path: String {
        switch self {
            case .recommend: return ""
            case .search: return ""
        }
    }

    public var method: Moya.Method {
        switch self {
            case .recommend: return .get
            case .search: return .post
        }
    }

    public var sampleData: Data {
        return "".data(using: .utf8)!
    }

    public var task: Task {
        switch self {
            case .recommend:
                return .requestPlain
            case .search(name: let name):
                return .requestParameters(
                    parameters: ["name": name],
                    encoding: URLEncoding.default)
        }
    }

    public var headers: [String : String]? {
        return [
            "Content-Type":"application/json",
            "version":"1.0.0"
        ]
    }


}
