//
//  LXBaseModel.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
import Foundation
import HandyJSON

open class XLLBaseModel: NSObject, HandyJSON {
    public var code: Int?
    public var msg: String?
    public required override init() {}

    // func mapping(mapper: HelpingMapper) {}
    // override var debugDescription: String { return "" }
}
