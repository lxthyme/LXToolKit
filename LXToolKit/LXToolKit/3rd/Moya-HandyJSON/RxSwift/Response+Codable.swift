//
//  Observable+Codable.swift
//
//  Created by Ivan Bruel on 09/12/15.
//  Copyright © 2015 Ivan Bruel. All rights reserved.
//

import Foundation
import Moya
import HandyJSON
import ObjectMapper

// MARK: - 👀Codable
public extension Response {
    private static let decoder = JSONDecoder()
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
}

// MARK: - 👀HandyJSON
public extension Response {
  /// Maps data received from the signal into an object which implements the Mappable protocol.
  /// If the conversion fails, the signal errors.
    func mapHandyJSON<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String = "") throws -> T {
        guard (200..<300) ~= statusCode else {
            throw MoyaError.statusCode(self)
        }

        guard let json = try mapJSON() as? [String: Any] else {
            throw MoyaError.jsonMapping(self)
        }

        if keyPath.isEmpty {
            guard let object = T.deserialize(from: json) else {
                throw MoyaError.jsonMapping(self)
            }
            return object
        }
        guard let object = T.deserialize(from: json, designatedPath: keyPath) else {
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
            guard let json = try mapJSON() as? [[String : Any]],
                  let list = [T].deserialize(from: json) else {
                throw MoyaError.jsonMapping(self)
            }
            return list.compactMap({ $0 })
        }
        guard let list = [T].deserialize(from: try mapString(), designatedPath: keyPath) else {
            throw MoyaError.jsonMapping(self)
        }
        return list.compactMap { $0 }
    }

    func mapBaseHandyJSON<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String = "") throws -> T {
        let baseModel = try mapHandyJSON(LXBaseGenericModel<T>.self, atKeyPath: keyPath)
        baseModel.xl_origin_json = try? mapString()

        guard baseModel.code == kLXSuccessCode else {
            throw MoyaError.statusCode(self)
        }
        guard let item = baseModel.data else {
            throw MoyaError.jsonMapping(self)
        }
        return item
    }
    func mapBaseHandyJSONArray<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String = "") throws ->[T] {
        let baseModel = try mapHandyJSON(LXBaseListModel<T>.self, atKeyPath: keyPath)
        baseModel.xl_origin_json = try? mapString()

        guard baseModel.code == kLXSuccessCode else {
            throw MoyaError.statusCode(self)
        }
        guard let listModel = baseModel.list else {
            throw MoyaError.jsonMapping(self)
        }
        return listModel
    }
}

// MARK: - 👀Mappable
public extension Response {
    /// Maps data received from the signal into an object which implements the Mappable protocol.
    /// If the conversion fails, the signal errors.
    func mapMapper<T: LXMappable>(_ type: T.Type, atKeyPath keyPath: String = "", context: MapContext? = nil) throws -> T {
        let json = try mapJSON()
        if keyPath.isEmpty {
            guard let object = Mapper<T>(context: context).map(JSONObject: json) else {
                throw MoyaError.jsonMapping(self)
            }
            return object
        }
        guard let object = Mapper<T>(context: context).map(JSONObject: (json as? NSDictionary)?.value(forKeyPath: keyPath)) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }

    /// Maps data received from the signal into an array of objects which implement the Mappable
    /// protocol.
    /// If the conversion fails, the signal errors.
    func mapMapperArray<T: LXMappable>(_ type: T.Type, atKeyPath keyPath: String = "", context: MapContext? = nil) throws -> [T] {
        let json = try mapJSON()
        if keyPath.isEmpty {
            guard let array = json as? [[String : Any]] else {
                throw MoyaError.jsonMapping(self)
            }
            let object = Mapper<T>(context: context).mapArray(JSONArray: array)
        }
        guard let array = (json as? NSDictionary)?.value(forKeyPath: keyPath) as? [[String : Any]] else {
            throw MoyaError.jsonMapping(self)
        }
        return Mapper<T>(context: context).mapArray(JSONArray: array)
    }
    
    func mapBaseMapper<T: LXMappable>(_ type: T.Type, atKeyPath keyPath: String = "", context: MapContext? = nil) throws -> T {
        let baseModel = try mapMapper(LXBaseGenericMapper<T>.self, atKeyPath: keyPath, context: context)

        guard baseModel.code == kLXSuccessCode else {
            throw MoyaError.statusCode(self)
        }
        guard let item = baseModel.data else {
            throw MoyaError.jsonMapping(self)
        }
        return item
    }
    func mapBaseMapperArray<T: LXMappable>(_ type: T.Type, atKeyPath keyPath: String = "", context: MapContext? = nil) throws -> [T] {
        let baseModel = try mapMapper(LXBaseListMapper<T>.self, atKeyPath: keyPath, context: context)

        guard baseModel.code == kLXSuccessCode else {
            throw MoyaError.statusCode(self)
        }
        guard let list = baseModel.list else {
            throw MoyaError.jsonMapping(self)
        }
        return list
    }
}

// MARK: - 👀ImmutableMappable
public extension Response {
    /// Maps data received from the signal into an object which implements the ImmutableMappable
    /// protocol.
    /// If the conversion fails, the signal errors.
    func mapMapper<T: LXImmutableMappable>(_ type: T.Type, atKeyPath keyPath: String = "", context: MapContext? = nil) throws -> T {
        let json = try mapJSON()
        if keyPath.isEmpty {
            let object = try Mapper<T>(context: context).map(JSONObject: json)
            return object
        }
        guard let object = Mapper<T>(context: context).map(JSONObject: (json as? NSDictionary)?.value(forKeyPath: keyPath)) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }

    /// Maps data received from the signal into an array of objects which implement the ImmutableMappable
    /// protocol.
    /// If the conversion fails, the signal errors.
    func mapMapperArray<T: LXImmutableMappable>(_ type: T.Type, atKeyPath keyPath: String = "", context: MapContext? = nil) throws -> [T] {
        let json = try mapJSON()
        if keyPath.isEmpty {
            guard let array = json as? [[String : Any]] else {
                throw MoyaError.jsonMapping(self)
            }
            return try Mapper<T>(context: context).mapArray(JSONArray: array)
        }
        guard let array = (json as? NSDictionary)?.value(forKeyPath: keyPath) as? [[String : Any]] else {
            throw MoyaError.jsonMapping(self)
        }
        return try Mapper<T>(context: context).mapArray(JSONArray: array)
    }
    func mapBaseMapper<T: LXImmutableMappable>(_ type: T.Type, atKeyPath keyPath: String = "", context: MapContext? = nil) throws -> T {
        let baseModel = try mapMapper(LXBaseGenericImmutableMapper<T>.self, atKeyPath: keyPath, context: context)

        guard baseModel.code == kLXSuccessCode else {
            throw MoyaError.statusCode(self)
        }
        return baseModel.data
    }
    func mapBaseMapperArray<T: LXImmutableMappable>(_ type: T.Type, atKeyPath keyPath: String = "", context: MapContext? = nil) throws -> [T] {
        let baseModel = try mapMapper(LXBaseListImmutableMapper<T>.self, atKeyPath: keyPath, context: context)

        guard baseModel.code == kLXSuccessCode else {
            throw MoyaError.statusCode(self)
        }
        return baseModel.list
    }
}
