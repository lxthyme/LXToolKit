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
//    DDLogError(_ message: @autoclosure () -> Any,
//                           level: DDLogLevel = DDDefaultLogLevel,
//                           context: Int = 0,
//                           file: StaticString = #file,
//                           function: StaticString = #function,
//                           line: UInt = #line,
//                           tag: Any? = nil,
//                           asynchronous async: Bool = false,
//                           ddlog: DDLog = .sharedInstance)
    static func error(_ msg: @autoclosure () -> String,
                      level: DDLogLevel = .error,
                      context: Int = 0,
                      file: StaticString = #file,
                      function: StaticString = #function,
                      line: UInt = #line,
                      tag: Any? = nil,
                      asynchronous async: Bool = false,
                      ddlog: DDLog = .sharedInstance) {
        DDLogError("❗\(msg())",
                   level: .error,
                   context: 0,
                   file: file,
                   function: function,
                   line: line,
                   tag: tag,
                   asynchronous: async,
                   ddlog: ddlog)
    }
    static func resourcesCount() {
        #if DEBUG
        debug("RxSwift resources count: \(RxSwift.Resources.total)")
        #endif
    }
}
