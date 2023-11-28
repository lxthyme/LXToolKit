//
//  LXResultModel.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/9/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
import Foundation
import HandyJSON

class LXResultModel: XLLBaseModel {
    class ResultModel: NSObject, HandyJSON {
        var author:String?
        var content:String?
        var category:String?
        var origin:String?
        required override init() {}

        // func mapping(mapper: HelpingMapper) {}
        // override var debugDescription: String { return "" }
    }
    var result: ResultModel?
    required init() {}

    // func mapping(mapper: HelpingMapper) {}
    // override var debugDescription: String { return "" }
}
