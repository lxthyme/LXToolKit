//
//  Date + ex.swift
//  Vaffle_demo
//
//  Created by DamonJow on 2018/10/31.
//  Copyright © 2018 DamonJow. All rights reserved.
//

import struct Foundation.Date

extension Date: NamespaceWrappable {}
public extension TypeWrapperProtocol where WrappedType == Date {
//public extension Swifty where Base == Date {
    static var now: Date {
        return Date()
    }
    /// 将 date 转换为时间戳，精确到微秒
    var timeStamp: TimeInterval {
        return wrappedValue.timeIntervalSince1970 * 1000 * 1000
    }
    /// 将当前时间转换为时间戳，精确到微秒
    static var nowTimeStamp: TimeInterval {
        return Date().xl.timeStamp
    }
    /// 时间戳(毫秒)转换为时间
   static func date(from timeStamp: TimeInterval) -> Date {
        return Date(timeIntervalSince1970: timeStamp * 0.001 * 0.001)
    }
    /// 当前时间与另外一个时间戳的间隔（s）
    static func timeStamp(to otherDate: Date) -> TimeInterval {
        return Date().timeIntervalSince(otherDate)
    }
    /// 当前时间与另外一个时间戳的间隔（s）
    static func timeStamp(to timeStamp: TimeInterval) -> TimeInterval {
        return Date().timeIntervalSince(Date.xl.date(from: timeStamp))
    }
}
