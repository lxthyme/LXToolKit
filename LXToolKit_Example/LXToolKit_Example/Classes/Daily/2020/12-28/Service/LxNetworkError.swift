//
//  LxNetworkError.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/21.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

enum LXNetworkError: Error {
    case unReachable
    case invalidJSON
    case invalidHTTPCode
    case other(error: Error)
}
