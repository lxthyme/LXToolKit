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
    func mapBaseModel<T: HandyJSON>(_ type: T.Type) ->Observable<LXBaseModel<T>> {
        return flatMap { response -> Observable<LXBaseModel<T>> in
            return Observable.just(try response.mapModel(T.self))
//            return Observable.just(try response.mapBaseModel(T.self))
        }
    }

    func mapBaseModelArray<T: HandyJSON>(_ type: T.Type) ->Observable<LXBaseModel<LXBaseListModel<T>>> {
        return flatMap { response -> Observable<LXBaseModel<LXBaseListModel<T>>> in
            return Observable.just(try response.mapModelArray(T.self))
//            return Observable.just(try response.mapBaseModelArray(T.self))
        }
    }
}

// MARK: - <#Title...#>
extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) throws ->LXBaseModel<T> {
        guard (200..<300) ~= statusCode else {
            throw RxMoyaError.badService
        }
        
        guard let json = try mapJSON() as? [String: Any],
            let model = LXBaseModel<T>.deserialize(from: json) else {
                throw RxMoyaError.invalidJSON
        }

        guard statusCode != 10000 else {
            throw RxMoyaError.codeInvalid(code: model.code,
                                          data: model.data,
                                          tips: model.tips,
                                          msg: model.msg)
        }

        return model
    }
    func mapModelArray<T: HandyJSON>(_ type: T.Type) throws ->LXBaseModel<LXBaseListModel<T>> {
        guard (200..<300) ~= statusCode else {
            throw RxMoyaError.badService
        }

        let json1 = try mapJSON() as? [String: Any]
        let model1 = LXBaseModel<LXBaseListModel<T>>.deserialize(from: json1)
        guard let json = try mapJSON() as? [String: Any],
            let model = LXBaseModel<LXBaseListModel<T>>.deserialize(from: json) else {
                throw RxMoyaError.invalidJSON
        }


        guard model.code != 10000 else {
            throw RxMoyaError.codeInvalid(code: model.code,
                                          data: model.data,
                                          tips: model.tips,
                                          msg: model.msg)
        }

        return model

    }
}
