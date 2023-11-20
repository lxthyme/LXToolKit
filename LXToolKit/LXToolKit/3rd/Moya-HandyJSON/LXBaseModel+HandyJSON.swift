//
//  LXBaseModel+HandyJSON.swift
//  LXToolKit
//
//  Created by lxthyme on 2023/11/19.
//

import Foundation
import HandyJSON

public struct LXBaseHandyJSON: HandyJSON, LXBaseModelProtocol {
    // MARK: 🔗Vaiables
    public var msg: String?
    public var code: Int?
    public var errorTips: String?
    public var successTips: String?
    public var f_origin_json: String?
    // MARK: 🛠Life Cycle
    public init() {}
}
public struct LXBaseGenericHandyJSON<T: HandyJSON>: HandyJSON, LXBaseModelGenericProtocol {
    // MARK: 🔗Vaiables
    public var code: Int?
    public var msg: String?
    public var errorTips: String?
    public var successTips: String?
    public var data: T?
    public var f_origin_json: String?
    // MARK: 🛠Life Cycle
    public init() {}
}

public struct LXBaseListGenericHandyJSON<T: HandyJSON>: HandyJSON, LXBaseListModelGenericProtocol {
    public var code: Int?
    public var msg: String?
    public var errorTips: String?
    public var successTips: String?
    public var page: Int?
    public var totalPage: Int?
    public var list: [T]?
    public var f_origin_json: String?
    // MARK: 🛠Life Cycle
    public init() {}
}

// MARK: - 👀
public extension HandyJSON {
    public var debugDescription: String {
        return toJSONString(prettyPrint: true) ?? "--NaN-"
    }
}
