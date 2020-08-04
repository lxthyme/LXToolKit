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

enum RxMoyaError: Error {
    case unknown
    case error(error: Error)
    case badService
    case unReachable
    case codeInvalid(code: Int?, data: HandyJSON?, tips: String?, msg: String?)
    case invalidJSON
}

public typealias APIParameter = (String?, [String: Any]?)
public protocol APIService: TargetType {
    var params: APIParameter? { get }
}

public protocol APIService2: TargetType {
//    associatedtype ResultType: SomeJSONDecodableProtocolConformance
    var params: [String: Any]? { get }
}

public extension APIService {
    var baseURL: URL { return URL(string: LX_Base_URL)! }
    var method: Moya.Method { return .post }
    var sampleData: Data { return "{\"code\":233,\"data\":{\"a\":1,\"b\":\"2\",\"c\":3}}".data(using: .utf8)! }
    var path: String { return params?.0 ?? "" }
    var task: Task { return .requestParameters(parameters: params?.1 ?? [:], encoding: JSONEncoding.default) }
    var headers: [String : String]? { return ["Content-type": "application/json"] }
}

public extension APIService2 {
    var baseURL: URL { return URL(string: "")! }
    var headers: [String : String]? { return ["Content-type": "application/json"] }
    var method: Moya.Method { return .post }
    var task: Task { return .requestParameters(parameters: params ?? [:], encoding: JSONEncoding.default) }
    var sampleData: Data { return "{}".data(using: .utf8)! }
}

// MARK: - <#Title...#>
public extension MoyaProvider {
    func req(target: TargetType,
             callbackQueue: DispatchQueue? = DispatchQueue.init(label: LX_Request_Queue_label),
             progress: ProgressBlock? = nil,
             completion: Completion? = nil) ->Observable<Moya.Response> {
        return Observable.create { [weak self]observer -> Disposable in
            guard let `self` = self else {
                observer.onError(RxMoyaError.unknown)
                return Disposables.create()
            }
            if let isReachable = NetworkReachabilityManager()?.isReachable, !isReachable {
                observer.onError(RxMoyaError.unReachable)
            }

            let cancellableToken = self.request(
                MultiTarget(target) as! Target,
                callbackQueue: callbackQueue,
                progress: progress) { result in
                    switch result {
                        case .failure(let error):
                            if let isReachable = NetworkReachabilityManager()?.isReachable, !isReachable {
                                observer.onError(RxMoyaError.unReachable)
                            } else {
                                observer.onError(RxMoyaError.error(error: error))
                        }
                        case .success(let response):
                            observer.onNext(response)
                            observer.onCompleted()
                    }
            }
            return Disposables.create {
                cancellableToken.cancel()
            }
        }
    }
}
