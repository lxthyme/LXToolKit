//
//  XLCommentModel.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//
import Foundation
import HandyJSON
import MessageKit

class XLCommentModel: NSObject, HandyJSON {
    var authorAssociation: String?
    var body: String?
    var createdAt: Date?
    var htmlUrl: String?
    var id: Int?
    var issueUrl: String?
    var nodeId: String?
    var updatedAt: Date?
    var url: String?
    var user: XLUserModel?

    // MessageType
    var sender: SenderType { return user ?? XLUserModel() }
    var messageId: String { return id?.string ?? "" }
    var sentDate: Date { return createdAt ?? Date() }
    var kind: MessageKind { return .text(body ?? "") }
    required override init() {}

     func mapping(mapper: HelpingMapper) {
    //     super.mapping(mapper: mapper)
        mapper <<< authorAssociation <-- "author_association"
        mapper <<< createdAt <-- "created_at"
        mapper <<< htmlUrl <-- "html_url"
        mapper <<< issueUrl <-- "issue_url"
        mapper <<< nodeId <-- "node_id"
        mapper <<< updatedAt <-- "updated_at"
     }
    // override func didFinishMapping() {
    //     super.didFinishMapping()
    // }
    override var debugDescription: String { return toJSONString(prettyPrint: true) ?? "---" }
}
