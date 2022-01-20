//
//  XLContactModel.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//
import Foundation
import HandyJSON

class XLContactModel: NSObject, HandyJSON {
    var id: String?
    var name: String?
    var phones: [String] = []
    var emails: [String] = []

    var imageData: Data?
    required override init() {}

     func mapping(mapper: HelpingMapper) {
    //     super.mapping(mapper: mapper)
        mapper <<< imageData <-- "image_data"
     }
    // override func didFinishMapping() {
    //     super.didFinishMapping()
    // }
    override var debugDescription: String { return toJSONString(prettyPrint: true) ?? "---" }
}
