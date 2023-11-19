//
//  LXBaseModel+ObjectMapper.swift
//  LXToolKit
//
//  Created by lxthyme on 2023/11/19.
//

import Foundation
import ObjectMapper

public protocol LXMappable: Mappable {}
public protocol LXImmutableMappable: ImmutableMappable {}

public struct LXBaseGenericMapper<T: LXMappable>: LXBaseModelGenericProtocol, LXMappable {
    // MARK: 🔗Vaiables
    public var code: Int?
    public var msg: String?
    public var errorTips: String?
    public var successTips: String?
    public var data: T?
    public var f_origin_json: String?
    // MARK: 🛠Life Cycle
    public init?(map: ObjectMapper.Map) {}
    public mutating func mapping(map: ObjectMapper.Map) {
        code <- map["code"]
        msg <- map["msg"]
        errorTips <- map["errorTips"]
        successTips <- map["successTips"]
        data <- map["data"]
    }
}
public struct LXBaseListGenericMapper<T: LXMappable>: LXBaseListModelGenericProtocol, LXMappable {
    // MARK: 🔗Vaiables
    public var code: Int?
    public var msg: String?
    public var errorTips: String?
    public var successTips: String?
    public var page: Int?
    public var totalPage: Int?
    public var list: [T]?
    public var f_origin_json: String?
    // MARK: 🛠Life Cycle
    public init?(map: ObjectMapper.Map) {}
    public mutating func mapping(map: ObjectMapper.Map) {
        code <- map["code"]
        errorTips <- map["errorTips"]
        successTips <- map["successTips"]
        page <- map["page"]
        totalPage <- map["totalPage"]
        list <- map["list"]
    }
}
public struct LXBaseGenericImmutableMapper<T: LXImmutableMappable>: LXImmutableMappable {
    // MARK: 🔗Vaiables
    public let code: Int
    public let msg: String
    public let errorTips: String
    public let successTips: String
    public let data: T
    public let f_origin_json: String
    // MARK: 🛠Life Cycle
    public init(map: Map) throws {
        code = try map.value("code", default: -1)
        msg = try map.value("msg", default: "")
        errorTips = try map.value("errorTips", default: "")
        successTips = try map.value("successTips", default: "")
        data = try map.value("data", default: T.init(map: map))

        f_origin_json = ""
    }
}
public struct LXBaseListGenericImmutableMapper<T: LXImmutableMappable>: LXImmutableMappable {
    // MARK: 🔗Vaiables
    public let code: Int
    public let msg: String
    public let errorTips: String
    public let successTips: String
    public var page: Int?
    public var totalPage: Int?
    public let list: [T]
    public let f_origin_json: String
    // MARK: 🛠Life Cycle
    public init(map: Map) throws {
        code = try map.value("code", default: -1)
        msg = try map.value("msg", default: "")
        errorTips = try map.value("errorTips", default: "")
        successTips = try map.value("successTips", default: "")
        page <- map["page"]
        totalPage <- map["totalPage"]
        list = try map.value("list", default: [])

        f_origin_json = ""
    }
}
