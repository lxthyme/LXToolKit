//
//  Action + checkError.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2020/12/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import Action
import RxSwift
import LXToolKit

// MARK: - 👀
extension Action {
    var checkError: Observable<LXEmptyType> {
        return errors.map { error -> LXEmptyType in
            switch error {
                case .notEnabled: return .server
                case .underlyingError(let error):
                    return error.toEmptyType
            }
        }
    }
}

// MARK: - 👀
extension Error {
    var toEmptyType: LXEmptyType {
        switch (self as NSError).code {
            /// -1001（请求超时）
            case NSURLErrorTimedOut:
                return .timeout
            /// -1000（请求的URL错误，无法启动请求）
            case NSURLErrorBadURL,
                 ///-1003（URL的host名称无法解析，即DNS有问题）
                 NSURLErrorCannotFindHost,
                 ///-1003（URL的host名称无法解析，即DNS有问题）
                 NSURLErrorCannotFindHost,
                 ///-1004（连接host失败）
                 NSURLErrorCannotConnectToHost,
                 ///-1003（URL的host名称无法解析，即DNS有问题）
                 NSURLErrorCannotFindHost,
                 ///-1009（断网状态）
                 NSURLErrorNotConnectedToInternet:
                return .server
            default:
                return .server
        }
    }
}
