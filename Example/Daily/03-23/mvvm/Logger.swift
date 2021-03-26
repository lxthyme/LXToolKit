//
//  Logger.swift
//  LXToolKit2
//
//  Created by LXThyme Jason on 2021/3/12.
//

import Foundation
import RxSwift
import CocoaLumberjack

struct Logger {}

// MARK: - 👀
extension Logger {
    static func info(_ msg: @autoclosure () -> String) {
        DDLogInfo(msg())
    }
    static func verbose(_ msg: @autoclosure () -> String) {
        DDLogVerbose(msg())
    }
    static func debug(_ msg: @autoclosure () -> String) {
        DDLogDebug(msg())
    }
    static func warn(_ msg: @autoclosure () -> String) {
        DDLogWarn(msg())
    }
    static func error(_ msg: @autoclosure () -> String) {
        DDLogError(msg())
    }
    static func resourcesCount() {
        #if DEBUG
        debug("RxSwift resources count: \(RxSwift.Resources.total)")
        #endif
    }
}
