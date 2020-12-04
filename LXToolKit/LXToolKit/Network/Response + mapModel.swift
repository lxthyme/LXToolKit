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

public extension ObservableType where E == Response {
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
    func mapBaseModel<T: HandyJSON>(_ type: T.Type) throws ->LXBaseModel<T> {
        let jsonString = String(data: data, encoding: .utf8)

        guard let baseModel = JSONDeserializer<LXBaseModel<T>>.deserializeFrom(json: jsonString) else {
            throw RxMoyaError.invalidJSON
        }

        guard baseModel.code == kLXSuccessCode else {
            throw RxMoyaError.codeInvalid(code: baseModel.code, base: baseModel)
        }

        baseModel.fullJsonString = jsonString
        return baseModel
    }

    func mapBaseModelArray<T: HandyJSON>(_ type: T.Type) throws ->LXBaseModel<LXBaseListModel<T>> {

        let jsonString = String(data: data, encoding: .utf8)

        guard let baseModel = JSONDeserializer<LXBaseModel<LXBaseListModel<T>>>.deserializeFrom(json: jsonString) else {
            throw RxMoyaError.invalidJSON
        }

        guard baseModel.code == kLXSuccessCode else {
            throw RxMoyaError.codeInvalid(code: baseModel.code, base: baseModel)
        }

        baseModel.fullJsonString = jsonString
        return baseModel
    }
}
