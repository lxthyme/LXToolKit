//
//  XLBaseModel.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import ObjectMapper

struct XLBaseModel<T: BaseMappable>: ImmutableMappable {
    // MARK: 🔗Vaiables
    let code: Int
    let msg: String
    let tips: String
    let data: T
    // MARK: 🛠Life Cycle
    init(map: Map) throws {
        code = try map.value("code")
        msg = try map.value("msg")
        tips = try map.value("tips")
        data = try map.value("data")
    }
    func mapping(map: Map) {
        code >>> map["code"]
        msg >>> map["msg"]
        tips >>> map["tips"]
        data >>> map["data"]
    }
}

struct XLBaseListModel<T: BaseMappable>: ImmutableMappable {
    // MARK: 🔗Vaiables
    let page: Int
    let totalPage: Int
    let list: [T]
    // MARK: 🛠Life Cycle
    init(map: Map) throws {
        page = try map.value("page")
        totalPage = try map.value("totalPage")
        list = try map.value("list")
    }
    func mapping(map: Map) {
        page >>> map["page"]
        totalPage >>> map["totalPage"]
        list >>> map["list"]
    }
}
