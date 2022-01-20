//
//  XLLicenseModel.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//
import Foundation
import HandyJSON

class XLLicenseModel: NSObject, HandyJSON {
    var key: String?
    var name: String?
    var nodeId: String?
    var spdxId: AnyObject?
    var url: AnyObject?
    required override init() {}

     func mapping(mapper: HelpingMapper) {
    //     super.mapping(mapper: mapper)
        mapper <<< nodeId <-- "node_id"
        mapper <<< spdxId <-- "spdx_id"
     }
    // override func didFinishMapping() {
    //     super.didFinishMapping()
    // }
    override var debugDescription: String { return toJSONString(prettyPrint: true) ?? "---" }
}
