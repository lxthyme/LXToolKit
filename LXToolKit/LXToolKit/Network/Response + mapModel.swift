//
//  Response + mapModel.swift
//  Vaffle_demo
//
//  Created by LXThyme on 2019/1/8.
//  Copyright © 2019 DamonJow. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import HandyJSON
import Alamofire

public extension ObservableType where Element == Response {
//    func mapBaseModel<T: HandyJSON>(_ type: T.Type) ->Observable<LXBaseModel<T>> {
//        return flatMap { response ->Observable<LXBaseModel<T>> in
//            let ele: LXBaseModel<T> = try response.mapBaseModel(T.self)
//            return Observable.just(ele)
//        }
//    }
//
//    func mapBaseModelArray<T: HandyJSON>(_ type: T.Type) ->Observable<LXBaseModel<LXBaseListModel<T>>> {
//        return flatMap { response ->Observable<LXBaseModel<LXBaseListModel<T>>> in
//            return Observable.just(try response.mapBaseModelArray(T.self))
//        }
//    }
}

extension Response {
    func xl_mapBaseModel<T: HandyJSON>(_ type: T.Type) throws ->LXBaseGenericModel<T> {
        let jsonString = String(data: data, encoding: .utf8)

        guard let baseModel = JSONDeserializer<LXBaseGenericModel<T>>.deserializeFrom(json: jsonString) else {
            throw ApiError.serializeError(response: nil, error: nil)
        }

        guard baseModel.code == kLXSuccessCode else {
            throw ApiError.invalidStatusCode(statusCode: baseModel.code, tips: baseModel.errorTips)
        }

        baseModel.xl_origin_json = jsonString
        return baseModel
    }

    func xl_mapBaseModelArray<T: HandyJSON>(_ type: T.Type) throws ->LXBaseListModel<T>? {

        let jsonString = String(data: data, encoding: .utf8)

        guard let baseModel = JSONDeserializer<LXBaseGenericModel<LXBaseListModel<T>>>.deserializeFrom(json: jsonString) else {
            throw ApiError.serializeError(response: nil, error: nil)
        }

        guard baseModel.code == kLXSuccessCode else {
            throw ApiError.invalidStatusCode(statusCode: baseModel.code, tips: baseModel.errorTips)
        }

        baseModel.xl_origin_json = jsonString
        return baseModel.data
    }
}
