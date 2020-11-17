//
//  LXUserProvider.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/6/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import LXToolKit

enum LXUserProvider: APIService {
    case newUserFloat
    var baseURL: String {
        return LX_Base_URL
    }
    var params: APIParameter {
        switch self {
            case .newUserFloat:
                return APIParameter(path: "/api/newuser/float", params: ["user": 234])
        }
    }
}
