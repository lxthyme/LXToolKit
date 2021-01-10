//
//  RxError.swift
//  LXToolKit
//
//  Created by LXThyme Jason on 2021/1/9.
//

import Foundation

public enum RxMoyaError: Error {
    case unknown
    case error(error: Error)
    case invalidHTTPCode(code: Int)
    case unReachable
//    case codeInvalid(code: Int?, data: HandyJSON?, tips: String?, msg: String?)
    case codeInvalid(code: Int?, base: BaseModel)
    case invalidJSON
    case noData
    case success
    case timeout
    case cancelled
}

public enum LXEmptyType: Int {
    case success
    case timeout
    case server
    case notLogin
    case noData
}
