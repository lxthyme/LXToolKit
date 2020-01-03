//
//  LXPrint.swift
//  Vaffle_demo
//
//  Created by DamonJow on 2018/10/26.
//  Copyright © 2018 DamonJow. All rights reserved.
//

import UIKit
import Moya

/// DEBUG 打印
public func print(_ items: Any..., separator: String = " ", terminator: String = "\n", file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) {
//    dlog(items, separator: separator, terminator: terminator, file: file, function: function, line: line, column: column)
    Swift.print("print")
}
public func printIn(_ items: Any..., separator: String = " ", terminator: String = "\t", file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) {
//    dlog(items, separator: separator, terminator: terminator, file: file, function: function, line: line, column: column)
    Swift.print("printIn")
}
public func print<T>(_ message: T..., separator: String = " ", terminator: String = "\n", file: String = #file, function: String = #function,
              line: Int = #line, column: Int = #column) {
//    dlog(message, separator: separator, terminator: terminator, file: file, function: function, line: line, column: column)
    Swift.print("print<T>")
}
public func dlog(_ items: Any..., separator: String = " ", terminator: String = "\n", file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    let date = Date()
    Swift.print("""
        🐧<\(fileName).\(function):\(line):\(column) \(date.description)>
        """)
    for (idx, element) in items.enumerated() {
        Swift.print("🕷$\(idx): ", terminator: "")
        Swift.print(element)
    }

    Swift.print("")
    #endif
}

public let dlogIn = printIn
public let dlog = printIn

public func debugPrint(_ items: Any..., separator: String = ", ", terminator: String = "") {
    print("debugPrint")
}
