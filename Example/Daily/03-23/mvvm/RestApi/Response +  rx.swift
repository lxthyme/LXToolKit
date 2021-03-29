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
extension ObservableType where Element == Moya.Response {
    func xlmapModel<T: HandyJSON>(_ type: T.Type) -> Observable<T> {
        return flatMap { return Observable.just(try $0.xlmapModel(T.self).0) }
    }
    func mapBaseModel<T: HandyJSON>(_ type: T.Type) -> Observable<XLBaseModel<T>> {
        return flatMap { Observable.just(try $0.mapBaseModel(T.self)) }
    }
    func mapBaseModelArray<T: HandyJSON>(_ type: T.Type) -> Observable<XLBaseModel<XLBaseListModel<T>>> {
        return flatMap { Observable.just(try $0.mapBaseModelArray(T.self))
        }
    }
}

// MARK: - 👀
extension Moya.Response {
    func xlmapModel<T: HandyJSON>(_ type: T.Type) throws -> (T, String) {
        guard (200...209) ~= statusCode else {
            throw ApiError.serverError(response: self)
        }
        guard let json = String(data: data, encoding: .utf8),
              let model = T.deserialize(from: json) else {
            throw ApiError.serializeError(response: self, error: nil)
        }
        return (model, json)
    }
    func mapBaseModel<T: HandyJSON>(_ type: T.Type) throws -> XLBaseModel<T> {
        let result = try xlmapModel(XLBaseModel<T>.self)
        let model = result.0
        model.origin_json = result.1
        switch model.code {
        case 10000:
        return model
        default:
        throw ApiError.invalidStatusCode(statusCode: model.code, msg: model.msg, tips: model.tips)
        }
    }
    func mapBaseModelArray<T: HandyJSON>(_ type: T.Type) throws -> XLBaseModel<XLBaseListModel<T>> {
        return try mapBaseModel(XLBaseListModel<T>.self)
    }
}
