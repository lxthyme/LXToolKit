//
//  XLCommitModel.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//
import Foundation
import HandyJSON

class XLCommitModel: NSObject, HandyJSON {
    var url: String?
    var commentsUrl: String?
    var commit: CommitInfo?
    var files: [File]?
    var htmlUrl: String?
    var nodeId: String?
//    var parents: [Tree]?
    var sha: String?
    var stats: Stat?
    var author: XLUserModel?
    var committer: XLUserModel?
    required override init() {}

     func mapping(mapper: HelpingMapper) {
    //     super.mapping(mapper: mapper)
        mapper <<< commentsUrl <-- "comments_url"
        mapper <<< htmlUrl <-- "html_url"
        mapper <<< nodeId <-- "node_id"
     }
    // override func didFinishMapping() {
    //     super.didFinishMapping()
    // }
    override var debugDescription: String { return toJSONString(prettyPrint: true) ?? "---" }
}

struct CommitInfo: HandyJSON {
    var author: XLCommitterModel?
    var commentCount: Int?
    var committer: XLCommitterModel?
    var message: String?
    var url: String?
    var verification: Verification?
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< commentCount <-- "comment_count"
    }
}

struct Stat: HandyJSON {
    var additions: Int?
    var deletions: Int?
    var total: Int?
}

struct File: HandyJSON {
    var additions: Int?
    var blobUrl: String?
    var changes: Int?
    var deletions: Int?
    var filename: String?
    var patch: String?
    var rawUrl: String?
    var status: String?
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< blobUrl <-- "blob_url"
        mapper <<< rawUrl <-- "raw_url"
    }
}

struct Verification: HandyJSON {
    var payload: AnyObject?
    var reason: String?
    var signature: AnyObject?
    var verified: Bool?
}
