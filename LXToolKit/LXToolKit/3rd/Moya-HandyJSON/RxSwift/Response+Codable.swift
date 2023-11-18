//
//  Observable+Codable.swift
//
//  Created by Ivan Bruel on 09/12/15.
//  Copyright © 2015 Ivan Bruel. All rights reserved.
//

import Foundation
import Moya
import HandyJSON

public extension Response {
    static let decoder = JSONDecoder()
    func mapObject<T: Codable>(_ type: T.Type, atKeyPath keyPath: String = "") throws -> T {
        if keyPath.isEmpty {
            let object = try Response.decoder.decode(T.self, from: data)
            return object
        }
        guard let json = try mapJSON() as? NSDictionary,
              let item = json.value(forKeyPath: keyPath) else {
            throw MoyaError.jsonMapping(self)
        }
        let data = try JSONSerialization.data(withJSONObject: item, options: .fragmentsAllowed)
        let object = try Response.decoder.decode(T.self, from: data)
        return object
    }
    func mapArray<T: Codable>(_ type: T.Type, atKeyPath keyPath: String = "") throws -> [T] {
        if keyPath.isEmpty {
            let object = try Response.decoder.decode([T].self, from: data)
            return object
        }
        guard let json = try mapJSON() as? NSDictionary,
              let item = json.value(forKeyPath: keyPath) else {
            throw MoyaError.jsonMapping(self)
        }

        let data = try JSONSerialization.data(withJSONObject: item, options: .fragmentsAllowed)
        let object = try Response.decoder.decode([T].self, from: data)
        return object
    }

  /// Maps data received from the signal into an object which implements the Mappable protocol.
  /// If the conversion fails, the signal errors.
    func mapHandyJSON<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String = "") throws -> T {
        guard (200..<300) ~= statusCode else {
            throw MoyaError.statusCode(self)
        }

        if keyPath.isEmpty {
            guard let obj = try mapJSON() as? [String: Any],
                  let object = T.deserialize(from: obj) else {
                throw MoyaError.jsonMapping(self)
            }
            return object
        }
        guard let obj = try mapJSON() as? [String: Any],
              let object = T.deserialize(from: obj, designatedPath: keyPath) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }

  /// Maps data received from the signal into an array of objects which implement the Mappable
  /// protocol.
  /// If the conversion fails, the signal errors.
    func mapHandyJSONArray<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String = "") throws -> [T] {
        guard (200..<300) ~= statusCode else {
            throw MoyaError.statusCode(self)
        }
        if keyPath.isEmpty {
            guard let array = try mapJSON() as? [[String : Any]] else {
                throw MoyaError.jsonMapping(self)
            }
            return [T].deserialize(from: array)?.compactMap { $0 } ?? []
        }
        guard let array = [T].deserialize(from: try mapString(), designatedPath: keyPath) else {
            throw MoyaError.jsonMapping(self)
        }
        return array.compactMap { $0 }
    }

    func mapBaseHandyJSON<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String = "") throws ->LXBaseGenericModel<T> {
        let baseModel = try mapHandyJSON(LXBaseGenericModel<T>.self, atKeyPath: keyPath)
        baseModel.xl_origin_json = try? mapString()
        guard baseModel.code != kLXSuccessCode else {
            throw MoyaError.statusCode(self)
        }
        return baseModel
    }
    func mapBaseHandyJSONArray<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String = "") throws ->LXBaseListModel<T> {
        let baseModel = try mapBaseHandyJSON(LXBaseListModel<T>.self, atKeyPath: keyPath)
        baseModel.xl_origin_json = try? mapString()
        guard let listModel = baseModel.data else {
            throw MoyaError.jsonMapping(self)
        }

        guard baseModel.code != kLXSuccessCode else {
            throw MoyaError.statusCode(self)
        }
        return listModel
    }
}
