//
//  Networking.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/24.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa
import Alamofire

//class OnlineProvider<Target> where Target: Moya.TargetType {
class OnlineProvider<Target> where Target: Moya.TargetType {
//    fileprivate
    let online: BehaviorRelay<Bool>
//    fileprivate
    let provider: MoyaProvider<Target>

    init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider<Target>.defaultEndpointMapping,
         requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
         stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider<Target>.neverStub,
         session: Session = MoyaProvider<Target>.defaultAlamofireSession(),
         plugins: [PluginType] = [],
         trackInflights: Bool = false,
         online: BehaviorRelay<Bool> = connectedToInternet()) {
        self.online = online
        self.provider = MoyaProvider(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, session: session, plugins: plugins, trackInflights: trackInflights)
    }

    func request(_ token: Target) -> Observable<Moya.Response> {
        let actualRequest = provider.rx.request(token)
        return online
//            .ignore(value: false)  // Wait until we're online
            .take(1)        // Take 1 to make sure we only invoke the API once.
            .flatMap { isOnline in // Turn the online state into a network request
                return actualRequest
                    .filterSuccessfulStatusCodes()
//                    .do { response in
//                        dlog("🛠1. onSuccess: ", response)
//                    }
            }
    }
}

protocol NetworkingType {
    associatedtype T: TargetType, ProductAPIType
    var provider: OnlineProvider<T> { get }

    static func defaultNetworking() -> Self
    static func stubbingNetworking() -> Self
}

struct GithubNetworking: NetworkingType {
    typealias T = XLGithubAPI
    let provider: OnlineProvider<T>

    static func defaultNetworking() -> Self {
        return GithubNetworking(provider: newProvider(plugins))
    }

    static func stubbingNetworking() -> Self {
        return GithubNetworking(
            provider: OnlineProvider(endpointClosure: endpointsClosure(),
                                     requestClosure: GithubNetworking.endpointResolver(),
                                     stubClosure: MoyaProvider.immediatelyStub,
                                     online: BehaviorRelay(value: false)))
    }

    func request(_ token: T) -> Observable<Moya.Response> {
        let actualRequest = self.provider.request(token)
        return actualRequest
    }
}
// MARK: - 👀
class XLResponse: NSObject, NSKeyedArchiverDelegate, NSKeyedUnarchiverDelegate, NSCoding {
    let statusCode: Int
    let data: Data?
    let request: URLRequest?
    let response: HTTPURLResponse?
    init(statusCode: Int, data: Data?, request: URLRequest?, response: HTTPURLResponse?) {
        self.statusCode = statusCode
        self.data = data
        self.request = request
        self.response = response
    }
    required init?(coder: NSCoder) {
        self.statusCode = coder.decodeInteger(forKey: "statusCode")
        self.data = coder.decodeObject(forKey: "data") as? Data
        self.request = coder.decodeObject(forKey: "request") as? URLRequest
        self.response = coder.decodeObject(forKey: "response") as? HTTPURLResponse
    }
    func encode(with coder: NSCoder) {
        coder.encode(statusCode, forKey: "statusCode")
        coder.encode(data, forKey: "data")
        coder.encode(request, forKey: "request")
        coder.encode(response, forKey: "response")
    }
}
extension GithubNetworking {
    func request3(_ token: T, fromCache: Bool = false, needCache: Bool = true) -> Single<Moya.Response> {
        let actualRequest = request2(token, fromCache: fromCache, needCache: needCache)
        return provider.online
//            .ignore(value: false)
            .take(1)
            .flatMap { isOnline -> Single<Moya.Response> in
                Logger.debug("isOnline: \(isOnline)")
                if !isOnline {
                }
                return actualRequest
            }
            .asSingle()

    }
    func request2(_ token: T, fromCache: Bool = false, needCache: Bool = true) -> Single<Moya.Response> {
//        let actualRequest = self.provider.request(token)
//        return actualRequest
        return Single<Moya.Response>.create { single -> Disposable in
            let cachedkey = token.cachedKey
            if fromCache,
               let data = GlobalConfig.yyCache?.object(forKey: cachedkey) as? XLResponse {
                let cachedResponse = Response(statusCode: data.statusCode, data: data.data ?? Data(), request: data.request, response: data.response)
                single(.success(cachedResponse))
            }
            if !provider.online.value {
                single(.error(ApiError.offline))
            }
            let cancelableToken = self.provider.provider.request(token) { result in
                switch result {
                case .success(let response):
                    if needCache {
                        let obj = XLResponse(statusCode: response.statusCode, data: response.data, request: response.request, response: response.response)
                        GlobalConfig.yyCache?.setObject(obj, forKey: cachedkey, with: nil)
                    }
                    single(.success(response))
                case .failure(let error):
                    single(.error(error))
                }
            }
            return Disposables.create {
                cancelableToken.cancel()
            }
        }
    }
}

extension NetworkingType {
    static func endpointsClosure<T>(_ xAccessToken: String? = nil) -> (T) -> Endpoint where T: TargetType, T: ProductAPIType {
        return { target in
            let endpoint = MoyaProvider.defaultEndpointMapping(for: target)

            // Sign all non-XApp, non-XAuth token requests
            return endpoint
        }
    }

    static func APIKeysBasedStubBehaviour<T>(_: T) -> Moya.StubBehavior {
        return .never
    }

    static var plugins: [PluginType] {
        var plugins: [PluginType] = []
        if GlobalConfig.Network.loggingEnabled == true {
            plugins.append(NetworkLoggerPlugin())
        }
        return plugins
    }

    // (Endpoint<Target>, NSURLRequest -> Void) -> Void
    static func endpointResolver() -> MoyaProvider<T>.RequestClosure {
        return { (endpoint, closure) in
            do {
                var request = try endpoint.urlRequest() // endpoint.urlRequest
                request.httpShouldHandleCookies = false
                closure(.success(request))
            } catch {
                Logger.error("🛠endpointResolver: \(error.localizedDescription)")
            }
        }
    }
}

private func newProvider<T>(_ plugins: [PluginType], xAccessToken: String? = nil) -> OnlineProvider<T> where T: ProductAPIType {
    return OnlineProvider(endpointClosure: GithubNetworking.endpointsClosure(xAccessToken),
                          requestClosure: GithubNetworking.endpointResolver(),
                          stubClosure: GithubNetworking.APIKeysBasedStubBehaviour,
                          plugins: plugins)
}

// MARK: - Provider support

func stubbedResponse(_ filename: String) -> Data! {
    @objc class TestClass: NSObject { }

    let bundle = Bundle(for: TestClass.self)
    let path = bundle.path(forResource: filename, ofType: "json")
    return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
}

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}
