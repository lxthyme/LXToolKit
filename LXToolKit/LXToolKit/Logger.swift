//
//  Logger.swift
//  LXToolKit2
//
//  Created by LXThyme Jason on 2021/3/12.
//

import Foundation
import RxSwift
import OSLog

public struct Log {}

// MARK: - 👀
extension Log {
    public static func resourcesCount() {
        #if DEBUG && TRACE_RESOURCES
        Log.rxswift.debug("RxSwift resources count: \(RxSwift.Resources.total)")
        #endif
    }
}

@available(iOS 14.0, *)
let logger = Logger(subsystem: Log.subsystem, category: "Normal Logger")

// MARK: - 👀
@available(iOS 14.0, *)
extension Log {
    /// Using your bundle identifier is a great way to ensure a unique identifier.
    fileprivate static var subsystem = "「\(Bundle.main.bundleIdentifier ?? "Unknown bundleIdentifier")」"


    /// Logs the view cycles like a view that appeared.
    public static let viewCycle = Logger(subsystem: subsystem, category: "LifeCycle Logger")
    /// dealloc log
    public static let dealloc = Logger(subsystem: subsystem, category: "Dealloc Logger")
    public static let rxswift = Logger(subsystem: subsystem, category: "RxSwift Logger")
    /// All logs related to tracking and analytics.
    public static let statistics = Logger(subsystem: subsystem, category: "Analysis Logger")
    // logger.info("An unsigned integer \(x, format: .hex, align: .right(columns: 10))")
    // logger.info("An unsigned integer \(x, privacy: .private)")
}
