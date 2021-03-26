//
//  RestApi.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/24.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper
import Moya
import Moya_ObjectMapper
import Alamofire

typealias MoyaError = Moya.MoyaError

enum ApiError: Error {
    case offline
    case serverError(response: Moya.Response)
    case serializeError(response: Moya.Response?, error: Swift.Error?)
    case nocontent(response: ErrorResponse)
    case invalidStatusCode(statusCode: Int, msg: String, tips: String)

    var title: String {
        switch self {
            case .offline: return "无网络连接"
            case .serverError:
                return ""
            case .serializeError:
                return ""
            case .nocontent(response: let response):
                return response.message ?? ""
            case .invalidStatusCode(_, let msg, _):
                return msg
        }
    }

    var description: String {
        switch self {
            case .offline: return "您的网络开小差了, 请检查网络后重试~"
            case .serverError(let response):
                return response.debugDescription
            case .serializeError(let response, let error):
                return """
error: \(error.debugDescription)
response: \(response?.debugDescription ?? "")
"""
            case .nocontent(let response):
                return response.detail()
            case .invalidStatusCode: return ""
        }
    }
}

class RestApi: XLAPI {
    let githubProvider: GithubNetworking
    init(with githubProdivder: GithubNetworking) {
        self.githubProvider = githubProdivder
    }
}

// MARK: - 👀
extension RestApi {
    func events(page: Int) -> Single<[Event]> {
        return requestArray(.events(page: page), type: Event.self)
    }
    func repositoryEvents(owner: String, repo: String, page: Int) -> Single<[Event]> {
        return requestArray(.repositoryEvents(owner: owner, repo: repo, page: page), type: Event.self)
    }
    func userReceivedEvents(username: String, page: Int) -> Single<[Event]> {
        return requestArray(.userReceivedEvents(username: username, page: page), type: Event.self)
    }
    func userReceivedEvents2(username: String, page: Int) throws -> Single<XLBaseModel<XLBaseListModel<XLEventsModel>>> {
        return try githubProvider
            .request2(.userReceivedEvents(username: username, page: page))
            .mapBaseModelArray(XLEventsModel.self)
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
    func userPerformedEvents(username: String, page: Int) -> Single<[Event]> {
        return requestArray(.userPerformedEvents(username: username, page: page), type: Event.self)
    }
    func organizationEvents(username: String, page: Int) -> Single<[Event]> {
        return requestArray(.organizationEvents(username: username, page: page), type: Event.self)
    }
}

// MARK: - 🔐
private extension RestApi {
    func request(_ target: XLGithubAPI) -> Single<Any> {
        return githubProvider
            .request(target)
            .mapJSON()
            .observeOn(MainScheduler.instance)
            .asSingle()

    }
    func requestWithoutMapping(_ target: XLGithubAPI) -> Single<Moya.Response> {
        return githubProvider
            .request(target)
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
    func requestObject<T: BaseMappable>(_ target: XLGithubAPI, type: T.Type) -> Single<T> {
        return githubProvider
            .request(target)
            .mapObject(T.self)
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
    func requestArray<T: BaseMappable>(_ target: XLGithubAPI, type: T.Type) -> Single<[T]> {
        return githubProvider
            .request(target)
            .mapArray(T.self)
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
}
