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
    var params: [String: Any]?
    var headers: [String: String]?
    var mockData: Data?
    public init(path: String,
                params: [String: Any]? = nil,
                method: Moya.Method = .post,
                headers: [String: String]? = nil,
                mockObj: [String: Any]? = nil) {
        self.path = path
        self.method = method
        self.params = params
        self.headers = headers
        if let mockObj,
           let data = try? JSONSerialization.data(withJSONObject: mockObj, options: .prettyPrinted) {
            self.mockData = data
        }
    }
}

public protocol APIService: TargetType {
    var baseURL: URL { get }
    var parameter: APIParameter { get }
}

public extension APIService {
    // var baseURL: URL { return URL(string: baseURL)! }
    var method: Moya.Method { return parameter.method }
    var sampleData: Data { return parameter.mockData ?? Data() }
    var path: String { return parameter.path }
    var task: Task { return .requestParameters(parameters: parameter.params ?? [:], encoding: JSONEncoding.default) }
    var headers: [String: String]? {
        var param = [
            "Content-type": "application/json"
        ]
        if let t = parameter.headers {
            param = param.merging(t, uniquingKeysWith: { (current, new) in new })
        }
        return param
    }
}
