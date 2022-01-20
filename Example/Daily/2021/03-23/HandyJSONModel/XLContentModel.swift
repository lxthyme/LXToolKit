//
//  XLContentModel.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//
import Foundation
import HandyJSON

enum ContentType: String, HandyJSONEnum {
    case file = "file"
    case dir = "dir"
    case symlink = "symlink"
    case submodule = "submodule"
    case unknown = ""
}

class XLContentModel: NSObject, HandyJSON {
    var content: String?
    var downloadUrl: String?
    var encoding: String?
    var gitUrl: String?
    var htmlUrl: String?
    var name: String?
    var path: String?
    var sha: String?
    var size: Int?
    var type: ContentType = .unknown
    var url: String?
    var target: String?
    var submoduleGitUrl: String?
    required override init() {}

     func mapping(mapper: HelpingMapper) {
    //     super.mapping(mapper: mapper)
        mapper <<< downloadUrl <-- "download_url"
        mapper <<< gitUrl <-- "git_url"
        mapper <<< htmlUrl <-- "html_url"
        mapper <<< submoduleGitUrl <-- "submodule_git_url"
     }
    // override func didFinishMapping() {
    //     super.didFinishMapping()
    // }
    override var debugDescription: String { return toJSONString(prettyPrint: true) ?? "---" }
}
