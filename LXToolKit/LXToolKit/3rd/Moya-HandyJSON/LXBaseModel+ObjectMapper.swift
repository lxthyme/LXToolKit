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
open class LXAnyModel: NSObject {
    deinit {
        dlog("---------- >>>Model: \(self.xl.xl_typeName)\t\tdeinit <<<----------")
    }
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    required public override init() {}
}

public protocol LXBaseGenericMappable: LXBaseModelProtocol {
    associatedtype T
    // MARK: 🔗Vaiables
    var data: T? { get }
}

public protocol LXBaseListMappable: LXBaseModelProtocol {
    associatedtype T
    // MARK: 🔗Vaiables
    var list: [T]? { get }
}
public struct LXBaseGenericMapper<T: LXMappable>: LXBaseGenericMappable, LXMappable {
    public var code: Int?
    public var msg: String?
    public var errorTips: String?
    public var successTips: String?
    public var xl_origin_json: String?
    public var data: T?
    public init?(map: ObjectMapper.Map) {}
    public mutating func mapping(map: ObjectMapper.Map) {
        code <- map["code"]
        msg <- map["msg"]
        errorTips <- map["errorTips"]
        successTips <- map["successTips"]
        data <- map["data"]
    }
}
public struct LXBaseListMapper<T: LXMappable>: LXBaseListMappable, LXMappable {
    public var code: Int?
    public var msg: String?
    public var errorTips: String?
    public var successTips: String?
    public var xl_origin_json: String?
    public var list: [T]?
    public init?(map: ObjectMapper.Map) {}
    public mutating func mapping(map: ObjectMapper.Map) {
        code <- map["code"]
        errorTips <- map["errorTips"]
        successTips <- map["successTips"]
        list <- map["list"]
    }
}
public struct LXBaseGenericImmutableMapper<T: LXImmutableMappable>: LXImmutableMappable {
    public let code: Int
    public let msg: String
    public let errorTips: String
    public let successTips: String
    public let xl_origin_json: String
    public let data: T
    public init(map: Map) throws {
        code = try map.value("code", default: -1)
        msg = try map.value("msg", default: "")
        errorTips = try map.value("errorTips", default: "")
        successTips = try map.value("successTips", default: "")
        data = try map.value("data", default: T.init(map: map))

        xl_origin_json = ""
    }
}
public struct LXBaseListImmutableMapper<T: LXImmutableMappable>: LXImmutableMappable {
    public let code: Int
    public let msg: String
    public let errorTips: String
    public let successTips: String
    public let xl_origin_json: String
    public let list: [T]
    public init(map: Map) throws {
        code = try map.value("code", default: -1)
        msg = try map.value("msg", default: "")
        errorTips = try map.value("errorTips", default: "")
        successTips = try map.value("successTips", default: "")
        list = try map.value("list", default: [])

        xl_origin_json = ""
    }
}
