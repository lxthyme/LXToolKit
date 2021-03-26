//
//  Response +  rx.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper
import RxSwift

// MARK: - 👀
extension ObservableType where Element == Moya.Response {
    func xlmapModel<T: BaseMappable>(_ type: T.Type) throws -> Observable<T> {
        return flatMap { response -> Observable<T> in
            guard (200...209) ~= response.statusCode else {
                throw ApiError.serverError(response: ErrorResponse(response: response))
            }
            guard let json = String(data: response.data, encoding: .utf8),
                  let model = Mapper<T>().map(JSONString: json) else {
                throw ApiError.serializeError(response: ErrorResponse(response: response))
            }
            return Observable.just(model)
        }
    }
    func mapBaseModel<T: BaseMappable>(_ type: T.Type) throws -> Observable<XLBaseModel<T>> {
        return try xlmapModel(XLBaseModel<T>.self)
            .map { model -> XLBaseModel<T> in
                switch model.code {
                    case 10000:
                    return model
                    default:
                    throw ApiError.invalidStatusCode(statusCode: model.code, msg: model.msg, tips: model.tips)
                }
            }
    }
    func mapBaseModelArray<T: BaseMappable>(_ type: T.Type) throws -> Observable<XLBaseModel<XLBaseListModel<T>>> {
        return try mapBaseModel(XLBaseListModel<T>.self)
    }
}
