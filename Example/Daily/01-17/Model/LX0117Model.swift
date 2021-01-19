//
//  LX0117Model.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/1/17.
//  Copyright © 2021 CocoaPods. All rights reserved.
//
import Foundation
import HandyJSON

class LX0117Model: NSObject, HandyJSON {
    var page : Int = 0
    var total_page: Int = 0

    class ListItem: NSObject, HandyJSON {
        var year: String = ""
        var month: String = ""
        var id : Int = 0
        var title: String = ""
        var dt: Int = 0
        var growthValue: String = ""
        var created_at_timestamp: TimeInterval = 0.0
        required override init() {}

        /// override var debugDescription: String { return toJSONString() ?? "" }
    }
    var list: [LX0117Model.ListItem] = []
    required override init() {}

    // func mapping(mapper: HelpingMapper) {}
    // override var debugDescription: String { return "" }
}
