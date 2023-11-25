//
//  Networking.swift
//  test
//
//  Created by lxthyme on 2023/3/26.
//

import Foundation
import Moya
import Alamofire
import RxSwift
import HandyJSON

class OnlineProvider<Target> where Target: Moya.TargetType {
    // MARK: 🔗Vaiables
    fileprivate let online: Observable<Bool>
    fileprivate let provider: MoyaProvider<Target>

    init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider<Target>.defaultEndpointMapping,
         requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
         stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider<Target>.neverStub,
         session: Session = MoyaProvider<Target>.defaultAlamofireSession(),
         plugins: [PluginType] = [],
         trackInflights: Bool = false,
         online: Observable<Bool> = connectedToInternet()) {
        self.online = online
        self.provider = MoyaProvider(endpointClosure: endpointClosure,
                                     requestClosure: requestClosure,
                                     stubClosure: stubClosure,
                                     session: session,
                                     plugins: plugins,
                                     trackInflights: trackInflights)
    }
    func request(_ token: Target) -> Observable<Moya.Response> {
        let actualRequest = provider.rx.request(token)
        return online.ignore(value: false)// Wait until we're online
            .take(1)// Take 1 to make sure we only invoke the API once.
            .observe(on: MainScheduler.instance)
            .flatMap { _ in// Turn the online state into a network request
                return actualRequest
                    .filterSuccessfulStatusCodes()
                    // .do(onSuccess: { response in
                    // }, onError: { error in
                    //     if let error = error as? MoyaError {
                    //         switch error {
                    //         case .statusCode(let response):
                    //             if response.statusCode == 401 {
                    //                 // Unauthorized
                    //                 if AuthManager.shared.hasValidToken {
                    //                     AuthManager.removeToken()
                    //                     Application.shared.presentInitialScreen(in: Application.shared.window)
                    //                 }
                    //             }
                    //         default: break
                    //         }
                    //     }
                    // })
            }
    }
}

protocol NetworkingType {
    associatedtype T: TargetType
    var provider: OnlineProvider<T> { get }

    static func defaultNetworking() -> Self
    static func stubbingNetworking() -> Self
}

// MARK: - 🔐
extension NetworkingType {
    static func defaultEntryDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        return formatter
    }
}
public struct LXNetworking<U: TargetType>: NetworkingType {
    public typealias T = U
    let provider: OnlineProvider<T>

    public static func defaultNetworking() -> LXNetworking {
        return LXNetworking(provider: newProvider(plugins))
    }
    public static func stubbingNetworking() -> LXNetworking {
        return LXNetworking(provider: OnlineProvider(endpointClosure: endpointsClosure(),
                                                     requestClosure: LXNetworking.endpointResolver(),
                                                     stubClosure: MoyaProvider.immediatelyStub,
                                                     online: .just(true)))
    }
    public func request(_ token: T) -> Observable<Moya.Response> {
        let actualRequest = self.provider.request(token)
        return actualRequest
    }
}

// MARK: - 👀
extension LXNetworking {
    func request2(_ target: T) -> Single<Any> {
        return request(target)
            .mapJSON()
            .observe(on: MainScheduler.instance)
            .asSingle()
    }
    func requestWithoutMapping(_ target: T) -> Single<Moya.Response> {
        return request(target)
            .observe(on: MainScheduler.instance)
            .asSingle()
    }
    func reqeustObject<Model: HandyJSON>(_ target: T, type: Model.Type) -> Single<Model> {
        return request(target)
            .mapHandyJSON(Model.self)
            .observe(on: MainScheduler.instance)
            .asSingle()
    }
    func requestArray<Model: HandyJSON>(_ target: T, type: Model.Type) -> Single<[Model]> {
        return request(target)
            .mapHandyJSONArray(Model.self)
            .observe(on: MainScheduler.instance)
            .asSingle()
    }
}

extension NetworkingType {
    static func endpointsClosure<T>(_ xAccessToken: String? = nil) -> (T) -> Endpoint where T: TargetType {
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
        // if AppConfig.Network.loggingEnabled {
        //     let formatter = NetworkLoggerPlugin.Configuration.Formatter { identifier, message, target in
        //         let date = defaultEntryDateFormatter().string(from: Date())
        //         return "Moya_Logger: [\(date)] \(identifier): \(message)"
        //     } requestData: { data in
        //         dlog("requestData")
        //         return  String(data: data, encoding: .utf8) ?? "## Cannot map data to String ##"
        //     } responseData: { data in
        //         dlog("responseData")
        //         return  String(data: data, encoding: .utf8) ?? "## Cannot map data to String ##"
        //     }
        //     
        //     let opt: NetworkLoggerPlugin.Configuration.LogOptions = [
        //         .requestMethod,
        //         .requestHeaders,
        //         .requestBody,
        //         .formatRequestAscURL,
        //         .successResponseBody,
        //         .errorResponseBody,
        //     ]
        //     let config = NetworkLoggerPlugin.Configuration(formatter: formatter,
        //                                                    output: { target, items in
        //         for item in items {
        //             Swift.print(item, separator: ",", terminator: "\n")
        //         }
        //     }, logOptions: opt)
        //     plugins.append(NetworkLoggerPlugin(configuration: config))
            plugins.append(LXNetworkDebuggingPlugin())
        // }
        return plugins
    }
    static func endpointResolver() -> MoyaProvider<T>.RequestClosure {
        return { (endpoint, closure) in
            do {
                var request = try endpoint.urlRequest()
                request.httpShouldHandleCookies = false
                closure(.success(request))
            } catch {
                logError(error.localizedDescription)
            }
        }
    }
}

private func newProvider<T>(_ plugins: [PluginType]) -> OnlineProvider<T> where T: TargetType {
    return OnlineProvider(
        endpointClosure: LXNetworking<T>.endpointsClosure(),
        requestClosure: LXNetworking<T>.endpointResolver(),
        stubClosure: LXNetworking<T>.APIKeysBasedStubBehaviour,
        plugins: plugins
    )
}

func stubbedResponse(_ filename: String) -> Data! {
    @objc class TestClass: NSObject {}

    let bundle = Bundle(for: TestClass.self)
    let path = bundle.path(forResource: filename, ofType: "json")
    return try? Data(contentsOf: URL(fileURLWithPath: path!))
}

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}
