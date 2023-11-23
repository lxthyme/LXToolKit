//
//  LXString.swift
//  Vaffle_demo
//
//  Created by DamonJow on 2018/10/26.
//  Copyright © 2018 DamonJow. All rights reserved.
//
import UIKit

// MARK: - 👀
extension String: Error {}

public extension Swifty where Base == String {
//public extension Swifty where Base == String {
    /// 从字符串初始化一个 VC 实例
    /// - Returns: VC 实例
    func getVCInstance<T: UIViewController>(expect: T.Type = UIViewController.self) -> T? {
        return self.getInstance(expect: expect)
    }
    func getVCCls<T: UIViewController>(expect: T.Type = UIViewController.self) -> T.Type? {
        return self.getCls(expect: expect)
    }
    /// 从字符串初始化一个 NSObject 实例
    /// - Returns: NSObject 实例
    func getInstance<T: NSObject>(expect: T.Type) -> T? {
        guard let nameSpace = Bundle.main.infoDictionary?["CFBundleExecutable"] as? String,
              let cls = NSClassFromString(nameSpace + "." + base),
              let objType = cls as? T.Type else { return nil }
        let instance = objType.init()
        return instance
    }
    func getCls<T: NSObject>(expect: T.Type) -> T.Type? {
        guard let nameSpace = Bundle.main.infoDictionary?["CFBundleExecutable"] as? String,
              let cls = NSClassFromString(nameSpace + "." + base),
              let objType = cls as? T.Type else { return nil }
        return objType
    }
}

public extension Swifty where Base == Int64 {
    /// 根据字节大小返回文件大小字符KB、MB
    var fileSize: String {
        return ByteCountFormatter.string(fromByteCount: base, countStyle: .file)
    }
}

public typealias UnicodeEqualInfo = (Bool, nsstring: Bool, equal: Bool, utf8: Bool, utf16: Bool)

public extension Swifty where Base == String {
    var unicodeName: [String] {
        return base.unicodeScalars.lazy.map { $0.xl.unicodeName }
    }
    var unicodeValue: [String] {
        return base.unicodeScalars.lazy.map { "\\u{\(String($0.value, radix: 16, uppercase: true))}" }
    }
    var unicodeInfo: (length: Int, count: Int, utf8: Int, utf16: Int, unicode: [(name: String, code: String)]) {
        let merge = zip(self.unicodeName, self.unicodeValue).map { $0 }
        return (length: (base as NSString).length,
                count: base.count,
                utf8: base.utf8.count,
                utf16: base.utf16.count,
                unicode: merge)
    }
    func unicodeEqual(to r: String) -> UnicodeEqualInfo {
        let e0 = base == r
        let e1 = (base as NSString) == (r as NSString)
        let e2 = base.elementsEqual(r)
        let e3 = base.utf8.elementsEqual(r.utf8)
        let e4 = base.utf16.elementsEqual(r.utf16)
        return (e0,
                nsstring: e1,
                equal: e2,
                utf8: e3,
                utf16: e4)
    }
    func unicodeEqual(l: String, r: String) -> UnicodeEqualInfo {
        return l.xl.unicodeEqual(to: r)
    }
}

public extension Swifty where Base == StringTransform {
    var toUnicodeName: StringTransform {
        return StringTransform(rawValue: "Any-Name")
    }
}

public extension Swifty where Base == Unicode.Scalar {
    var unicodeName: String {
        let name = String(base).applyingTransform(.toUnicodeName, reverse: false)!
        let prefixPattern = "\\N{"
        let suffixPattern = "}"
        let prefixLength = name.hasPrefix(prefixPattern) ? prefixPattern.count : 0
        let suffixLength = name.hasSuffix(suffixPattern) ? suffixPattern.count : 0
        return String(name.dropFirst(prefixLength).dropLast(suffixLength).localizedLowercase)
    }
}

public extension Swifty where Base == String {
    func wrapped(after: Int = 70) -> String {
        var i = 0
        let lines = base.split(omittingEmptySubsequences: false) { char in
            switch char {
            case "\n",
                 " " where i >= after:
                i = 0
                return true
            default:
                i += 1
                return false
            }
        }
        return lines.joined(separator: "\n")
    }
}
public extension Collection where Element: Equatable {
    func xl_split<S: Sequence>(separators: S) -> [SubSequence] where Element == S.Element {
        return split { separators.contains($0) }
    }
}

public extension Swifty where Base == String {
    var urlEscaped: String? {
        return base.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
}

// MARK: - 👀
public extension Swifty where Base == String {
    func toFloat() ->Float? {
        let numberFormatter = NumberFormatter()
        return numberFormatter.number(from: base)?.floatValue
    }
    func toDouble() ->Double? {
        let numberFormatter = NumberFormatter()
        return numberFormatter.number(from: base)?.doubleValue
    }
}
