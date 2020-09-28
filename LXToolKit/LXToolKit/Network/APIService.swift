//
//  APIService.swift
//  Alamofire
//
//  Created by LXThyme Jason on 2020/9/28.
//

import Foundation
import Moya

enum LXService {
    case example
    case example2(id: Int)
    case example3(id: Int)
}

extension LXService: TargetType {
    var baseURL: URL { return URL(string: LXNetworkHelper_Base_URL)! }

    var path: String {
        switch self {
        case .example:
            return "/example"
        case .example2(let id):
            return "example2/\(id)"
        case .example3(let id):
            return "example3/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .example:
            return .get
        case .example2:
            return .post
        case .example3:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .example:
            return .requestPlain
        case .example2(let id):
            return .requestParameters(parameters: ["id": id], encoding: JSONEncoding.default)
        case .example3(let id):
            return .requestParameters(parameters: ["id": id], encoding: URLEncoding.queryString)
        }
    }

    var sampleData: Data {
        switch self {
        case .example:
            return "Half measures are as bad as nothing at all.".data(using: .utf8)!
        case .example2(let id):
            return "{\"id\": \(id), \"first_name\": \"Harry\", \"last_name\": \"Potter\"}".data(using: .utf8)!
        case .example3(let id):
            return "{\"id\": \(id), \"first_name\": \"Harry\", \"last_name\": \"Potter\"}".data(using: .utf8)!
        }
    }

    var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
        ]
    }

}


public typealias APIParameter = (String?, [String: Any]?)
public protocol APIService: TargetType {
    var params: APIParameter? { get }
}

public extension APIService {
    var baseURL: URL { return URL(string: LX_Base_URL)! }
    var method: Moya.Method { return .post }
    var sampleData: Data { return "{\"code\":233,\"data\":{\"a\":1,\"b\":\"2\",\"c\":3}}".data(using: .utf8)! }
    var path: String { return params?.0 ?? "" }
    var task: Task { return .requestParameters(parameters: params?.1 ?? [:], encoding: JSONEncoding.default) }
    var headers: [String: String]? { return ["Content-type": "application/json"] }
}
