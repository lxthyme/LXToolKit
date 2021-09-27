//
//  LXSongRecordItemModel.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2020/12/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
import Foundation
import HandyJSON
import LXToolKit

public enum SongSegmentStatus {
    case songRecord
    case songSquare
    case songHistory
}

class LXSongRecordItemModel: LXAnyModel {
    var bg_video_id: String?
    var bg_video_url: String?
    var video_id: String?
    var display: String?
    var image_url: String = ""
    var user_id: String?
    var edit_time: String?
    var image_id: String?
    var kidsong_song_id: String?
    var name: String?
    var add_time: String?
    var kidsong_user_has_song_id: String?
    var record_url: String?
    var nickname: String?
    var video_url: String?
    required init() {}

    /// override var debugDescription: String { return "" }
}
