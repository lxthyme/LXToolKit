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
    func mapHandyJSON<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String) throws -> T {
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

    func xl_mapBaseModel<T: HandyJSON>(_ type: T.Type) throws ->LXBaseGenericModel<T> {
        guard (200..<300) ~= statusCode else {
            throw ApiError.serverError(response: self, error: nil)
        }

        guard let json = try mapJSON() as? [String: Any],
            let baseModel = LXBaseGenericModel<T>.deserialize(from: json) else {
            throw ApiError.serializeError(response: self, error: nil)
        }

        guard baseModel.code != kLXSuccessCode else {
            throw ApiError.invalidStatusCode(statusCode: baseModel.code, tips: baseModel.errorTips)
        }

        baseModel.xl_origin_json = try? mapString()
        return baseModel
    }
    func xl_mapBaseModelArray<T: HandyJSON>(_ type: T.Type) throws ->LXBaseListModel<T> {
        guard (200..<300) ~= statusCode else {
            throw ApiError.serverError(response: self, error: nil)
        }

        guard let json = try mapJSON() as? [String: Any],
            let baseModel = LXBaseGenericModel<LXBaseListModel<T>>.deserialize(from: json),
            let listModel = baseModel.data else {
            throw ApiError.serializeError(response: self, error: nil)
        }

        guard baseModel.code != kLXSuccessCode else {
            throw ApiError.invalidStatusCode(statusCode: baseModel.code, tips: baseModel.errorTips)
        }

        baseModel.xl_origin_json = try? mapString()
        return listModel
    }
}
