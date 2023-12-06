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
import RxSwift

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
public struct LogKit {}

@available(iOS 14.0, *)
let logger = Logger(subsystem: LogKit.subsystem, category: "Normal Logger")

// MARK: - 👀Logger
@available(iOS 14.0, *)
extension LogKit {
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
// MARK: - 👀Logger bridge
extension LogKit {
    public static func x_log(_ message: Any, separator: String = " ", terminator: String = "\n", file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) {
        guard #available(iOS 14.0, *) else {
            DDLogInfo("🚧\(message)")
            return
        }
        logger.log("🚧\(String(describing: message))")
    }
    public static func x_log(level: OSLogType = .default, message: String, separator: String = " ", terminator: String = "\n", file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) {
        guard #available(iOS 14.0, *) else {
            DDLogInfo("🚧\(message)")
            return
        }
        logger.log(level: level, "🚧\(String(describing: message))")
    }
    public static func x_trace(_ message: Any, separator: String = " ", terminator: String = "\n", file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) {
        guard #available(iOS 14.0, *) else {
            DDLogVerbose("🔗\(message)")
            return
        }
        logger.trace("🔗\(String(describing: message))")
    }
    public static func xl_debug(_ items: Any..., separator: String = " ", terminator: String = "\n", file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) {
        // let fileName = (file as NSString).lastPathComponent
        // let date = Date()
        // logger.debug("""
        //     👇<\(fileName).\(function):\(line):\(column) \(date.description)>
        //     """)
        // for (idx, element) in items.enumerated() {
        //     // Swift.print("🕷$\(idx): ", terminator: "")
        //     // Swift.print(element)
        //     logger.debug("👉$\(idx): \(String(describing: element))")
        // }
        DDLogDebug("👉\(items)")
    }
    public static func x_debug(_ message: Any, separator: String = " ", terminator: String = "\n", file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) {
        guard #available(iOS 14.0, *) else {
            DDLogDebug("👉\(message)")
            return
        }
        logger.debug("👉\(String(describing: message))")
    }
    public static func x_info(_ message: Any, separator: String = " ", terminator: String = "\n", file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) {
        guard #available(iOS 14.0, *) else {
            DDLogInfo("📌\(message)")
            return
        }
        logger.info("📌\(String(describing: message))")
    }
    public static func x_notice(_ message: Any, separator: String = " ", terminator: String = "\n", file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) {
        guard #available(iOS 14.0, *) else {
            DDLogInfo("👀\(message)")
            return
        }
        logger.notice("👀\(String(describing: message))")
    }
    public static func x_warning(_ message: Any, separator: String = " ", terminator: String = "\n", file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) {
        guard #available(iOS 14.0, *) else {
            DDLogWarn("⚠️\(message)")
            return
        }
        logger.warning("⚠️\(String(describing: message))")
    }
    public static func x_error(_ message: Any, separator: String = " ", terminator: String = "\n", file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) {
        guard #available(iOS 14.0, *) else {
            DDLogError("❌\(message)")
            return
        }
        logger.error("❌\(String(describing: message))")
    }
    public static func x_critical(_ message: Any, separator: String = " ", terminator: String = "\n", file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) {
        guard #available(iOS 14.0, *) else {
            DDLogInfo("❗\(message)")
            return
        }
        logger.critical("❗\(String(describing: message))")
    }
    public static func x_fault(_ message: Any, separator: String = " ", terminator: String = "\n", file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) {
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
        case view = "View"
        case vm = "ViewModel"
        case model = "Model"
        case cell = "Cell"
        case TableViewCell
        case CollectionViewCell
    }
    public enum LifeCycleType: String {
        case `init` = "Initial"
        case `deinit` = "Deinited"
        case didReceiveMemoryWarning
    }
    // MARK: 🛠Life Cycle
    public static func traceLifeCycle(_ prefix: LifeCycleStyle, typeName: String, type: LifeCycleType, separator: String = " ", terminator: String = "\n", file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) {
        let msg = "---------->>>🔗\(prefix == .none ? "" : "「\(prefix)」"): \(typeName): \t\t\(type) <<<----------"
        if #available(iOS 14.0, *) {
            // trace("🔗\(message)")
            LogKit.viewCycle.trace("\(msg)")
        } else {
            // Fallback on earlier versions
            DDLogVerbose(msg)
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
    public static func logRxSwift(_ type: RxSwiftLogType, items: Any..., separator: String = " ", terminator: String = "\n", file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) {
        let msg = "「\(type)」\(items)"
        if #available(iOS 14.0, *) {
            LogKit.rxswift.trace("\(msg)")
        } else {
            // Fallback on earlier versions
            LogKit.x_trace(msg)
        }
    }
    public static func resourcesCount() {
        #if DEBUG && TRACE_RESOURCES
        LogKit.rxswift.debug("RxSwift resources count: \(RxSwift.Resources.total)")
        #endif
    }
}
// MARK: - 👀 LXToolKit Logger
extension LogKit {
    public static func kitLog(_ items: Any..., separator: String = " ", terminator: String = "\n", file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) {
        let msg = "「LXToolKit」\(items)"
        if #available(iOS 14.0, *) {
            logger.debug("\(msg)")
        } else {
            // Fallback on earlier versions
            LogKit.xl_debug(msg)
        }
    }
}

/// DEBUG 打印
public func print(_ items: Any..., separator: String = " ", terminator: String = "\n", file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) {
//    dlog(items, separator: separator, terminator: terminator, file: file, function: function, line: line, column: column)
    Swift.print("print")
}
public func printIn(_ items: Any..., separator: String = " ", terminator: String = "\t", file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) {
//    dlog(items, separator: separator, terminator: terminator, file: file, function: function, line: line, column: column)
    Swift.print("printIn")
}
public func print<T>(_ message: T..., separator: String = " ", terminator: String = "\n", file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) {
//    dlog(message, separator: separator, terminator: terminator, file: file, function: function, line: line, column: column)
    Swift.print("print<T>")
}
public func dlog(_ items: Any..., separator: String = " ", terminator: String = "\n", file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) {
    if #available(iOS 14.0, *) {
    #if DEBUG
    // let fileName = (file as NSString).lastPathComponent
    // let date = Date()
    // logger.debug("""
    //     👇<\(fileName).\(function):\(line):\(column) \(date.description)>
    //     """)
    for (idx, element) in items.enumerated() {
        // Swift.print("🕷$\(idx): ", terminator: "")
        // Swift.print(element)
        logger.debug("👉$\(idx): \(String(describing: element))")
    }
    #endif
    } else {
        // Fallback on earlier versions
        LogKit.xl_debug(items, separator: separator, terminator: terminator)
    }
}

public let dlogIn = printIn
// public let dlog = printIn
// public let dlog = logger.x_debug

public func debugPrint(_ items: Any..., separator: String = ", ", terminator: String = "") {
    print("debugPrint")
}
