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
    public func transformFromJSON(_ value: Any?) -> Decimal? {
        if let num = value as? Double {
            return Decimal(num)
        } else if let num = value as? NSNumber {
            return Decimal(string: num.description)
        } else if let string = value as? String {
            return Decimal(string: string)
        }
        return nil
    }
    public func transformToJSON(_ value: Decimal?) -> Decimal? {
        return value
    }
}

// MARK: 👀Public Actions
extension DecimalTransform {}

// MARK: 🔐Private Actions
private extension DecimalTransform {}
