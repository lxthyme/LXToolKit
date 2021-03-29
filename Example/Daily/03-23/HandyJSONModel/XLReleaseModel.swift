//
//  XLReleaseModel.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//
import Foundation
import HandyJSON

class XLReleaseModel: NSObject, HandyJSON {
    var assets: [XLAssetModel]?
    var assetsUrl: String?
    var author: XLUserModel?
    var body: String?
    var createdAt: Date?
    var draft: Bool?
    var htmlUrl: String?
    var id: Int?
    var name: String?
    var nodeId: String?
    var prerelease: Bool?
    var publishedAt: Date?
    var tagName: String?
    var tarballUrl: String?
    var targetCommitish: String?
    var uploadUrl: String?
    var url: String?
    var zipballUrl: String?
    required override init() {}

     func mapping(mapper: HelpingMapper) {
    //     super.mapping(mapper: mapper)
        mapper <<< assetsUrl <-- "assets_url"
        mapper <<< createdAt <-- "created_at"
        mapper <<< htmlUrl <-- "html_url"
        mapper <<< nodeId <-- "node_id"
        mapper <<< publishedAt <-- "published_at"
        mapper <<< tagName <-- "tag_name"
        mapper <<< tarballUrl <-- "tarball_url"
        mapper <<< targetCommitish <-- "target_commitish"
        mapper <<< uploadUrl <-- "upload_url"
        mapper <<< zipballUrl <-- "zipball_url"
     }
    // override func didFinishMapping() {
    //     super.didFinishMapping()
    // }
    override var debugDescription: String { return toJSONString(prettyPrint: true) ?? "---" }
}

struct XLAssetModel: HandyJSON {
    var browserDownloadUrl: String?
    var contentType: String?
    var createdAt: String?
    var downloadCount: Int?
    var id: Int?
    var label: String?
    var name: String?
    var nodeId: String?
    var size: Int?
    var state: String?
    var updatedAt: String?
    var uploader: XLUserModel?
    var url: String?
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< browserDownloadUrl <-- "browser_download_url"
        mapper <<< contentType <-- "content_type"
        mapper <<< createdAt <-- "created_at"
        mapper <<< downloadCount <-- "download_count"
        mapper <<< nodeId <-- "node_id"
        mapper <<< updatedAt <-- "updated_at"
    }
}
