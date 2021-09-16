//
//  Service.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2020/12/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import HandyJSON

protocol BaseApi {
    var method: HTTPMethod { get set }
    var path: String { get }
    var params: [String: Any] { get set }
    var headers: HTTPHeaders { get set }
}
extension BaseApi {
    var method: HTTPMethod { return .post }
    var params: [String: Any] { return [:] }
    var headers: HTTPHeaders {
        return HTTPHeaders([HTTPHeader(name: "Content-Type", value: "application/json")])
    }
}

class RxProvider {
    static let shared = RxProvider()
    private init() {}
}
// MARK: - 👀
extension RxProvider: ReactiveCompatible { }

protocol RxRequestTarget {
    associatedtype Input
    associatedtype Output
    var input: Input { get }
    var output: Output { get }
    var disposeBag: DisposeBag { get }
}


private var manager: Alamofire.Session = {
    let config = URLSessionConfiguration.default
    config.timeoutIntervalForRequest = 30
    config.timeoutIntervalForResource = 30
//        Alamofire.SessionManager.default.delegate.taskWillPerformHTTPRedirection = nil
    return Alamofire.Session(configuration: config
//                                 delegate: <#T##SessionDelegate#>,
//                                 rootQueue: <#T##DispatchQueue#>,
//                                 startRequestsImmediately: <#T##Bool#>,
//                                 requestQueue: <#T##DispatchQueue?#>,
//                                 serializationQueue: <#T##DispatchQueue?#>,
//                                 interceptor: <#T##RequestInterceptor?#>,
//                                 serverTrustManager: <#T##ServerTrustManager?#>,
//                                 redirectHandler: <#T##RedirectHandler?#>,
//                                 cachedResponseHandler: <#T##CachedResponseHandler?#>,
//                                 eventMonitors: <#T##[EventMonitor]#>
    )
}()

// MARK: - 👀
extension Reactive where Base: RxProvider {
    func req(api: BaseApi) ->Single<Any> {
        return Single.create { (single) -> Disposable in
            let cancelable = manager
                .request(api.path,
                         method: api.method,
                         parameters: api.params,
                         encoding: URLEncoding.default,
                         headers: api.headers
//                         interceptor: <#T##RequestInterceptor?#>,
//                         requestModifier: <#T##Session.RequestModifier?##Session.RequestModifier?##(inout URLRequest) throws -> Void#>
                         )
                .responseData { response in
                    switch response.result {
                        case .success(let data):
                            if let obj = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] {
                                var code = 999
                                if let c = obj["code"] as? Int {
                                    code = c
                                }
                                switch code {
                                    case 0, 10000:
                                        single(.success(obj))
                                    /// token 失效
                                    case 3005:
                                        break
                                    default:
//                                        Toast
                                        break
                                }
                            } else {
                                single(.error(LXNetworkError.invalidJSON))
                            }
                        case .failure(let error):
                            single(.error(LXNetworkError.invalidHTTPCode))
                    }
                }

            return Disposables.create {
                cancelable.cancel()
            }
        }
    }
}
