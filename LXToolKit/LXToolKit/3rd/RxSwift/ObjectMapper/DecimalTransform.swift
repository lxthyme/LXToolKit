//
//  DecimalTransform.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/11/15.
//
import UIKit
import ObjectMapper

open class DecimalTransform: ObjectMapper.TransformType {
    // MARK: 🔗Vaiables
    public typealias Object = Decimal
    public typealias JSON = Decimal
    // MARK: 🛠Life Cycle
    public init() {}
    public func transformFromJSON(_ value: Any?) -> Decimal? {
        var result: Decimal?
        if let num = value as? Double {
            result = Decimal(num)
        } else if let num = value as? NSNumber {
            result = Decimal(string: num.description)
        } else if let string = value as? String {
            result = Decimal(string: string)
        }
        // if let count = result?.string.count,
        //    count > 5 {
        //     kitLog("-->result: \(result?.string ?? "NaN")")
        // }
        return result
    }
    public func transformToJSON(_ value: Decimal?) -> Decimal? {
        return value
    }
}

// MARK: 👀Public Actions
extension DecimalTransform {}

// MARK: 🔐Private Actions
private extension DecimalTransform {}
