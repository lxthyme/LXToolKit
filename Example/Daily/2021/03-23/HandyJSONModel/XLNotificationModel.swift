//
//  XLNotificationModel.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//
import Foundation
import HandyJSON

class XLNotificationModel: NSObject, HandyJSON {
    var id: String?
    var lastReadAt: Date?
    var reason: String?
    var repository: XLRepositoryModel?
    var subject: XLSubjectModel?
    var subscriptionUrl: String?
    var unread: Bool?
    var updatedAt: Date?
    var url: String?
    required override init() {}

     func mapping(mapper: HelpingMapper) {
    //     super.mapping(mapper: mapper)
        mapper <<< lastReadAt <-- "last_read_at"
        mapper <<< subscriptionUrl <-- "subscription_url"
        mapper <<< updatedAt <-- "updated_at"
     }
    // override func didFinishMapping() {
    //     super.didFinishMapping()
    // }
    override var debugDescription: String { return toJSONString(prettyPrint: true) ?? "---" }
}
struct XLSubjectModel: HandyJSON {
    var latestCommentUrl: String?
    var title: String?
    var type: String?
    var url: String?
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< latestCommentUrl <-- "latest_comment_url"
    }
}
