//
//  LXBaseModel.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
import Foundation
import HandyJSON

class XLLBaseModel: NSObject, HandyJSON {
    var code: Int?
    var msg: String?
    required override init() {}

    // func mapping(mapper: HelpingMapper) {}
    // override var debugDescription: String { return "" }
}
