//
//  ObserverType+Codable.swift
//
//  Created by Ivan Bruel on 09/12/15.
//  Copyright © 2015 Ivan Bruel. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import HandyJSON

/// Extension for processing Responses into Mappable objects through ObjectMapper
public extension ObservableType where Element == Response {
    public func mapObject<T: Codable>(_ type: T.Type, atKeyPath keyPath: String = "") -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapObject(T.self, atKeyPath: keyPath))
        }
    }
    public func mapArray<T: Codable>(_ type: T.Type, atKeyPath keyPath: String = "") -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapArray(T.self, atKeyPath: keyPath))
        }
    }
    
    /// Maps data received from the signal into an object
    /// which implements the Mappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    func mapHandyJSON<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String = "") -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapHandyJSON(T.self, atKeyPath: keyPath))
        }
    }
    
    /// Maps data received from the signal into an array of objects
    /// which implement the Mappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    func mapHandyJSONArray<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String = "") -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapHandyJSONArray(T.self, atKeyPath: keyPath))
        }
    }
    
    func xl_mapBaseModel<T: HandyJSON>(_ type: T.Type) ->Observable<LXBaseGenericModel<T>> {
        return flatMap { response -> Observable<LXBaseGenericModel<T>> in
            return Observable.just(try response.xl_mapBaseModel(T.self))
//            return Observable.just(try response.mapBaseModel(T.self))
        }
    }

    func xl_mapBaseModelArray<T: HandyJSON>(_ type: T.Type) ->Observable<LXBaseListModel<T>> {
        return flatMap { response -> Observable<LXBaseListModel<T>> in
//        return flatMap { response -> Observable<LXBaseListModel<T>> in
//            let a = try response.mapModelArray(T.self)
            return Observable.just(try response.xl_mapBaseModelArray(T.self))
//            return Observable.just(try response.mapBaseModelArray(T.self))
        }
    }
}
