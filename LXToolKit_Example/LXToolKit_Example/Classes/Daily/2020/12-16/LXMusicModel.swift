//
//  LXMusicModel.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2020/12/16.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
import Foundation
import HandyJSON

class LXMusicModel: NSObject, HandyJSON {
    var name: String?
    var singer: String?
    required override init() {}

    // func mapping(mapper: HelpingMapper) {}
    override var debugDescription: String {
        return toJSONString(prettyPrint: true) ?? "NaN"
    }
}
