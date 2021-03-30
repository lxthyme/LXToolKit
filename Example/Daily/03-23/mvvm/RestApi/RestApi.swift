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
import HandyJSON
import Moya
import Alamofire

typealias MoyaError = Moya.MoyaError

enum ApiError: Error {
    case offline
    case serverError(response: Moya.Response?)
    case serializeError(response: Moya.Response?, error: Swift.Error?)
    case nocontent(response: ErrorResponse?)
    case invalidStatusCode(statusCode: Int, msg: String, tips: String)

    var identifier: String {
        switch self {
        case .offline: return "offline"
        case .serverError: return "serverError"
        case .serializeError: return "serializeError"
        case .nocontent: return "nocontent"
        case .invalidStatusCode(let statusCode, let msg, let tips):
            return "\(statusCode): \(msg)<->\(tips)"
        }
    }
    var title: String {
        switch self {
        case .offline: return "无网络连接"
        case .serverError:
            return ""
        case .serializeError:
            return ""
        case .nocontent(let response):
            return response?.message ?? ""
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
            return response?.detail() ?? ""
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
    func events(page: Int) -> Single<XLBaseModel<XLBaseListModel<XLEventsModel>>> {
        return requestArray(.events(page: page), type: XLEventsModel.self)
    }
    func repositoryEvents(owner: String, repo: String, page: Int) -> Single<XLBaseModel<XLBaseListModel<XLEventsModel>>> {
        return requestArray(.repositoryEvents(owner: owner, repo: repo, page: page), type: XLEventsModel.self)
    }
//    func userReceivedEvents(username: String, page: Int) -> Observable<XLBaseModel<XLBaseListModel<XLEventsModel>>> {
//        return requestArray(.userReceivedEvents(username: username, page: page), type: XLEventsModel.self)
//    }
    func userReceivedEvents(username: String, page: Int) -> Single<XLBaseModel<XLBaseListModel<XLEventsModel>>> {
        return githubProvider
            .request2(.userReceivedEvents(username: username, page: page))
            .mapBaseModelArray(XLEventsModel.self)
            .observeOn(MainScheduler.instance)
//            .asSingle()
    }
    func userPerformedEvents(username: String, page: Int) -> Single<XLBaseModel<XLBaseListModel<XLEventsModel>>> {
        return requestArray(.userPerformedEvents(username: username, page: page), type: XLEventsModel.self)
    }
    func organizationEvents(username: String, page: Int) -> Single<XLBaseModel<XLBaseListModel<XLEventsModel>>> {
        return requestArray(.organizationEvents(username: username, page: page), type: XLEventsModel.self)
    }
}

// MARK: - 🔐
private extension RestApi {
    func request(_ target: XLGithubAPI) -> Single<XLAnyModel> {
        return githubProvider
            .request2(target)
            .mapModel(XLAnyModel.self)
            .observeOn(MainScheduler.instance)

    }
    func requestWithoutMapping(_ target: XLGithubAPI) -> Single<Moya.Response> {
        return githubProvider
            .request2(target)
            .observeOn(MainScheduler.instance)
    }
    func requestObject<T: HandyJSON>(_ target: XLGithubAPI, type: T.Type) -> Single<XLBaseModel<T>> {
        return githubProvider
            .request2(target)
            .mapBaseModel(T.self)
            .observeOn(MainScheduler.instance)
//            .asSingle()
    }
    func requestArray<T: HandyJSON>(_ target: XLGithubAPI, type: T.Type) -> Single<XLBaseModel<XLBaseListModel<T>>> {
        return githubProvider
            .request2(target)
            .mapBaseModelArray(T.self)
            .observeOn(MainScheduler.instance)
//            .asSingle()
    }
}
