//
//  XLBranchModel.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//
import Foundation
import HandyJSON

class XLBranchModel: NSObject, HandyJSON {
    //    var links: Link?
    var commit: XLCommitModel?
    var name: String?
    var protectedField: Bool?
    var protectionUrl: String?
    required override init() {}

     func mapping(mapper: HelpingMapper) {
    //     super.mapping(mapper: mapper)
        mapper <<< protectedField <-- "protected_field"
        mapper <<< protectionUrl <-- "protection_url"
     }
    // override func didFinishMapping() {
    //     super.didFinishMapping()
    // }
    override var debugDescription: String { return toJSONString(prettyPrint: true) ?? "---" }
}
