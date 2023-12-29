//
//  CrashlyticsManager.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 2023/12/23.
//

import Foundation
import FirebaseCrashlytics

public struct CrashlyticsManager {}

// MARK: - 👀
public extension CrashlyticsManager {
    /// 添加自定义键
    static func setCustomKeysAndValues(_ keysAndValues: [AnyHashable: Any]) {
        Crashlytics.crashlytics().setCustomKeysAndValues(keysAndValues)
    }
    /// 添加自定义日志消息
    static func log(msg: String) {
        Crashlytics.crashlytics().log(msg)
    }
    /// 报告非严重异常
    static func record(error: Error, userInfo: [String: Any]? = nil) {
        Crashlytics.crashlytics().record(error: error, userInfo: userInfo)
    }
    /// 自定义调用栈轨迹
    static func record(exceptionModel: ExceptionModel) {
        Crashlytics.crashlytics().record(exceptionModel: exceptionModel)
    }
}
