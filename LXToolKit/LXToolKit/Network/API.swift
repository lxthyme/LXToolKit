//
//  API.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/6/16.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import Alamofire
import HandyJSON

typealias LXRequestApi = LXService

enum RxMoyaError: Error {
    case unknown
    case error(error: Error)
    case badService
    case unReachable
    case codeInvalid(code: Int?, data: HandyJSON?, tips: String?, msg: String?)
    case invalidJSON
}
// MARK: - 🔥Endpoint
let endpointClosure = { (target: LXRequestApi) -> Endpoint in
    let URL = target.baseURL.appendingPathComponent(target.path).absoluteString
    let defaultEndPoint: Endpoint = MoyaProvider.defaultEndpointMapping(for: target)
    return defaultEndPoint
}
let multiTargetEndpointClosure = { (target: MultiTarget) -> Endpoint in
    let URL = target.baseURL.appendingPathComponent(target.path).absoluteString
    let defaultEndPoint: Endpoint = MoyaProvider.defaultEndpointMapping(for: target)
    return defaultEndPoint
}
//let endpointClosure = { (service: APIService) -> Endpoint in
//    return Endpoint(
//        url: URL(target: service).absoluteString,
//        sampleResponseClosure: { () -> EndpointSampleResponse in
//            return .networkResponse(200, service.sampleData)
//    },
//        method: service.method,
//        task: service.task,
//        httpHeaderFields: service.headers)
//}

//let failureEndpointClosure = { (target: LXBaseApiProvider) ->Endpoint in
//    let sampleResponseClosure = { () ->EndpointSampleResponse in
//        return shouldTimeout ? .networkError(NSError()) : .networkResponse(200, target.sampleData)
//    }
//    return Endpoint(
//        url: URL(target: target).absoluteString,
//        sampleResponseClosure: sampleResponseClosure,
//        method: target.method,
//        task: target.task,
//        httpHeaderFields: target.headers)
//}
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

// MARK: - 🔥manager
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

// MARK: - 🔥Token
let source = TokenSource()

// MARK: - 🔥provider
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
