//
//  XLCommitterModel.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//
import Foundation
import HandyJSON

class XLCommitterModel: NSObject, HandyJSON {
    var name: String?
    var email: String?
    var date: Date?
    required override init() {}

    // func mapping(mapper: HelpingMapper) {
    //     super.mapping(mapper: mapper)
    // }
    // override func didFinishMapping() {
    //     super.didFinishMapping()
    // }
    override var debugDescription: String { return toJSONString(prettyPrint: true) ?? "---" }
}
