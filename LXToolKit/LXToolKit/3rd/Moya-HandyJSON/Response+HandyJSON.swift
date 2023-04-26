//
//  Observable+HandyJSON.swift
//
//  Created by Ivan Bruel on 09/12/15.
//  Copyright © 2015 Ivan Bruel. All rights reserved.
//

import Foundation
import Moya
import HandyJSON

public extension Response {

  /// Maps data received from the signal into an object which implements the Mappable protocol.
  /// If the conversion fails, the signal errors.
    func mapObject<T: HandyJSON>(_ type: T.Type) throws -> T {
        guard let obj = try mapJSON() as? [String: Any],
              let object = T.deserialize(from: obj) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }

  /// Maps data received from the signal into an array of objects which implement the Mappable
  /// protocol.
  /// If the conversion fails, the signal errors.
    func mapArray<T: HandyJSON>(_ type: T.Type) throws -> [T] {
        guard let array = try mapJSON() as? [[String : Any]] else {
            throw MoyaError.jsonMapping(self)
        }
        return [T].deserialize(from: array)?.compactMap { $0 } ?? []
    }

  /// Maps data received from the signal into an object which implements the Mappable protocol.
  /// If the conversion fails, the signal errors.
    func mapObject<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String) throws -> T {
        guard let obj = try mapJSON() as? [String: Any],
              let object = T.deserialize(from: obj, designatedPath: keyPath) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }

  /// Maps data received from the signal into an array of objects which implement the Mappable
  /// protocol.
  /// If the conversion fails, the signal errors.
    func mapArray<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String) throws -> [T] {
        guard let array = [T].deserialize(from: try mapString(), designatedPath: keyPath) else {
            throw MoyaError.jsonMapping(self)
        }
        return array.compactMap { $0 }
    }
}


// MARK: - ImmutableMappable

// public extension Response {
// 
//   /// Maps data received from the signal into an object which implements the ImmutableMappable
//   /// protocol.
//   /// If the conversion fails, the signal errors.
//     func mapObject<T: HandyJSON>(_ type: T.Type) throws -> T {
//         return try T.deserialize(from: <#T##NSDictionary?#>)
//   }
// 
//   /// Maps data received from the signal into an array of objects which implement the ImmutableMappable
//   /// protocol.
//   /// If the conversion fails, the signal errors.
//     func mapArray<T: HandyJSON>(_ type: T.Type) throws -> [T?] {
//     guard let array = try mapJSON() as? [[String : Any]] else {
//       throw MoyaError.jsonMapping(self)
//     }
//         return [T].deserialize(from: array) ?? []
//   }
// 
//   /// Maps data received from the signal into an object which implements the ImmutableMappable
//   /// protocol.
//   /// If the conversion fails, the signal errors.
//     func mapObject<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String) throws -> T {
//         guard let object = T.deserialize(from: try mapJSON(), designatedPath: keyPath) else {
//       throw MoyaError.jsonMapping(self)
//     }
//     return object
//   }
// 
//   /// Maps data received from the signal into an array of objects which implement the ImmutableMappable
//   /// protocol.
//   /// If the conversion fails, the signal errors.
//     func mapArray<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String) throws -> [T] {
//     guard let array = (try mapJSON() as? NSDictionary)?.value(forKeyPath: keyPath) as? [[String : Any]] else {
//       throw MoyaError.jsonMapping(self)
//     }
//         return [T].deserialize(from: array) ?? []
//   }
// 
// }
