//
//  RestApi.swift
//  test
//
//  Created by lxthyme on 2023/3/26.
//

import Foundation
import Moya
import Moya_ObjectMapper
import Alamofire
import HandyJSON

// public typealias MoyaError = Moya.MoyaError

class RestApi {
    let githubProvider: LXNetworking<GithubAPI>
    let trendingGithubProvider: LXNetworking<TrendingGithubAPI>
    let codetabsProvider: LXNetworking<CodetabsApi>

    init(githubProvider: LXNetworking<GithubAPI>, trendingGithubProvider: LXNetworking<TrendingGithubAPI>, codetabsProvider: LXNetworking<CodetabsApi>) {
        self.githubProvider = githubProvider
        self.trendingGithubProvider = trendingGithubProvider
        self.codetabsProvider = codetabsProvider
    }
}

private extension RestApi {
    func request(_ target: GithubAPI) -> Single<Any> {
        return githubProvider.request(target)
            .mapJSON()
            .observe(on: MainScheduler.instance)
            .asSingle()
    }
    func requestWithoutMapping(_ target: GithubAPI) -> Single<Moya.Response> {
        return githubProvider.request(target)
            .observe(on: MainScheduler.instance)
            .asSingle()
    }
    func reqeustObject<T: HandyJSON>(_ target: GithubAPI, type: T.Type) -> Single<T> {
        return githubProvider.request(target)
            .mapHandyJSON(T.self)
            .observe(on: MainScheduler.instance)
            .asSingle()
    }
    func requestArray<T: HandyJSON>(_ target: GithubAPI, type: T.Type) -> Single<[T]> {
        return githubProvider.request(target)
            .mapHandyJSONArray(T.self)
            .observe(on: MainScheduler.instance)
            .asSingle()
    }
}

private extension RestApi {
    func trendingRequestObject<T: HandyJSON>(_ target: TrendingGithubAPI, type: T.Type) -> Single<T> {
        return trendingGithubProvider.request(target)
            .mapHandyJSON(T.self)
            .observe(on: MainScheduler.instance)
            .asSingle()
    }
    func trendingRequestArray<T: HandyJSON>(_ target: TrendingGithubAPI, type: T.Type) -> Single<[T]> {
        return trendingGithubProvider.request(target)
            .mapHandyJSONArray(T.self)
            .observe(on: MainScheduler.instance)
            .asSingle()
    }
}

private extension RestApi {
    func codetabsRequestArray<T: HandyJSON>(_ target: CodetabsApi, type: T.Type) -> Single<[T]> {
        return codetabsProvider.request(target)
            .mapHandyJSONArray(T.self)
            .observe(on: MainScheduler.instance)
            .asSingle()
    }
}

// extension RestApi: DJAllAPI {
//     func downloadString(url: URL) -> Single<String> {
//         return Single.create { single in
//             DispatchQueue.global().async {
//                 do {
//                     single(.success(try String(contentsOf: url)))
//                 } catch {
//                     single(.failure(error))
//                 }
//             }
//             return Disposables.create {}
//         }
//         .observe(on: MainScheduler.instance)
//     }
//     func searchRepositories(query: String, sort: String, order: String, page: Int, endCursor: String?) -> Single<RepositorySearchModel> {
//         return reqeustObject(.searchRepositories(query: query, sort: sort, order: order, page: page), type: RepositorySearchModel.self)
//     }
//     func searchUsers(query: String, sort: String, order: String, page: Int, endCursor: String?) -> Single<UserSearchModel> {
//         return reqeustObject(.searchUsers(query: query, sort: sort, order: order, page: page), type: UserSearchModel.self)
//     }
//     func trendingRepositories(language: String, since: String) -> Single<[TrendingRepositoryModel]> {
//         return trendingRequestArray(.trendingRespositories(language: language, since: since), type: TrendingRepositoryModel.self)
//     }
//     func trendingDevelopers(language: String, since: String) -> Single<[TrendingUserModel]> {
//         return trendingRequestArray(.trendingDevelopers(language: language, since: since), type: TrendingUserModel.self)
//     }
//     func languages() -> Single<[LanguageModel]> {
//         return trendingRequestArray(.languages, type: LanguageModel.self)
//     }
// }
