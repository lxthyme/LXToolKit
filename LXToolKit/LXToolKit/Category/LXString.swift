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
    func getVCInstance<T: UIViewController>() ->T? {
        return self.getObjcInstance()
    }
    func getInstance<T>() ->T? {
        return self.getObjcInstance() as? T
    }
    /// 从字符串初始化一个 NSObject 实例
    func getObjcInstance<T: NSObject>() ->T? {
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String,
            let cls = NSClassFromString(nameSpace + "." + self),
            let objType = cls as? T.Type else { return nil }
        let instance = objType.init()
        return instance
    }
}
public extension Int64 {
    /// 根据字节大小返回文件大小字符KB、MB
    var fileSize: String {
        return ByteCountFormatter.string(fromByteCount: self, countStyle: .file)
    }
}

public typealias UnicodeEqualInfo = (Bool, nsstring: Bool, equal: Bool, utf8: Bool, utf16: Bool)
public extension String {
    var unicodeName: [String] {
        return self.unicodeScalars.lazy.map { $0.unicodeName }
    }
    var unicodeValue: [String] {
        return self.unicodeScalars.lazy.map { "\\u{\(String($0.value, radix: 16, uppercase: true))}" }
    }
    var unicodeInfo: (length: Int, count: Int, utf8: Int, utf16: Int, unicode: [(name: String, code: String)]) {
        let merge = zip(self.unicodeName, self.unicodeValue).map { $0 }
        return (length: (self as NSString).length, count: self.count, utf8: self.utf8.count, utf16: self.utf16.count, unicode: merge)
    }
    func unicodeEqual(to r: String) ->UnicodeEqualInfo {
        let e0 = self == r
        let e1 = (self as NSString) == (r as NSString)
        let e2 = self.elementsEqual(r)
        let e3 = self.utf8.elementsEqual(r.utf8)
        let e4 = self.utf16.elementsEqual(r.utf16)
        return (e0, nsstring: e1, equal: e2, utf8: e3, utf16: e4)
    }
    func unicodeEqual(l: String, r: String) ->UnicodeEqualInfo {
        return l.unicodeEqual(to: r)
    }
}
public extension StringTransform {
    static let toUnicodeName = StringTransform(rawValue: "Any-Name")
}
public extension Unicode.Scalar {
    var unicodeName: String {
        let name = String(self).applyingTransform(.toUnicodeName, reverse: false)!
        let prefixPattern = "\\N{"
        let suffixPattern = "}"
        let prefixLength = name.hasPrefix(prefixPattern) ? prefixPattern.count : 0
        let suffixLength = name.hasSuffix(suffixPattern) ? suffixPattern.count : 0
        return String(name.dropFirst(prefixLength).dropLast(suffixLength).localizedLowercase)
    }
}

public extension String {
    func wrapped(after: Int = 70) ->String {
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
    func split<S: Sequence>(separators: S) ->[SubSequence] where Element == S.Element {
        return split { separators.contains($0) }
    }
}
