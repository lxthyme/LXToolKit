//
//  Networking.swift
//  test
//
//  Created by lxthyme on 2023/3/26.
//

import Foundation
import Moya
import Alamofire
import RxNetworks

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
            .flatMap { _ in// Turn the online state into a network request
                return actualRequest
                    .filterSuccessfulStatusCodes()
                    .do(onSuccess: { response in
                    }, onError: { error in
                        if let error = error as? MoyaError {
                            switch error {
                            case .statusCode(let response):
                                if response.statusCode == 401 {
                                    // Unauthorized
                                    if AuthManager.shared.hasValidToken {
                                        AuthManager.removeToken()
                                        Application.shared.presentInitialScreen(in: Application.shared.window)
                                    }
                                }
                            default: break
                            }
                        }
                    })
            }
    }
}

protocol NetworkingType {
    associatedtype T: TargetType, ProductApiType
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

struct GithubNetworking: NetworkingType {
    typealias T = DJAPI
    let provider: OnlineProvider<T>

    static func defaultNetworking() -> GithubNetworking {
        return GithubNetworking(provider: newProvider(plugins))
    }
    static func stubbingNetworking() -> GithubNetworking {
        return GithubNetworking(provider: OnlineProvider(endpointClosure: endpointsClosure(),
                                                         requestClosure: GithubNetworking.endpointResolver(),
                                                         stubClosure: MoyaProvider.immediatelyStub,
                                                         online: .just(true)))
    }
    func request(_ token: T) -> Observable<Moya.Response> {
        let actualRequest = self.provider.request(token)
        return actualRequest
    }
}
struct TestFloatNetworking: NetworkingType {
    typealias T = FloatApi
    let provider: OnlineProvider<T>

    static func defaultNetworking() -> TestFloatNetworking {
        return TestFloatNetworking(provider: newProvider(plugins))
    }
    static func stubbingNetworking() -> TestFloatNetworking {
        return TestFloatNetworking(provider: OnlineProvider(endpointClosure: endpointsClosure(),
                                                         requestClosure: GithubNetworking.endpointResolver(),
                                                         stubClosure: MoyaProvider.immediatelyStub,
                                                         online: .just(true)))
    }
    func request(_ token: T) -> Observable<Moya.Response> {
        let actualRequest = self.provider.request(token)
        return actualRequest
    }
}

struct TrendingGithubNetworking: NetworkingType {
    typealias T = TrendingGithubAPI
    var provider: OnlineProvider<T>

    static func defaultNetworking() -> Self {
        return TrendingGithubNetworking(provider: newProvider(plugins))
    }
    static func stubbingNetworking() -> Self {
        return TrendingGithubNetworking(provider: OnlineProvider(endpointClosure: endpointsClosure(),
                                                                 requestClosure: TrendingGithubNetworking.endpointResolver(),
                                                                 stubClosure: MoyaProvider.immediatelyStub,
                                                                 online: .just(true)))
    }
    func request(_ token: T) -> Observable<Moya.Response> {
        let acturalRequest = self.provider.request(token)
        return acturalRequest
    }
}

struct CodetabsNetworking: NetworkingType {
    typealias T = CodetabsApi
    var provider: OnlineProvider<T>

    static func defaultNetworking() -> Self {
        return CodetabsNetworking(provider: newProvider(plugins))
    }
    static func stubbingNetworking() -> Self {
        return CodetabsNetworking(provider: OnlineProvider(endpointClosure: endpointsClosure(),
                                                           requestClosure: CodetabsNetworking.endpointResolver(),
                                                           stubClosure: MoyaProvider.immediatelyStub,
                                                           online: .just(true)))
    }
    func request(_ token: T) -> Observable<Moya.Response> {
        let actualRequest = self.provider.request(token)
        return actualRequest
    }
}

extension NetworkingType {
    static func endpointsClosure<T>(_ xAccessToken: String? = nil) -> (T) -> Endpoint where T: TargetType, T: ProductApiType {
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
        if AppConfig.Network.loggingEnabled {
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
        }
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

private func newProvider<T>(_ plugins: [PluginType], xAccessToken: String? = nil) -> OnlineProvider<T> where T: ProductApiType {
    return OnlineProvider(
        endpointClosure: GithubNetworking.endpointsClosure(xAccessToken),
        requestClosure: GithubNetworking.endpointResolver(),
        stubClosure: GithubNetworking.APIKeysBasedStubBehaviour,
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
