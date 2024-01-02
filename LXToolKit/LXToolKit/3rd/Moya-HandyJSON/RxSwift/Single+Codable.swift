//
//  Single+Codable.swift
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
public extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    func mapCodable<T: Codable>(_ type: T.Type, atKeyPath keyPath: String = "") -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(try response.mapCodable(type, atKeyPath: keyPath))
        }
    }
    func mapArrayCodable<T: Codable>(_ type: T.Type, atKeyPath keyPath: String = "") -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            return Single.just(try response.mapArrayCodable(type, atKeyPath: keyPath))
        }
    }
    func mapBaseCodable<T: Codable>(_ type: T.Type, atKeyPath keyPath: String = "") -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(try response.mapBaseCodable(type, atKeyPath: keyPath))
        }
    }
    func mapBaseArrayCodable<T: Codable>(_ type: T.Type, atKeyPath keyPath: String = "") -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            return Single.just(try response.mapBaseArrayCodable(type, atKeyPath: keyPath))
        }
    }
}

// MARK: - 👀HandyJSON
public extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    /// Maps data received from the signal into an object
    /// which implements the Mappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    func mapHandyJSON<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String = "") -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(try response.mapHandyJSON(type, atKeyPath: keyPath))
        }
    }

    /// Maps data received from the signal into an array of objects
    /// which implement the Mappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    func mapHandyJSONArray<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String = "") -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            return Single.just(try response.mapHandyJSONArray(type, atKeyPath: keyPath))
        }
    }

    func mapBaseHandyJSON<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String = "") -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(try response.mapBaseHandyJSON(type, atKeyPath: keyPath))
        }
    }
    func mapBaseHandyJSONArray<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String = "") -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            return Single.just(try response.mapBaseHandyJSONArray(type, atKeyPath: keyPath))
        }
    }
}

// MARK: - 👀Mappable
public extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    func mapMapper<T: Mappable>(_ type: T.Type, atKeyPath keyPath: String = "", context: MapContext? = nil) -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(try response.mapMapper(T.self, atKeyPath: keyPath, context: context))
        }
    }
    func mapMapperArray<T: Mappable>(_ type: T.Type, atKeyPath keyPath: String = "", context: MapContext? = nil) -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            return Single.just(try response.mapMapperArray(T.self, atKeyPath: keyPath, context: context))
        }
    }
    func mapBaseMapper<T: Mappable>(_ type: T.Type, atKeyPath keyPath: String = "", context: MapContext? = nil) -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(try response.mapBaseMapper(T.self, atKeyPath: keyPath, context: context))
        }
    }
    func mapBaseMapperArray<T: Mappable>(_ type: T.Type, atKeyPath keyPath: String = "", context: MapContext? = nil) -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            return Single.just(try response.mapBaseMapperArray(T.self, atKeyPath: keyPath, context: context))
        }
    }
}

// MARK: - 👀ImmutableMappable
public extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    func mapMapper<T: ImmutableMappable>(_ type: T.Type, atKeyPath keyPath: String = "", context: MapContext? = nil) -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(try response.mapMapper(T.self, atKeyPath: keyPath, context: context))
        }
    }
    func mapMapperArray<T: ImmutableMappable>(_ type: T.Type, atKeyPath keyPath: String = "", context: MapContext? = nil) -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            return Single.just(try response.mapMapperArray(T.self, atKeyPath: keyPath, context: context))
        }
    }
    func mapBaseMapper<T: ImmutableMappable>(_ type: T.Type, atKeyPath keyPath: String = "", context: MapContext? = nil) -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(try response.mapBaseMapper(T.self, atKeyPath: keyPath, context: context))
        }
    }
    func mapBaseMapperArray<T: ImmutableMappable>(_ type: T.Type, atKeyPath keyPath: String = "", context: MapContext? = nil) throws -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            return Single.just(try response.mapBaseMapperArray(T.self, atKeyPath: keyPath, context: context))
        }
    }
}
