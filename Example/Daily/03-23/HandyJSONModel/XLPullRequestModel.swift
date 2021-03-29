//
//  XLPullRequestModel.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//
import Foundation
import HandyJSON

class XLPullRequestModel: NSObject, HandyJSON {
    var activeLockReason: String?
    var additions: Int?
    var assignee: XLUserModel?
    var assignees: [XLUserModel]?
    var authorAssociation: String?
//    var base: Base?
    var body: String?
    var changedFiles: Int?
    var closedAt: Date?
    var comments: Int?
    var commentsUrl: String?
    var commits: Int?
    var commitsUrl: String?
    var createdAt: Date?
    var deletions: Int?
    var diffUrl: String?
//    var head: Base?
    var htmlUrl: String?
    var id: Int?
    var issueUrl: String?
    var labels: [XLIssueLabelModel]?
    var locked: Bool?
    var maintainerCanModify: Bool?
    var mergeCommitSha: String?
    var mergeable: Bool?
    var mergeableState: String?
    var merged: Bool?
    var mergedAt: Date?
    var mergedBy: XLUserModel?
    var milestone: XLMilestoneModel?
    var nodeId: String?
    var number: Int?
    var patchUrl: String?
    var rebaseable: Bool?
    var requestedReviewers: [XLUserModel]?
//    var requestedTeams: [RequestedTeam]?
    var reviewCommentUrl: String?
    var reviewComments: Int?
    var reviewCommentsUrl: String?
    var state: XLState = .open
    var statusesUrl: String?
    var title: String?
    var updatedAt: Date?
    var url: String?
    var user: XLUserModel?
    required override init() {}

     func mapping(mapper: HelpingMapper) {
    //     super.mapping(mapper: mapper)
        mapper <<< activeLockReason <-- "active_lock_reason"
        mapper <<< authorAssociation <-- "author_association"
        mapper <<< changedFiles <-- "changed_files"
        mapper <<< closedAt <-- "closed_at"
        mapper <<< commentsUrl <-- "comments_url"
        mapper <<< commitsUrl <-- "commits_url"
        mapper <<< createdAt <-- "created_at"
        mapper <<< diffUrl <-- "diff_url"
        mapper <<< htmlUrl <-- "html_url"
        mapper <<< issueUrl <-- "issue_url"
        mapper <<< maintainerCanModify <-- "maintainer_can_modify"
        mapper <<< mergeCommitSha <-- "merge_commit_sha"
        mapper <<< mergeableState <-- "mergeable_state"
        mapper <<< mergedAt <-- "merged_at"
        mapper <<< mergedBy <-- "merged_by"
        mapper <<< nodeId <-- "node_id"
        mapper <<< patchUrl <-- "patch_url"
        mapper <<< requestedReviewers <-- "requested_reviewers"
        mapper <<< reviewCommentUrl <-- "review_comment_url"
        mapper <<< reviewComments <-- "review_comments"
        mapper <<< reviewCommentsUrl <-- "review_comments_url"
        mapper <<< statusesUrl <-- "statuses_url"
        mapper <<< updatedAt <-- "updated_at"
     }
    // override func didFinishMapping() {
    //     super.didFinishMapping()
    // }
    override var debugDescription: String { return toJSONString(prettyPrint: true) ?? "---" }
}
