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
    func mapHandyJSON<T: HandyJSON>(_ type: T.Type) throws -> T {
        guard let obj = try mapJSON() as? [String: Any],
              let object = T.deserialize(from: obj) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }

  /// Maps data received from the signal into an array of objects which implement the Mappable
  /// protocol.
  /// If the conversion fails, the signal errors.
    func mapHandyJSONArray<T: HandyJSON>(_ type: T.Type) throws -> [T] {
        guard let array = try mapJSON() as? [[String : Any]] else {
            throw MoyaError.jsonMapping(self)
        }
        return [T].deserialize(from: array)?.compactMap { $0 } ?? []
    }

  /// Maps data received from the signal into an object which implements the Mappable protocol.
  /// If the conversion fails, the signal errors.
    func mapHandyJSON<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String) throws -> T {
        guard let obj = try mapJSON() as? [String: Any],
              let object = T.deserialize(from: obj, designatedPath: keyPath) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }

  /// Maps data received from the signal into an array of objects which implement the Mappable
  /// protocol.
  /// If the conversion fails, the signal errors.
    func mapHandyJSONArray<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String) throws -> [T] {
        guard let array = [T].deserialize(from: try mapString(), designatedPath: keyPath) else {
            throw MoyaError.jsonMapping(self)
        }
        return array.compactMap { $0 }
    }

    func mapModel<T: HandyJSON>(_ type: T.Type) throws ->T {
        guard let obj = JSONDeserializer<T>.deserializeFrom(json: try mapString()) else {
            throw MoyaError.jsonMapping(self)
        }
        return obj
    }
    
    func xl_mapBaseModel<T: HandyJSON>(_ type: T.Type) throws ->LXBaseGenericModel<T> {
        let jsonString = String(data: data, encoding: .utf8)

        guard let baseModel = JSONDeserializer<LXBaseGenericModel<T>>.deserializeFrom(json: jsonString) else {
            throw ApiError.serializeError(response: nil, error: nil)
        }

        guard baseModel.code == kLXSuccessCode else {
            throw ApiError.invalidStatusCode(statusCode: baseModel.code, tips: baseModel.errorTips)
        }

        baseModel.xl_origin_json = jsonString
        return baseModel
    }

    func xl_mapBaseModelArray<T: HandyJSON>(_ type: T.Type) throws ->LXBaseListModel<T>? {

        let jsonString = String(data: data, encoding: .utf8)

        guard let baseModel = JSONDeserializer<LXBaseGenericModel<LXBaseListModel<T>>>.deserializeFrom(json: jsonString) else {
            throw ApiError.serializeError(response: nil, error: nil)
        }

        guard baseModel.code == kLXSuccessCode else {
            throw ApiError.invalidStatusCode(statusCode: baseModel.code, tips: baseModel.errorTips)
        }

        baseModel.xl_origin_json = jsonString
        return baseModel.data
    }

    func xl_mapModel<T: HandyJSON>(_ type: T.Type) throws ->LXBaseGenericModel<T> {
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
    func xl_mapModelArray<T: HandyJSON>(_ type: T.Type) throws ->LXBaseListModel<T> {
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
