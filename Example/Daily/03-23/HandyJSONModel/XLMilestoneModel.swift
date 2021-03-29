//
//  XLMilestoneModel.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//
import Foundation
import HandyJSON

class XLMilestoneModel: NSObject, HandyJSON {
    var closedAt: Date?
    var closedIssues: Int?
    var createdAt: Date?
    var creator: XLUserModel?
    var descriptionField: String?
    var dueOn: Date?
    var htmlUrl: String?
    var id: Int?
    var labelsUrl: String?
    var nodeId: String?
    var number: Int?
    var openIssues: Int?
    var state: XLState = .open
    var title: String?
    var updatedAt: Date?
    var url: String?
    required override init() {}

     func mapping(mapper: HelpingMapper) {
    //     super.mapping(mapper: mapper)
        mapper <<< closedAt <-- "closed_at"
        mapper <<< closedIssues <-- "closed_issues"
        mapper <<< createdAt <-- "created_at"
        mapper <<< descriptionField <-- "description_field"
        mapper <<< dueOn <-- "due_on"
        mapper <<< htmlUrl <-- "html_url"
        mapper <<< labelsUrl <-- "labels_url"
        mapper <<< nodeId <-- "node_id"
        mapper <<< openIssues <-- "open_issues"
        mapper <<< updatedAt <-- "updated_at"
     }
    // override func didFinishMapping() {
    //     super.didFinishMapping()
    // }
    override var debugDescription: String { return toJSONString(prettyPrint: true) ?? "---" }
}
