//
//  LXNewUserFloat.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/6/19.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import HandyJSON

class LXNewUserFloatModel: NSObject, HandyJSON {
    var session, is_receive, start_time, end_time: Int?
    var remain_end_time, remain_time, is_deadline: Int?
    var url: String?
    required override init() {}

    /// override var debugDescription: String { return "" }
}
