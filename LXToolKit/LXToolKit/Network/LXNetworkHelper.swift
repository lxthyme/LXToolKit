//
//  LXNetworkHelper.swift
//  Vaffle_demo
//
//  Created by LXThyme on 2019/1/2.
//  Copyright © 2019 DamonJow. All rights reserved.
//

import UIKit
import Alamofire
//import enum Result.Result
import Moya

//let LXNetworkHelper_Base_URL = "http://local.api.vaffle.com"
let LXNetworkHelper_Base_URL = "https://apitest.vaffle.com"

typealias LXRequestApi = LXService
let shouldTimeout: Bool = false
let endpointClosure = { (target: LXRequestApi) -> Endpoint in
    let URL = target.baseURL.appendingPathComponent(target.path).absoluteString
    let defaultEndPoint: Endpoint = MoyaProvider.defaultEndpointMapping(for: target)
    return defaultEndPoint
}
let failureEndpointClosure = { (target: LXService) -> Endpoint in
    let sampleResponseClosure = { () -> EndpointSampleResponse in
        if shouldTimeout {
            return .networkError(NSError())
        } else {
            return .networkResponse(200, target.sampleData)
        }
    }
    return Endpoint(url: URL(target: target).absoluteString, sampleResponseClosure: sampleResponseClosure, method: target.method, task: target.task, httpHeaderFields: target.headers)
}

let requestClosure = { (endpoint: Endpoint, closure: @escaping (Result<URLRequest, MoyaError>) -> Void) ->Void in
    do {
        let urlRequest = try endpoint.urlRequest()
        closure(.success(urlRequest))
    } catch MoyaError.requestMapping(let url) {
        closure(.failure(MoyaError.requestMapping(url)))
    } catch MoyaError.parameterEncoding(let error) {
        closure(.failure(MoyaError.parameterEncoding(error)))
    } catch {
        closure(.failure(MoyaError.underlying(error, nil)))
    }
}

let manager = { () -> Alamofire.Session in
    let configuration = URLSessionConfiguration.default
    configuration.headers = .default
    configuration.timeoutIntervalForRequest = 30 // as seconds, you can set your request timeout
    configuration.timeoutIntervalForResource = 30 // as seconds, you can set your resource timeout
    configuration.requestCachePolicy = .useProtocolCachePolicy

    let manager = Alamofire.Session(configuration: configuration)
//    manager.startRequestsImmediately = false
//    manager.startRequestsImmediately
    return manager
}()

let source = TokenSource()

//let provider = MoyaProvider<LXRequestApi>(
//    /// endpointClosure: TargetType --> EndPoint
//    endpointClosure: endpointClosure,
//    /// requestClosure: EndPoint --> URL Request
//    requestClosure: requestClosure,
//    /// stubClosure: mock data
//    stubClosure: MoyaProvider.neverStub,
//    callbackQueue: nil,
//    /// manager: 实际请求的Alamofire的SessionManager
//    manager: manager,
//    /// 插件
//    plugins: [
//        AuthPlugin(tokenClosure: { return source.token })
//    ],
//    /// 是否要跟踪重复网络请求
//    trackInflights: false
//)
let multiTargetEndpointClosure = { (target: MultiTarget) -> Endpoint in
    let URL = target.baseURL.appendingPathComponent(target.path).absoluteString
    let defaultEndPoint: Endpoint = MoyaProvider.defaultEndpointMapping(for: target)
    return defaultEndPoint
}
//let provider = MoyaProvider(
//    endpointClosure: <#T##MoyaProvider<_>.EndpointClosure##MoyaProvider<_>.EndpointClosure##(_) -> Endpoint#>,
//    requestClosure: <#T##MoyaProvider<_>.RequestClosure##MoyaProvider<_>.RequestClosure##(Endpoint, @escaping MoyaProvider<_>.RequestResultClosure) -> Void#>,
//    stubClosure: <#T##MoyaProvider<_>.StubClosure##MoyaProvider<_>.StubClosure##(_) -> StubBehavior#>,
//    callbackQueue: <#T##DispatchQueue?#>,
//    session: <#T##Session#>,
//    plugins: <#T##[PluginType]#>,
//    trackInflights: <#T##Bool#>)
let provider = MoyaProvider<MultiTarget>(
    endpointClosure: multiTargetEndpointClosure,
    requestClosure: requestClosure,
    stubClosure: MoyaProvider.neverStub,
    callbackQueue: nil,
    session: manager,
    plugins: [
        AuthPlugin(tokenClosure: { return source.token })
    ], trackInflights: false)

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

private extension String {
    var urlEscaped: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
}

final class RequestAlertPlugin: PluginType {
    private let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func willSend(_ request: RequestType, target: TargetType) { }

//    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) { }
}
