//
//  APIService2.swift
//  Alamofire
//
//  Created by LXThyme Jason on 2020/9/28.
//

import Foundation
import Moya

public protocol APIService2: TargetType {
//    associatedtype ResultType: SomeJSONDecodableProtocolConformance
    var params: [String: Any]? { get }
}

public extension APIService2 {
    var baseURL: URL { return URL(string: "")! }
    var headers: [String: String]? { return ["Content-type": "application/json"] }
    var method: Moya.Method { return .post }
    var task: Task { return .requestParameters(parameters: params ?? [:], encoding: JSONEncoding.default) }
    var sampleData: Data { return "{}".data(using: .utf8)! }
}
