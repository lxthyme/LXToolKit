//
//  LXString.swift
//  Vaffle_demo
//
//  Created by DamonJow on 2018/10/26.
//  Copyright © 2018 DamonJow. All rights reserved.
//
import UIKit

public extension String {
    /// 从字符串初始化一个 VC 实例
    func xl_getVCInstance<T: UIViewController>() -> T? {
        return self.xl_getObjcInstance()
    }
    func xl_getInstance<T>() -> T? {
        return self.xl_getObjcInstance() as? T
    }
    /// 从字符串初始化一个 NSObject 实例
    func xl_getObjcInstance<T: NSObject>() -> T? {
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String,
            let cls = NSClassFromString(nameSpace + "." + self),
            let objType = cls as? T.Type else { return nil }
        let instance = objType.init()
        return instance
    }
}
public extension Int64 {
    /// 根据字节大小返回文件大小字符KB、MB
    var xl_fileSize: String {
        return ByteCountFormatter.string(fromByteCount: self, countStyle: .file)
    }
}

public typealias UnicodeEqualInfo = (Bool, nsstring: Bool, equal: Bool, utf8: Bool, utf16: Bool)
public extension String {
    var xl_unicodeName: [String] {
        return self.unicodeScalars.lazy.map { $0.xl_unicodeName }
    }
    var xl_unicodeValue: [String] {
        return self.unicodeScalars.lazy.map { "\\u{\(String($0.value, radix: 16, uppercase: true))}" }
    }
    var xl_unicodeInfo: (length: Int, count: Int, utf8: Int, utf16: Int, unicode: [(name: String, code: String)]) {
        let merge = zip(self.xl_unicodeName, self.xl_unicodeValue).map { $0 }
        return (length: (self as NSString).length, count: self.count, utf8: self.utf8.count, utf16: self.utf16.count, unicode: merge)
    }
    func xl_unicodeEqual(to r: String) -> UnicodeEqualInfo {
        let e0 = self == r
        let e1 = (self as NSString) == (r as NSString)
        let e2 = self.elementsEqual(r)
        let e3 = self.utf8.elementsEqual(r.utf8)
        let e4 = self.utf16.elementsEqual(r.utf16)
        return (e0, nsstring: e1, equal: e2, utf8: e3, utf16: e4)
    }
    func xl_unicodeEqual(l: String, r: String) -> UnicodeEqualInfo {
        return l.xl_unicodeEqual(to: r)
    }
}
public extension StringTransform {
    static let xl_toUnicodeName = StringTransform(rawValue: "Any-Name")
}
public extension Unicode.Scalar {
    var xl_unicodeName: String {
        let name = String(self).applyingTransform(.toUnicodeName, reverse: false)!
        let prefixPattern = "\\N{"
        let suffixPattern = "}"
        let prefixLength = name.hasPrefix(prefixPattern) ? prefixPattern.count : 0
        let suffixLength = name.hasSuffix(suffixPattern) ? suffixPattern.count : 0
        return String(name.dropFirst(prefixLength).dropLast(suffixLength).localizedLowercase)
    }
}

public extension String {
    func xl_wrapped(after: Int = 70) -> String {
        var i = 0
        let lines = self.split(omittingEmptySubsequences: false) { char in
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

public extension String {
    var xl_urlEscaped: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
}

// MARK: - 👀
public extension String {
    func xl_toFloat() ->Float? {
        let numberFormatter = NumberFormatter()
        return numberFormatter.number(from: self)?.floatValue
    }
    func xl_toDouble() ->Double? {
        let numberFormatter = NumberFormatter()
        return numberFormatter.number(from: self)?.doubleValue
    }
}
