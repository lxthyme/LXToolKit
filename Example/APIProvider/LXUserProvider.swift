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
    var params: APIParameter? {
        switch self {
            case .newUserFloat:
                return ("/api/newuser/float", ["user": 234])
        }
    }
}
