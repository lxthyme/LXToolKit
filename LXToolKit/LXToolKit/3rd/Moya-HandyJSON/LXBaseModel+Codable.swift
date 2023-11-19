//
//  LXBaseModel+Codable.swift
//  LXToolKit
//
//  Created by lxthyme on 2023/11/19.
//

import Foundation

public struct LXBaseCodable: Codable, LXBaseModelProtocol {
    // MARK: 🔗Vaiables
    public var msg: String?
    public var code: Int?
    public var errorTips: String?
    public var successTips: String?
    public var f_origin_json: String?
    // MARK: 🛠Life Cycle
    public init() {}

    enum CodingKeys: CodingKey {
        case msg
        case code
        case errorTips
        case successTips
    }
}
public struct LXBaseGenericCodable<T: Codable>: Codable, LXBaseModelGenericProtocol {
    // MARK: 🔗Vaiables
    public var code: Int?
    public var msg: String?
    public var errorTips: String?
    public var successTips: String?
    public var data: T?
    public var f_origin_json: String?
    // MARK: 🛠Life Cycle
    public init() {}

    enum CodingKeys: CodingKey {
        case code
        case msg
        case errorTips
        case successTips
        case data
    }
}

public struct LXBaseListGenericCodable<T: Codable>: Codable, LXBaseListModelGenericProtocol {
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

    enum CodingKeys: CodingKey {
        case code
        case msg
        case errorTips
        case successTips
        case page
        case totalPage
        case list
    }
}
