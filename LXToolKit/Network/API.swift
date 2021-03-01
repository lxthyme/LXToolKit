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

// MARK: - 🔥Endpoint
func makeEndpointClosure<T: TargetType>(with target: T) -> (T) -> Endpoint {
    return { (target: T) -> Endpoint in
        let defaultEndPoint = MoyaProvider.defaultEndpointMapping(for: target)
//        return defaultEndPoint
        return Endpoint(
            url: URL(target: target).absoluteString,
            sampleResponseClosure: { () -> EndpointSampleResponse in
                return shouldTimeout
                    ? .networkError(NSError())
                    : .networkResponse(200, target.sampleData)
            },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }
}
let multiTargetEndpointClosure = { (target: MultiTarget) -> Endpoint in
    let defaultEndPoint: Endpoint = MoyaProvider.defaultEndpointMapping(for: target)
    return defaultEndPoint
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
    configuration.timeoutIntervalForRequest = LX_Request_Timeout // as seconds, you can set your request timeout
    configuration.timeoutIntervalForResource = LX_Resource_Timeout // as seconds, you can set your resource timeout
    configuration.requestCachePolicy = .useProtocolCachePolicy

    let manager = Alamofire.Session(configuration: configuration)
//    manager.startRequestsImmediately = false
//    manager.startRequestsImmediately
    return manager
}()

// MARK: - 🔥Token
let source = TokenSource()

// MARK: - 🔥provider
func getProvider<T: TargetType>(with target: T) ->MoyaProvider<T> {
    return MoyaProvider<T>(
        /// endpointClosure: TargetType --> EndPoint
        endpointClosure: makeEndpointClosure(with: target),
        /// requestClosure: EndPoint --> URL Request
        requestClosure: requestClosure,
        /// stubClosure: mock data
        stubClosure: MoyaProvider.neverStub,
        callbackQueue: networkQueue,
        /// manager: 实际请求的Alamofire的SessionManager
        session: manager,
        /// 插件
        plugins: [
            AuthPlugin(tokenClosure: { return source.token })
        ],
        /// 是否要跟踪重复网络请求
        trackInflights: true
    )
}
public let apiProvider = MoyaProvider<MultiTarget>(
    endpointClosure: multiTargetEndpointClosure,
    requestClosure: requestClosure,
    stubClosure: MoyaProvider.neverStub,
    callbackQueue: networkQueue,
    session: manager,
    plugins: [
        AuthPlugin(tokenClosure: { return source.token })
    ],
    trackInflights: false
)
