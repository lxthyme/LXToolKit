//
//  Data + ex.swift
//  Alamofire
//
//  Created by LXThyme Jason on 2020/9/29.
//

import Foundation


public extension Data {
    var hexString: String {
        withUnsafeBytes { (bytes: UnsafePointer<UInt8>) -> String in
            let buffer = UnsafeBufferPointer(start: bytes, count: count)
            return buffer.map {String(format: "%02hhx", $0)}.reduce("", { $0 + $1 })
        }
    }
}
