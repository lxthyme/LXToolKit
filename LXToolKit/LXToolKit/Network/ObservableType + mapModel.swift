//
//  ObservableType + mapModel.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/6/18.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import HandyJSON

// MARK: - <#Title...#>
public extension ObservableType where Element == Response {
//    func mapModelArray<T: HandyJSON>(_ type: T.Type, hud: Bool = false) ->Observable<[T]> {
//        return flatMap { response -> Observable<[T]> in
//            return Observable.just(try response.mapModel(T.self))
//        }
//    }
//    func mapModel<T: HandyJSON>(_ type: T.Type) ->Observable<T> {
//        return flatMap { response -> Observable<T> in
//            return Observable.just(try response.mapModel(T.self))
//        }
//    }
    func xl_mapBaseModel<T: HandyJSON>(_ type: T.Type) ->Observable<LXBaseGenericModel<T>> {
        return flatMap { response -> Observable<LXBaseGenericModel<T>> in
            return Observable.just(try response.xl_mapModel(T.self))
//            return Observable.just(try response.mapBaseModel(T.self))
        }
    }

    func xl_mapBaseModelArray<T: HandyJSON>(_ type: T.Type) ->Observable<LXBaseListModel<T>> {
        return flatMap { response -> Observable<LXBaseListModel<T>> in
//        return flatMap { response -> Observable<LXBaseListModel<T>> in
//            let a = try response.mapModelArray(T.self)
            return Observable.just(try response.xl_mapModelArray(T.self))
//            return Observable.just(try response.mapBaseModelArray(T.self))
        }
    }
}

// MARK: - <#Title...#>
public extension Response {
    func xl_mapModel<T: HandyJSON>(_ type: T.Type) throws ->LXBaseGenericModel<T> {
        guard (200..<300) ~= statusCode else {
            throw ApiError.serverError(response: self, error: nil)
        }

        guard let json = try mapJSON() as? [String: Any],
            let baseModel = LXBaseGenericModel<T>.deserialize(from: json) else {
            throw ApiError.serializeError(response: self, error: nil)
        }

        guard baseModel.code != kLXSuccessCode else {
            throw ApiError.invalidStatusCode(statusCode: baseModel.code, tips: baseModel.errorTips)
        }

        baseModel.xl_origin_json = try? mapString()
        return baseModel
    }
    func xl_mapModelArray<T: HandyJSON>(_ type: T.Type) throws ->LXBaseListModel<T> {
        guard (200..<300) ~= statusCode else {
            throw ApiError.serverError(response: self, error: nil)
        }

        guard let json = try mapJSON() as? [String: Any],
            let baseModel = LXBaseGenericModel<LXBaseListModel<T>>.deserialize(from: json),
            let listModel = baseModel.data else {
            throw ApiError.serializeError(response: self, error: nil)
        }

        guard baseModel.code != kLXSuccessCode else {
            throw ApiError.invalidStatusCode(statusCode: baseModel.code, tips: baseModel.errorTips)
        }

        baseModel.xl_origin_json = try? mapString()
        return listModel

    }
}
