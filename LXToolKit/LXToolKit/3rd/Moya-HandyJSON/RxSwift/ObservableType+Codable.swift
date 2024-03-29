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
import ObjectMapper

/// Extension for processing Responses into Mappable objects through ObjectMapper
// MARK: - 👀Codable
public extension ObservableType where Element == Response {
    func mapCodable<T: Codable>(_ type: T.Type, atKeyPath keyPath: String = "") -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapCodable(T.self, atKeyPath: keyPath))
        }
    }
    func mapArrayCodable<T: Codable>(_ type: T.Type, atKeyPath keyPath: String = "") throws -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapArrayCodable(T.self, atKeyPath: keyPath))
        }
    }
    func mapBaseCodable<T: Codable>(_ type: T.Type, atKeyPath keyPath: String = "") -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapBaseCodable(T.self, atKeyPath: keyPath))
        }
    }
    func mapBaseArrayCodable<T: Codable>(_ type: T.Type, atKeyPath keyPath: String = "") throws -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapBaseArrayCodable(T.self, atKeyPath: keyPath))
        }
    }
}

// MARK: - 👀HandyJSON
public extension ObservableType where Element == Response {
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

    func mapBaseHandyJSON<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String = "") throws -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapBaseHandyJSON(T.self, atKeyPath: keyPath))
//            return Observable.just(try response.mapBaseModel(T.self))
        }
    }

    func mapBaseHandyJSONArray<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String = "") throws -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
//        return flatMap { response -> Observable<LXBaseListGenericHandyJSON<T>> in
//            let a = try response.mapModelArray(T.self)
            return Observable.just(try response.mapBaseHandyJSONArray(T.self, atKeyPath: keyPath))
//            return Observable.just(try response.mapBaseModelArray(T.self))
        }
    }
}

// MARK: - 👀Mappable
public extension ObservableType where Element == Response {
    func mapMapper<T: Mappable>(_ type: T.Type, atKeyPath keyPath: String = "", context: MapContext? = nil) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapMapper(T.self, atKeyPath: keyPath, context: context))
        }
    }
    func mapMapperArray<T: Mappable>(_ type: T.Type, atKeyPath keyPath: String = "", context: MapContext? = nil) throws -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapMapperArray(T.self, atKeyPath: keyPath, context: context))
        }
    }
    func mapBaseMapper<T: Mappable>(_ type: T.Type, atKeyPath keyPath: String = "", context: MapContext? = nil) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapBaseMapper(T.self, atKeyPath: keyPath, context: context))
        }
    }
    func mapBaseMapperArray<T: Mappable>(_ type: T.Type, atKeyPath keyPath: String = "", context: MapContext? = nil) throws -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapBaseMapperArray(T.self, atKeyPath: keyPath, context: context))
        }
    }
}

// MARK: - 👀ImmutableMappable
public extension ObservableType where Element == Response {
    func mapMapper<T: ImmutableMappable>(_ type: T.Type, atKeyPath keyPath: String = "", context: MapContext? = nil) throws -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapMapper(T.self, atKeyPath: keyPath, context: context))
        }
    }
    func mapMapperArray<T: ImmutableMappable>(_ type: T.Type, atKeyPath keyPath: String = "", context: MapContext? = nil) throws -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapMapperArray(T.self, atKeyPath: keyPath, context: context))
        }
    }
    func mapBaseMapper<T: ImmutableMappable>(_ type: T.Type, atKeyPath keyPath: String = "", context: MapContext? = nil) throws -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapBaseMapper(T.self, atKeyPath: keyPath, context: context))
        }
    }
    func mapBaseMapperArray<T: ImmutableMappable>(_ type: T.Type, atKeyPath keyPath: String = "", context: MapContext? = nil) throws -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapBaseMapperArray(T.self, atKeyPath: keyPath, context: context))
        }
    }
}
