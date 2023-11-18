//
//  ObserverType+Codable.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/11/17.
//

import Foundation
import RxSwift
import Moya

/// Extension for processing Responses into Mappable objects through ObjectMapper
public extension ObservableType where Element == Response {
    
    /// Maps data received from the signal into an object
    /// which implements the Mappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    public func mapObject<T: Codable>(_ type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapObject(type))
        }
    }
    
    /// Maps data received from the signal into an array of objects
    /// which implement the Mappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    public func mapArray<T: Codable>(_ type: T.Type) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapArray(type))
        }
    }
    
    /// Maps data received from the signal into an object
    /// which implements the Mappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    public func mapObject<T: Codable>(_ type: T.Type, atKeyPath keyPath: String) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapObject(T.self, atKeyPath: keyPath))
        }
    }
    
    /// Maps data received from the signal into an array of objects
    /// which implement the Mappable protocol and returns the result back
    /// If the conversion fails, the signal errors.
    public func mapArray<T: Codable>(_ type: T.Type, atKeyPath keyPath: String) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapArray(T.self, atKeyPath: keyPath))
        }
    }
}


// MARK: - ImmutableMappable
// public extension ObservableType where Element == Response {
// 
//   /// Maps data received from the signal into an object
//   /// which implements the ImmutableMappable protocol and returns the result back
//   /// If the conversion fails, the signal errors.
//   public func mapObject<T: ImmutableMappable>(_ type: T.Type) -> Observable<T> {
//     return flatMap { response -> Observable<T> in
//             return Observable.just(try response.mapObject(type))
//     }
//   }
// 
//   /// Maps data received from the signal into an array of objects
//   /// which implement the ImmutableMappable protocol and returns the result back
//   /// If the conversion fails, the signal errors.
//   public func mapArray<T: ImmutableMappable>(_ type: T.Type) -> Observable<[T]> {
//     return flatMap { response -> Observable<[T]> in
//             return Observable.just(try response.mapArray(type))
//     }
//   }
// 
//   /// Maps data received from the signal into an object
//   /// which implements the ImmutableMappable protocol and returns the result back
//   /// If the conversion fails, the signal errors.
//   public func mapObject<T: ImmutableMappable>(_ type: T.Type, atKeyPath keyPath: String) -> Observable<T> {
//     return flatMap { response -> Observable<T> in
//             return Observable.just(try response.mapObject(T.self, atKeyPath: keyPath))
//     }
//   }
// 
//   /// Maps data received from the signal into an array of objects
//   /// which implement the ImmutableMappable protocol and returns the result back
//   /// If the conversion fails, the signal errors.
//   public func mapArray<T: ImmutableMappable>(_ type: T.Type, atKeyPath keyPath: String) -> Observable<[T]> {
//     return flatMap { response -> Observable<[T]> in
//             return Observable.just(try response.mapArray(T.self, atKeyPath: keyPath))
//     }
//   }
// }
