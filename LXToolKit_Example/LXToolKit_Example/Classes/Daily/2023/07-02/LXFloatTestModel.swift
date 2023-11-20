//
//  LXFloatTestModel.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/7/2.
//
import Foundation
import ObjectMapper
import LXToolKit

typealias LXTestType = Decimal
struct LXCodableTestModel: Codable {
    var name: String?
    var f0: [LXTestType]?
    var f1: [LXTestType]?
    var f2: [LXTestType]?
    // var f3: [NSDecimalNumber]?
    var f3: [LXTestType]?
    var f4: [LXTestType]?
    var f5: [LXTestType]?
    var f6: [LXTestType]?
    var f7: [LXTestType]?
    var f8: [LXTestType]?
    var f9: [LXTestType]?
    var f10: [LXTestType]?
    var f11: [LXTestType]?
    var f12: [LXTestType]?
    var t1: Decimal?
    var t2: Decimal?
    var f_t1: Decimal?
    var all: [LXTestType] {
        var tmp: [LXTestType] = []
        if let f0 { tmp += f0 }
        if let f1 { tmp += f1 }
        if let f2 { tmp += f2 }
        if let f3 { tmp += f3 }
        if let f4 { tmp += f4 }
        if let f5 { tmp += f5 }
        if let f6 { tmp += f6 }
        if let f7 { tmp += f7 }
        if let f8 { tmp += f8 }
        if let f9 { tmp += f9 }
        if let f10 { tmp += f10 }
        return tmp
    }

}

struct LXFloatTestModel: LXMappable {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    var name: String?
    var f0: [Decimal]?
    var f1: [Decimal]?
    var f2: [Decimal]?
    // var f3: [NSDecimalNumber]?
    var f3: [Decimal]?
    var f4: [Decimal]?
    var f5: [Decimal]?
    var f6: [Decimal]?
    var f7: [Decimal]?
    var f8: [Decimal]?
    var f9: [Decimal]?
    var f10: [Decimal]?
    var f11: [Decimal]?
    var f12: [Decimal]?
    var t1: Decimal?
    var t2: Decimal?
    var all: [Decimal] {
        var tmp: [Decimal] = []
        if let f0 { tmp += f0 }
        if let f1 { tmp += f1 }
        if let f2 { tmp += f2 }
        if let f3 { tmp += f3 }
        if let f4 { tmp += f4 }
        if let f5 { tmp += f5 }
        if let f6 { tmp += f6 }
        if let f7 { tmp += f7 }
        if let f8 { tmp += f8 }
        if let f9 { tmp += f9 }
        if let f10 { tmp += f10 }
        return tmp
    }
    // MARK: 🛠Life Cycle
    // required init() {}
    // 
    init?(map: ObjectMapper.Map) {}
    mutating func mapping(map: ObjectMapper.Map) {
        name <- map["name"]
        f0 <- (map["f0"], DecimalTransform())
        f1 <- (map["f1"], DecimalTransform())
        f2 <- (map["f2"], DecimalTransform())
        f3 <- (map["f3"], DecimalTransform())
        f4 <- (map["f4"], DecimalTransform())
        f5 <- (map["f5"], DecimalTransform())
        f6 <- (map["f6"], DecimalTransform())
        f7 <- (map["f7"], DecimalTransform())
        f8 <- (map["f8"], DecimalTransform())
        f9 <- (map["f9"], DecimalTransform())
        f10 <- (map["f10"], DecimalTransform())
        f11 <- (map["f11"], DecimalTransform())
        f12 <- (map["f12"], DecimalTransform())
        t1 <- (map["t1"], DecimalTransform())
        t2 <- (map["t2"], DecimalTransform())
    }

    // override var debugDescription: String { return toJSONString(prettyPrint: true) ?? "---" }
}
