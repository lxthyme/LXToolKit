//
//  LXLXBaseListModel.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/6/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import HandyJSON

class LXBaseListModel<T: HandyJSON>: LXAnyModel {
    var page: Int?
    var totalPage: Int?
    var lastId: String?
    var list: [T]?
    required init() {}

    /// override var debugDescription: String { return "" }
}
