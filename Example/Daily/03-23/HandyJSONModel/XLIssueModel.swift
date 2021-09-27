//
//  XLIssueModel.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//
import Foundation
import HandyJSON

class XLIssueModel: NSObject, HandyJSON {
    var activeLockReason: String?
    var assignee: XLUserModel?
    var assignees: [XLUserModel]?
    var body: String?
    var closedAt: Date?
    var closedBy: XLUserModel?
    var comments: Int?
    var commentsUrl: String?
    var createdAt: Date?
    var eventsUrl: String?
    var htmlUrl: String?
    var id: Int?
    var labels: [XLIssueLabelModel]?
    var labelsUrl: String?
    var locked: Bool?
    var milestone: XLMilestoneModel?
    var nodeId: String?
    var number: Int?
    var pullRequest: XLPullRequestModel?
    var repositoryUrl: String?
    var state: XLState = .open
    var title: String?
    var updatedAt: Date?
    var url: String?
    var user: XLUserModel?
    required override init() {}

     func mapping(mapper: HelpingMapper) {
    //     super.mapping(mapper: mapper)
        mapper <<< activeLockReason <-- "active_lock_reason"
        mapper <<< closedAt <-- "closed_at"
        mapper <<< closedBy <-- "closed_by"
        mapper <<< commentsUrl <-- "comments_url"
        mapper <<< createdAt <-- "created_at"
        mapper <<< eventsUrl <-- "events_url"
        mapper <<< htmlUrl <-- "html_url"
        mapper <<< labelsUrl <-- "labels_url"
        mapper <<< nodeId <-- "node_id"
        mapper <<< pullRequest <-- "pull_request"
        mapper <<< repositoryUrl <-- "repository_url"
        mapper <<< updatedAt <-- "updated_at"
     }
    // override func didFinishMapping() {
    //     super.didFinishMapping()
    // }
    override var debugDescription: String { return toJSONString(prettyPrint: true) ?? "---" }
}

struct XLIssueLabelModel: HandyJSON {
    var color: String?
    var defaultField: Bool?
    var descriptionField: String?
    var id: Int?
    var name: String?
    var nodeId: String?
    var url: String?
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< defaultField <-- "default_field"
        mapper <<< descriptionField <-- "description_field"
        mapper <<< nodeId <-- "node_id"
    }
}
