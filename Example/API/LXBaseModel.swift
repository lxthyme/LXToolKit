//
//  LXBaseModel.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/6/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import HandyJSON

class LXAnyModel: NSObject, HandyJSON {
    required override init() {}

    /// override var debugDescription: String { return "" }
}

class LXBaseModel<T: HandyJSON>: LXAnyModel {
    var code: Int?
    var msg: String?
    var tips: String?
    var data: T?
    required init() {}

    /// override var debugDescription: String { return "" }
}

class BaseModel: LXAnyModel {
    var code: Int?
    var msg: String?
    var tips: String?
    var data: [String: Any]?
    required init() {}

    /// override var debugDescription: String { return "" }
}
