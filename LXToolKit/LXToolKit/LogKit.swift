//
//  LogKit.swift
//  LXToolKit2
//
//  Created by LXThyme Jason on 2021/3/12.
//

import Foundation
import RxSwift
import OSLog
import CocoaLumberjack

/// | level    | icon |
/// | -------- | ---- |
/// | log      | 🚧   |
/// | trace    | 🔗   |
/// | debug    | 👉   |
/// | info     | 📌   |
/// | notice   | 👀   |
/// | warning  | ⚠️   |
/// | error    | ❌   |
/// | critical | ❗   |
/// | fault    | 🎈   |
enum LogType: String {
    case log = "🚧"
    case trace = "🔗"
    case debug = "👉"
    case info = "📌"
    case notice = "👀"
    case warning = "⚠️"
    case error = "❌"
    case critical = "❗"
    case fault = "🎈"
}
public struct LogKit {
    typealias T = Logger
    let logger: T
}

public let loggerNormal = LogKit(logger: Logger(subsystem: LogKit.subsystem, category: "Normal Logger"))
/// Logs the view cycles like a view that appeared.
public let loggerViewCycle = LogKit(logger: Logger(subsystem: LogKit.subsystem, category: "LifeCycle Logger"))
public let loggerKit = LogKit(logger: Logger(subsystem: LogKit.subsystem, category: "「LXToolKit」"))
/// dealloc log
public let loggerDealloc = LogKit(logger: Logger(subsystem: LogKit.subsystem, category: "Dealloc Logger"))
public let loggerRxSwift = LogKit(logger: Logger(subsystem: LogKit.subsystem, category: "RxSwift Logger"))
/// All logs related to tracking and analytics.
public let loggerAnalysis = LogKit(logger: Logger(subsystem: LogKit.subsystem, category: "Analysis Logger"))

// MARK: - 👀Logger
extension LogKit {
    /// Using your bundle identifier is a great way to ensure a unique identifier.
    fileprivate static var subsystem = "「\(Bundle.main.bundleIdentifier ?? "Unknown bundleIdentifier")」"

    // logger.info("An unsigned integer \(x, format: .hex, align: .right(columns: 10))")
    // logger.info("An unsigned integer \(x, privacy: .private)")
}

// MARK: - 👀Logger bridge
extension LogKit {
    public func log(_ message: Any) {
        guard #available(iOS 14.0, *) else {
            DDLogInfo("🚧\(message)")
            return
        }
        logger.log("🚧\(String(describing: message))")
    }
    public func log(level: OSLogType = .default, message: String) {
        guard #available(iOS 14.0, *) else {
            DDLogInfo("🚧\(message)")
            return
        }
        logger.log(level: level, "🚧\(String(describing: message))")
    }
    public func trace(_ message: Any) {
        guard #available(iOS 14.0, *) else {
            DDLogVerbose("🔗\(message)")
            return
        }
        logger.trace("🔗\(String(describing: message))")
    }
    public func debug(_ message: Any) {
        guard #available(iOS 14.0, *) else {
            DDLogDebug("👉\(message)")
            return
        }
        logger.debug("👉\(String(describing: message))")
    }
    public func info(_ message: Any) {
        guard #available(iOS 14.0, *) else {
            DDLogInfo("📌\(message)")
            return
        }
        logger.info("📌\(String(describing: message))")
    }
    public func notice(_ message: Any) {
        guard #available(iOS 14.0, *) else {
            DDLogInfo("👀\(message)")
            return
        }
        logger.notice("👀\(String(describing: message))")
    }
    public func warning(_ message: Any) {
        guard #available(iOS 14.0, *) else {
            DDLogWarn("⚠️\(message)")
            return
        }
        logger.warning("⚠️\(String(describing: message))")
    }
    public func error(_ message: Any) {
        guard #available(iOS 14.0, *) else {
            DDLogError("❌\(message)")
            return
        }
        logger.error("❌\(String(describing: message))")
    }
    public func critical(_ message: Any) {
        guard #available(iOS 14.0, *) else {
            DDLogInfo("❗\(message)")
            return
        }
        logger.critical("❗\(String(describing: message))")
    }
    public func fault(_ message: Any) {
        guard #available(iOS 14.0, *) else {
            DDLogInfo("🎈\(message)")
            return
        }
        logger.fault("🎈\(String(describing: message))")
    }
}

// MARK: - 👀Life Cycle Logger
extension LogKit {
    public enum LifeCycleStyle: String {
        case none
        case NSObject
        case vc = "VC"
        case flutterVC = "FlutterVC"
        case view = "View"
        case vm = "ViewModel"
        case model = "Model"
        case cell = "Cell"
        case TableViewCell
        case CollectionViewCell
        case TableViewCellVM
        case CollectionViewCellVM
    }
    public enum LifeCycleType: String {
        case `init` = "Initial"
        case `deinit` = "Deinited"
        case didReceiveMemoryWarning
    }
    // MARK: 🛠Life Cycle
    public static func traceLifeCycle(_ prefix: LifeCycleStyle, typeName: String, type: LifeCycleType) {
        let msg = "----->>>\(prefix == .none ? "" : "「\(prefix)」"): \(typeName): \t\t\(type)"
        loggerViewCycle.trace("\(msg)")
    }
}
// MARK: - 👀RxSwift
extension LogKit {
    public enum RxSwiftLogType: String {
        case onNext
        case afterNext
        case onError
        case afterError
        case onCompleted
        case afterCompleted
        case onSubscribe
        case onSubscribed
        case onDispose
    }
    public static func logRxSwift(_ type: RxSwiftLogType, items: Any) {
        loggerRxSwift.trace("「\(type)」\(items)")
    }
    @discardableResult
    public static func resourcesCount() -> Int32 {
        var total: Int32 = 0
        #if DEBUG && TRACE_RESOURCES
        total = RxSwift.Resources.total
        loggerRxSwift.trace("RxSwift resources count: \(total)")
        #endif
        return total
    }
}
// MARK: - 👀 LXToolKit Logger
extension LogKit {
    public static func kitLog(_ items: Any) {
        loggerKit.debug(items)
    }
}

/// DEBUG 打印
public func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
//    dlog(items)
    Swift.print("print")
}
public func dlog(_ items: Any) {
    loggerNormal.debug(items)
}
public func dlog(_ items: Any...) {
    loggerNormal.debug(items)
}

// public let dlogIn = printIn
// public let dlog = printIn
// public let dlog = logger.x_debug

public func debugPrint(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    print("debugPrint")
}
