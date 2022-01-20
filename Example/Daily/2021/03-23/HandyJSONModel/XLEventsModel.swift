//
//  XLEventsModel.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//
import Foundation
import HandyJSON

enum CreateEventType: String, HandyJSONEnum {
    case repository
    case branch
    case tag
}

enum DeleteEventType: String, HandyJSONEnum {
    case repository
    case branch
    case tag
}

/// Event Types
///
/// - fork: Triggered when a user forks a repository.
/// - commitComment: Triggered when a commit comment is created.
/// - create: Represents a created repository, branch, or tag.
/// - issueComment: Triggered when an issue comment is created, edited, or deleted.
/// - issues: Triggered when an issue is assigned, unassigned, labeled, unlabeled, opened, edited, milestoned, demilestoned, closed, or reopened.
/// - member: Triggered when a user accepts an invitation or is removed as a collaborator to a repository, or has their permissions changed.
/// - organizationBlock: Triggered when an organization blocks or unblocks a user.
/// - `public`: Triggered when a private repository is open sourced. Without a doubt: the best GitHub event.
/// - release: Triggered when a release is published.
/// - star: The WatchEvent is related to starring a repository, not watching.
enum EventType: String, HandyJSONEnum {
    case fork = "ForkEvent"
    case commitComment = "CommitCommentEvent"
    case create = "CreateEvent"
    case delete = "DeleteEvent"
    case issueComment = "IssueCommentEvent"
    case issues = "IssuesEvent"
    case member = "MemberEvent"
    case organizationBlock = "OrgBlockEvent"
    case `public` = "PublicEvent"
    case pullRequest = "PullRequestEvent"
    case pullRequestReviewComment = "PullRequestReviewCommentEvent"
    case push = "PushEvent"
    case release = "ReleaseEvent"
    case star = "WatchEvent"
    case unknown = ""
}

class XLEventsModel: NSObject, HandyJSON {
    var actor: XLUserModel?
    var createdAt: String?
    var id: String?
    var organization: XLUserModel?
    var isPublic: Bool?
    var repository: XLRepositoryModel?
    var type: EventType = .unknown

    var payload: XLPayloadModel?
    required override init() {}

     func mapping(mapper: HelpingMapper) {
//         super.mapping(mapper: mapper)
        mapper <<< createdAt <-- "created_at"
//        mapper <<< createdAt <-- CustomDateFormatTransform(formatString: "yyyy-MM-dd")
        mapper <<< isPublic <-- "is_public"
     }
    func didFinishMapping() {
    //     super.didFinishMapping()
     }
    override var debugDescription: String { return toJSONString(prettyPrint: true) ?? "---" }
}

// MARK: - 👀
extension EventType {
    func getPayload() -> XLPayloadModel {
        switch self {
        case .fork: return XLPayloadModel.ForkPayload()
        case .create: return XLPayloadModel.CreatePayload()
        case .delete: return XLPayloadModel.DeletePayload()
        case .issueComment: return XLPayloadModel.IssueCommentPayload()
        case .issues: return XLPayloadModel.IssuesPayload()
        case .member: return XLPayloadModel.MemberPayload()
        case .pullRequest: return XLPayloadModel.PullRequestPayload()
        case .pullRequestReviewComment: return XLPayloadModel.PullRequestReviewCommentPayload()
        case .push: return XLPayloadModel.PushPayload()
        case .release: return XLPayloadModel.ReleasePayload()
        case .star: return XLPayloadModel.StarPayload()
        default: return XLPayloadModel()
        }
    }
}

class XLPayloadModel: NSObject, HandyJSON {
    var actor: XLUserModel?
    var createdAt: Date?
    var id: String?
    var organization: XLUserModel?
    var isPublic: Bool?
    var repository: XLRepositoryModel?
    var type: EventType = .unknown

    var payload: XLPayloadModel?
    required override init() {}

     func mapping(mapper: HelpingMapper) {
    //     super.mapping(mapper: mapper)
        mapper <<< createdAt <-- "created_at"
        mapper <<< isPublic <-- "is_public"
     }
    func didFinishMapping() {
    //     super.didFinishMapping()
    }
    override var debugDescription: String { return toJSONString(prettyPrint: true) ?? "---" }
}

// MARK: - 👀
extension XLPayloadModel {
    class ForkPayload: XLPayloadModel {
//        var repository: Repository?
    }

    class CreatePayload: XLPayloadModel {
        var ref: String?
        var refType: CreateEventType = .repository
        var masterBranch: String?
//        var description: String?
        var pusherType: String?
        override func mapping(mapper: HelpingMapper) {
            super.mapping(mapper: mapper)
            mapper <<< refType <-- "ref_type"
            mapper <<< masterBranch <-- "master_branch"
            mapper <<< pusherType <-- "pusher_type"
        }
    }

    class DeletePayload: XLPayloadModel {
        var ref: String?
        var refType: DeleteEventType = .repository
        var pusherType: String?
        override func mapping(mapper: HelpingMapper) {
            super.mapping(mapper: mapper)
            mapper <<< refType <-- "ref_type"
            mapper <<< pusherType <-- "pusher_type"
        }
    }

    class IssueCommentPayload: XLPayloadModel {
        var action: String?
        var issue: XLIssueModel?
        var comment: XLCommentModel?
    }

    class IssuesPayload: XLPayloadModel {
        var action: String?
        var issue: XLIssueModel?
//        var repository: Repository?
    }

    class MemberPayload: XLPayloadModel {
        var action: String?
        var member: XLUserModel?
    }

    class PullRequestPayload: XLPayloadModel {
        var action: String?
        var number: Int?
        var pullRequest: XLPullRequestModel?
        override func mapping(mapper: HelpingMapper) {
            super.mapping(mapper: mapper)
            mapper <<< pullRequest <-- "pull_request"
        }
    }

    class PullRequestReviewCommentPayload: XLPayloadModel {
        var action: String?
        var comment: XLCommentModel?
        var pullRequest: XLPullRequestModel?
        override func mapping(mapper: HelpingMapper) {
            super.mapping(mapper: mapper)
            mapper <<< pullRequest <-- "pull_request"
        }
    }

    class PushPayload: XLPayloadModel {
        var ref: String?
        var size: Int?
        var commits: [XLCommitModel] = []
    }

    class ReleasePayload: XLPayloadModel {
        var action: String?
        var release: XLReleaseModel?
    }

    class StarPayload: XLPayloadModel {
        var action: String?
    }
}
