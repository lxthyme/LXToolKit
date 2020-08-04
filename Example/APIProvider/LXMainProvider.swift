//
//  LXMainProvider.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/6/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

enum LXMainProvider: APIService {
    case zen
    case newUserFloat
    case platformInfo
    var params: APIParameter? {
        switch self {
            case .zen:
                return ("/api/zen", ["zen": 233])
            case .newUserFloat:
                return ("/api/newuser/float", ["user": 234])
            case .platformInfo:
                return ("/api/platform/info", [:])
        }
    }
}
