//
//  Response +  rx.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Moya
import HandyJSON
import RxSwift

// MARK: - 👀
extension PrimitiveSequence where Trait == SingleTrait, Element == Moya.Response {
    func xlmapModel<T: HandyJSON>(_ type: T.Type) -> Single<T> {
        return flatMap { response in response.xlmapModel(T.self).flatMap { .just($0.0) } }
    }
    func mapBaseModel<T: HandyJSON>(_ type: T.Type) -> Single<XLBaseModel<T>> {
        return flatMap { $0.mapBaseModel(T.self) }
    }
    func mapBaseModelArray<T: HandyJSON>(_ type: T.Type) -> Single<XLBaseModel<XLBaseListModel<T>>> {
        return flatMap { $0.mapBaseModelArray(T.self) }
    }
}

// MARK: - 👀
extension Moya.Response {
    func xlmapModel<T: HandyJSON>(_ type: T.Type) -> Single<(T, String)> {
        guard (200...209) ~= statusCode else {
            return .error(ApiError.serverError(response: self))
        }
        guard let json = String(data: data, encoding: .utf8),
              let model = T.deserialize(from: json) else {
            return .error(ApiError.serializeError(response: self, error: nil))
        }
        return .just((model, json))
    }
    func mapBaseModel<T: HandyJSON>(_ type: T.Type) -> Single<XLBaseModel<T>> {
        return xlmapModel(XLBaseModel<T>.self)
            .flatMap { result -> Single<XLBaseModel<T>> in
                let model = result.0
                model.origin_json = result.1
                switch model.code {
                case 10000:
                    return .just(model)
                default:
                    return .error(ApiError.invalidStatusCode(statusCode: model.code, msg: model.msg, tips: model.tips))
                }
            }

    }
    func mapBaseModelArray<T: HandyJSON>(_ type: T.Type) -> Single<XLBaseModel<XLBaseListModel<T>>> {
        return mapBaseModel(XLBaseListModel<T>.self)
    }
}
