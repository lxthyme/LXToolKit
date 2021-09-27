//
//  APIService.swift
//  Alamofire
//
//  Created by LXThyme Jason on 2020/9/28.
//

import Foundation
import Moya

public struct APIParameter {
    var path: String
    var method: Moya.Method
    var params: [String: Any]
    var headers: [String: String]
    var mockObj: [String: Any]
    fileprivate var mockData: Data
    public init(path: String,
                params: [String: Any]?,
                method: Moya.Method = .post,
                headers: [String: String] = ["Content-type": "application/json"],
                mockObj: [String: Any] = [:]) {
        self.path = path
        self.method = method
        self.params = params ?? [:]
        self.headers = headers
        self.mockObj = mockObj
        if let data = try? JSONSerialization.data(withJSONObject: self.mockObj, options: .prettyPrinted) {
            self.mockData = data
        } else if let data = "{\"code\":233,\"data\":{}}".data(using: .utf8){
            self.mockData = data
        } else {
            self.mockData = Data()
        }
    }
}

public protocol APIService: TargetType {
    var baseURL: String { get }
    var params: APIParameter { get }
}

public extension APIService {
    var baseURL: URL { return URL(string: baseURL)! }
    var method: Moya.Method { return params.method }
    var sampleData: Data { return params.mockData }
    var path: String { return params.path }
    var task: Task { return .requestParameters(parameters: params.params, encoding: JSONEncoding.default) }
    var headers: [String: String]? { return params.headers }
}
