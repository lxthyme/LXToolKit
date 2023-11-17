//
//  Response+Codable.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/11/17.
//

import Foundation
import RxSwift
import Moya

public extension Response {
    static let decoder = JSONDecoder()
    /// Maps data received from the signal into an object which implements the Mappable protocol.
    /// If the conversion fails, the signal errors.
    func mapObject<T: Codable>(_ type: T.Type) throws -> T {
        let object = try Response.decoder.decode(T.self, from: data)
        return object
    }

    /// Maps data received from the signal into an array of objects which implement the Mappable
    /// protocol.
    /// If the conversion fails, the signal errors.
    func mapArray<T: Codable>(_ type: T.Type) throws -> [T] {
        let object = try Response.decoder.decode([T].self, from: data)
        return object
    }

    /// Maps data received from the signal into an object which implements the Mappable protocol.
    /// If the conversion fails, the signal errors.
    func mapObject<T: Codable>(_ type: T.Type, atKeyPath keyPath: String) throws -> T {
        guard let json = try mapJSON() as? NSDictionary,
              let item = json.value(forKeyPath: keyPath) else {
            throw MoyaError.jsonMapping(self)
        }
        let data = try JSONSerialization.data(withJSONObject: item, options: .fragmentsAllowed)
        let object = try Response.decoder.decode(T.self, from: data)
        return object
    }

    /// Maps data received from the signal into an array of objects which implement the Mappable
    /// protocol.
    /// If the conversion fails, the signal errors.
    func mapArray<T: Codable>(_ type: T.Type, atKeyPath keyPath: String) throws -> [T] {
        guard let json = try mapJSON() as? NSDictionary,
              let item = json.value(forKeyPath: keyPath) else {
            throw MoyaError.jsonMapping(self)
        }

        let data = try JSONSerialization.data(withJSONObject: item, options: .fragmentsAllowed)
        let object = try Response.decoder.decode([T].self, from: data)
        return object
    }
}

