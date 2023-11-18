//
//  Single+HandyJSON.swift
//
//  Created by Ivan Bruel on 09/12/15.
//  Copyright © 2015 Ivan Bruel. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import HandyJSON

/// Extension for processing Responses into Mappable objects through ObjectMapper
public extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    public func mapObject<T: Codable>(_ type: T.Type) -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(try response.mapObject(type))
        }
    }
    public func mapArray<T: Codable>(_ type: T.Type) -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            return Single.just(try response.mapArray(type))
        }
    }
    public func mapObject<T: Codable>(_ type: T.Type, atKeyPath keyPath: String) -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(try response.mapObject(type, atKeyPath: keyPath))
        }
    }
    public func mapArray<T: Codable>(_ type: T.Type, atKeyPath keyPath: String) -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            return Single.just(try response.mapArray(type, atKeyPath: keyPath))
        }
    }
    
    /// Maps data received from the signal into an object
    /// which implements the Mappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    func mapHandyJSON<T: HandyJSON>(_ type: T.Type) -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(try response.mapHandyJSON(type))
        }
    }
    
    /// Maps data received from the signal into an array of objects
    /// which implement the Mappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    func mapHandyJSONArray<T: HandyJSON>(_ type: T.Type) -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            return Single.just(try response.mapHandyJSONArray(type))
        }
    }
    
    /// Maps data received from the signal into an object
    /// which implements the Mappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    func mapHandyJSON<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String) -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(try response.mapHandyJSON(type, atKeyPath: keyPath))
        }
    }
    
    /// Maps data received from the signal into an array of objects
    /// which implement the Mappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    func mapHandyJSONArray<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String) -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            return Single.just(try response.mapHandyJSONArray(type, atKeyPath: keyPath))
        }
    }
}
