//
//  LXString.swift
//  Vaffle_demo
//
//  Created by DamonJow on 2018/10/26.
//  Copyright © 2018 DamonJow. All rights reserved.
//
import UIKit

extension String: NamespaceWrappable {}
public extension TypeWrapperProtocol where WrappedType == String {
    /// 从字符串初始化一个 VC 实例
    func getVCInstance<T: UIViewController>() -> T? {
        return self.getObjcInstance()
    }
    func getInstance<T>() -> T? {
        return self.getObjcInstance() as? T
    }
    /// 从字符串初始化一个 NSObject 实例
    func getObjcInstance<T: NSObject>() -> T? {
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String,
            let cls = NSClassFromString(nameSpace + "." + wrappedValue),
            let objType = cls as? T.Type else { return nil }
        let instance = objType.init()
        return instance
    }
}
extension Int64: NamespaceWrappable {}
public extension TypeWrapperProtocol where WrappedType == Int64 {
    /// 根据字节大小返回文件大小字符KB、MB
    var fileSize: String {
        return ByteCountFormatter.string(fromByteCount: wrappedValue, countStyle: .file)
    }
}

public typealias UnicodeEqualInfo = (Bool, nsstring: Bool, equal: Bool, utf8: Bool, utf16: Bool)

public extension TypeWrapperProtocol where WrappedType == String {
    var unicodeName: [String] {
        return wrappedValue.unicodeScalars.lazy.map { $0.xl.unicodeName }
    }
    var unicodeValue: [String] {
        return wrappedValue.unicodeScalars.lazy.map { "\\u{\(String($0.value, radix: 16, uppercase: true))}" }
    }
    var unicodeInfo: (length: Int, count: Int, utf8: Int, utf16: Int, unicode: [(name: String, code: String)]) {
        let merge = zip(self.unicodeName, self.unicodeValue).map { $0 }
        return (length: (wrappedValue as NSString).length, count: wrappedValue.count, utf8: wrappedValue.utf8.count, utf16: wrappedValue.utf16.count, unicode: merge)
    }
    func unicodeEqual(to r: String) -> UnicodeEqualInfo {
        let e0 = wrappedValue == r
        let e1 = (wrappedValue as NSString) == (r as NSString)
        let e2 = wrappedValue.elementsEqual(r)
        let e3 = wrappedValue.utf8.elementsEqual(r.utf8)
        let e4 = wrappedValue.utf16.elementsEqual(r.utf16)
        return (e0, nsstring: e1, equal: e2, utf8: e3, utf16: e4)
    }
    func unicodeEqual(l: String, r: String) -> UnicodeEqualInfo {
        return l.xl.unicodeEqual(to: r)
    }
}
extension StringTransform: NamespaceWrappable {}
public extension TypeWrapperProtocol where WrappedType == StringTransform {
    var toUnicodeName: StringTransform {
        return StringTransform(rawValue: "Any-Name")
    }
}
extension Unicode.Scalar: NamespaceWrappable {}
public extension TypeWrapperProtocol where WrappedType == Unicode.Scalar {
    var unicodeName: String {
        let name = String(wrappedValue).applyingTransform(.toUnicodeName, reverse: false)!
        let prefixPattern = "\\N{"
        let suffixPattern = "}"
        let prefixLength = name.hasPrefix(prefixPattern) ? prefixPattern.count : 0
        let suffixLength = name.hasSuffix(suffixPattern) ? suffixPattern.count : 0
        return String(name.dropFirst(prefixLength).dropLast(suffixLength).localizedLowercase)
    }
}

public extension TypeWrapperProtocol where WrappedType == String {
    func wrapped(after: Int = 70) -> String {
        var i = 0
        let lines = wrappedValue.split(omittingEmptySubsequences: false) { char in
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

public extension TypeWrapperProtocol where WrappedType == String {
    var urlEscaped: String? {
        return wrappedValue.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
}

// MARK: - 👀
public extension TypeWrapperProtocol where WrappedType == String {
    func toFloat() ->Float? {
        let numberFormatter = NumberFormatter()
        return numberFormatter.number(from: wrappedValue)?.floatValue
    }
    func toDouble() ->Double? {
        let numberFormatter = NumberFormatter()
        return numberFormatter.number(from: wrappedValue)?.doubleValue
    }
}
