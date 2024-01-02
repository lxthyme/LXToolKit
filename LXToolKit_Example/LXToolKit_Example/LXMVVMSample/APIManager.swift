//
//  APIManager.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import Moya
import RxSwift

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

    var parameters: [String: Any]? {
        var params: [String: Any] = [:]
        switch self {
            case .recommend:
                return nil
            case .search(name: let name):
                return ["name": name]
        }
    }
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    public var task: Task {
        switch self {
        case .recommend:
            return .requestPlain
        default:
            if let parameters = parameters {
                return .requestParameters(parameters: parameters, encoding: parameterEncoding)
            }
            return .requestPlain
        }
    }

    public var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "version": "1.0.0"
        ]
    }
}

// MARK: - 👀
extension APIManager: APIService {
    public static var provider: LXNetworking<APIManager> {
        return AppConfig.Network.useStaging
        ? LXNetworking<APIManager>.stubbingNetworking()
        : LXNetworking<APIManager>.defaultNetworking()
    }
    public var parameter: APIParameter {
        // RepositorySearchModel
        return APIParameter(path: path, params: parameters, method: method, headers: headers, mockObj: nil)
    }
}

extension LXNetworking where U == APIManager {
    func recommend() -> Single<Response> {
        return request(.recommend)
            .asSingle()
    }
    func search(name: String) -> Single<Response> {
        return request(.search(name: name))
            .asSingle()
    }
}
