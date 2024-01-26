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
public struct LogKit {}
@available(iOS 14.0, *)
public struct LogKitt {
    // typealias T = Logger
    var logger: Logger
}

@available(iOS 14.0, *)
public let loggerNormal = LogKitt(logger: Logger(subsystem: LogKit.subsystem, category: "Normal Logger"))
/// Logs the view cycles like a view that appeared.
@available(iOS 14.0, *)
public let loggerViewCycle = LogKitt(logger: Logger(subsystem: LogKit.subsystem, category: "LifeCycle Logger"))
@available(iOS 14.0, *)
public let loggerKit = LogKitt(logger: Logger(subsystem: LogKit.subsystem, category: "「LXToolKit」"))
/// dealloc log
@available(iOS 14.0, *)
public let loggerDealloc = LogKitt(logger: Logger(subsystem: LogKit.subsystem, category: "Dealloc Logger"))
@available(iOS 14.0, *)
public let loggerRxSwift = LogKitt(logger: Logger(subsystem: LogKit.subsystem, category: "RxSwift Logger"))
/// All logs related to tracking and analytics.
@available(iOS 14.0, *)
public let loggerAnalysis = LogKitt(logger: Logger(subsystem: LogKit.subsystem, category: "Analysis Logger"))

// MARK: - 👀Logger
extension LogKit {
    /// Using your bundle identifier is a great way to ensure a unique identifier.
    fileprivate static var subsystem = "「\(Bundle.main.bundleIdentifier ?? "Unknown bundleIdentifier")」"

    // logger.info("An unsigned integer \(x, format: .hex, align: .right(columns: 10))")
    // logger.info("An unsigned integer \(x, privacy: .private)")
}

// MARK: - 👀Logger bridge
@available(iOS 14.0, *)
extension LogKitt {
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
        case viewDidLoad
        case viewWillAppear
        case viewIsAppearing
        case viewDidAppear
        case viewWillDisappear
        case viewDidDisappear
        case viewWillLayoutSubviews
        case viewDidLayoutSubviews
    }
    // MARK: 🛠Life Cycle
    public static func traceLifeCycle(_ prefix: LifeCycleStyle, typeName: String, type: LifeCycleType) {
        let msg = "----->>>\(prefix == .none ? "" : "「\(prefix)」"): \(typeName): \t\t\(type)"
        if #available(iOS 14.0, *) {
        loggerViewCycle.trace("\(msg)")
        }
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
        if #available(iOS 14.0, *) {
        loggerRxSwift.trace("「\(type)」\(items)")
        }
    }
    @discardableResult
    public static func resourcesCount() -> Int32 {
        var total: Int32 = 0
        #if DEBUG && TRACE_RESOURCES
        total = RxSwift.Resources.total
        if #available(iOS 14.0, *) {
        loggerRxSwift.trace("RxSwift resources count: \(total)")
        }
        #endif
        return total
    }
}
// MARK: - 👀 LXToolKit Logger
extension LogKit {
    public static func kitLog(_ items: Any) {
        if #available(iOS 14.0, *) {
        loggerKit.debug(items)
        }
    }
}

/// DEBUG 打印
public func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
//    dlog(items)
    Swift.print("print")
}
public func dlog(_ items: Any) {
    if #available(iOS 14.0, *) {
    loggerNormal.debug(items)
    }
}
public func dlog(_ items: Any...) {
    if #available(iOS 14.0, *) {
    loggerNormal.debug(items)
    }
}

// public let dlogIn = printIn
// public let dlog = printIn
// public let dlog = logger.x_debug

public func debugPrint(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    print("debugPrint")
}
