//
//  ObserverType+HandyJSON.swift
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
    
    /// Maps data received from the signal into an object
    /// which implements the Mappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    func mapObject<T: HandyJSON>(_ type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapObject(type))
        }
    }
    
    /// Maps data received from the signal into an array of objects
    /// which implement the Mappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    func mapArray<T: HandyJSON>(_ type: T.Type) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapArray(type))
        }
    }
    
    /// Maps data received from the signal into an object
    /// which implements the Mappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    func mapObject<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapObject(T.self, atKeyPath: keyPath))
        }
    }
    
    /// Maps data received from the signal into an array of objects
    /// which implement the Mappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    func mapArray<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapArray(T.self, atKeyPath: keyPath))
        }
    }
}


// MARK: - ImmutableMappable
// public extension ObservableType where Element == Response {
//     
//     /// Maps data received from the signal into an object
//     /// which implements the ImmutableMappable protocol and returns the result back
//     /// If the conversion fails, the signal errors.
//     func mapObject<T: HandyJSON>(_ type: T.Type) -> Observable<T> {
//         return flatMap { response -> Observable<T> in
//             return Observable.just(try response.mapObject(type))
//         }
//     }
//     
//     /// Maps data received from the signal into an array of objects
//     /// which implement the ImmutableMappable protocol and returns the result back
//     /// If the conversion fails, the signal errors.
//     func mapArray<T: HandyJSON>(_ type: T.Type) -> Observable<[T]> {
//         return flatMap { response -> Observable<[T]> in
//             return Observable.just(try response.mapArray(type))
//         }
//     }
//     
//     /// Maps data received from the signal into an object
//     /// which implements the ImmutableMappable protocol and returns the result back
//     /// If the conversion fails, the signal errors.
//     func mapObject<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String) -> Observable<T> {
//         return flatMap { response -> Observable<T> in
//             return Observable.just(try response.mapObject(T.self, atKeyPath: keyPath))
//         }
//     }
//     
//     /// Maps data received from the signal into an array of objects
//     /// which implement the ImmutableMappable protocol and returns the result back
//     /// If the conversion fails, the signal errors.
//     func mapArray<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String) -> Observable<[T]> {
//         return flatMap { response -> Observable<[T]> in
//             return Observable.just(try response.mapArray(T.self, atKeyPath: keyPath))
//         }
//     }
// }
