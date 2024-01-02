//
//  LXCustomLoggerFormatter.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/30.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import CocoaLumberjack

public class LXCustomLoggerFormatter: NSObject, DDLogFormatter {
    let dateFormmater = DateFormatter()

    public override init() {
        super.init()
        dateFormmater.dateFormat = "yyyy/MM/dd HH:mm:ss:SSS"
    }

    // MARK: - DDLogFormatter
    public func format(message logMessage: DDLogMessage) -> String? {

        let logLevel: String
        switch logMessage.flag {
        case .error: logLevel = "❌"
        case .warning: logLevel = "⚠️"
        case .info: logLevel = "ⓘ"
        case .debug: logLevel = "🚀"
        case .verbose: logLevel = "🕷"
        default: logLevel = "💀"
        }

        let dt = dateFormmater.string(from: logMessage.timestamp)
        let logMsg = logMessage.message
        let lineNumber = logMessage.line
        let file = logMessage.fileName
        let functionName = logMessage.function
        let threadId = logMessage.threadID

        return "\(dt) [\(threadId)] [\(logLevel)] [\(file):\(lineNumber)]\(functionName ?? "NaN") - \(logMsg)"
    }
}
