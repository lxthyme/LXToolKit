//
//  LXBaseModel.swift
//  Vaffle_demo
//
//  Created by LXThyme on 2019/1/10.
//  Copyright © 2019 DamonJow. All rights reserved.
//

import Foundation
import HandyJSON
import ObjectMapper

public protocol LXAnyProtocol {}
public protocol LXBaseModelProtocol {
    // MARK: 🔗Vaiables
    var code: Int? { get set }
    var msg: String? { get set }
    // public var tips { get set }
    var errorTips: String? { get set }
    var successTips: String? { get set }
    var xl_origin_json: String? { get set }
}

public protocol LXBaseModelGenericProtocol: LXBaseModelProtocol {
    associatedtype T
    // MARK: 🔗Vaiables
    var data: T? { get set }
}
public protocol LXBaseListGenericProtocol {
    associatedtype T
    // MARK: 🔗Vaiables
    var page: Int { get set }
    var totalPage: Int { get set }
    var list: [T] { get set }
}
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
open class LXBaseHandyJSON: LXAnyModel, HandyJSON, LXBaseModelProtocol {
    // MARK: 🔗Vaiables
    public var msg: String?
    public var code: Int?
    public var errorTips: String?
    public var successTips: String?
    public var xl_origin_json: String?
    // MARK: 🛠Life Cycle
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    required public init() {
        super.init()
    }
    // open override func mapping(mapper: HelpingMapper) {
    //     mapper <<< self.xl_origin_json <-- "xl_origin_json"
    // }

    open override var debugDescription: String {
        return toJSONString(prettyPrint: true) ?? "--NaN-"
    }
}
open class LXBaseGenericHandyJSON<T: HandyJSON>: LXAnyModel, HandyJSON, LXBaseModelProtocol {
    // MARK: 🔗Vaiables
    public var code: Int?
    public var msg: String?
    public var errorTips: String?
    public var successTips: String?
    public var xl_origin_json: String?
    public var data: T?
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    required public init() {
        super.init()
    }

    // init?(map: ObjectMapper.Map) {}
    // mutating func mapping(map: Map) {
    //     xl_origin_json <- map["xl_origin_json"]
    // }

    open override var debugDescription: String {
        return toJSONString(prettyPrint: true) ?? "--NaN-"
    }
}

open class LXBaseListHandyJSON<T: HandyJSON>: LXAnyModel, HandyJSON, LXBaseModelProtocol {
    public var code: Int?
    public var msg: String?
    public var errorTips: String?
    public var successTips: String?
    public var xl_origin_json: String?
    public var page: UInt?
    public var total_page: UInt?
    public var list: [T]?
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    required public init() {
        super.init()
    }

    /// override var debugDescription: String { return "" }
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

// MARK: - 👀
public extension HandyJSON {
    var debugDescription: String { return toJSONString(prettyPrint: true) ?? "---" }
}
