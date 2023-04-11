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
    
    /// Maps data received from the signal into an object
    /// which implements the Mappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    func mapObject<T: HandyJSON>(_ type: T.Type) -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(try response.mapObject(type))
        }
    }
    
    /// Maps data received from the signal into an array of objects
    /// which implement the Mappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    func mapArray<T: HandyJSON>(_ type: T.Type) -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            return Single.just(try response.mapArray(type))
        }
    }
    
    /// Maps data received from the signal into an object
    /// which implements the Mappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    func mapObject<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String) -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(try response.mapObject(type, atKeyPath: keyPath))
        }
    }
    
    /// Maps data received from the signal into an array of objects
    /// which implement the Mappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    func mapArray<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String) -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            return Single.just(try response.mapArray(type, atKeyPath: keyPath))
        }
    }
}


// MARK: - ImmutableMappable
// public extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
//     
//     /// Maps data received from the signal into an object
//     /// which implements the ImmutableMappable protocol and returns the result back
//     /// If the conversion fails, the signal errors.
//     func mapObject<T: HandyJSON>(_ type: T.Type) -> Single<T> {
//         return flatMap { response -> Single<T> in
//             return Single.just(try response.mapObject(type))
//         }
//     }
//     
//     /// Maps data received from the signal into an array of objects
//     /// which implement the ImmutableMappable protocol and returns the result back
//     /// If the conversion fails, the signal errors.
//     func mapArray<T: HandyJSON>(_ type: T.Type) -> Single<[T]> {
//         return flatMap { response -> Single<[T]> in
//             return Single.just(try response.mapArray(type))
//         }
//     }
//     
//     /// Maps data received from the signal into an object
//     /// which implements the ImmutableMappable protocol and returns the result back
//     /// If the conversion fails, the signal errors.
//     func mapObject<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String) -> Single<T> {
//         return flatMap { response -> Single<T> in
//             return Single.just(try response.mapObject(type, atKeyPath: keyPath))
//         }
//     }
//     
//     /// Maps data received from the signal into an array of objects
//     /// which implement the ImmutableMappable protocol and returns the result back
//     /// If the conversion fails, the signal errors.
//     func mapArray<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String) -> Single<[T]> {
//         return flatMap { response -> Single<[T]> in
//             return Single.just(try response.mapArray(type, atKeyPath: keyPath))
//         }
//     }
// }
