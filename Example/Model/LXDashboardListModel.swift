//
//  LXDashboardListModel.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/6/19.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import HandyJSON

enum PostCategory: String, HandyJSONEnum {
    case posts
}

class LXDashboardListModel: NSObject, HandyJSON {
    var follower_count, comment_count, praise_count, collect_count: Int?
    var original_count: Int?

    class TopList: NSObject, HandyJSON {
        var id, type: Int?
        var post_cover: String?
        var post_cover_ratio: Double?
        var content, source_content: String?
        var category: PostCategory?
        var title, source_title: String?
        var created_at, post_praise_count, post_comment_count, post_original_count: Int?
        var post_collect_count: Int?
        var ticket: String?
        required override init() {}

        /// override var debugDescription: String { return "" }
    }
    var top_list: [TopList]?

    class PlanList: NSObject, HandyJSON {
        var id, type: Int?
        var cover: String?
        var post_cover_ratio: Double?
        var category: PostCategory?
        var content, source_content, title, source_title: String?
        var plan_time, timing_status: Int?
        var start_time: String?
        var created_at: Int?
        var ticket: String?

        class Res: NSObject, HandyJSON {
            var path_url: String?
            var cover: String?
            var ratio: Double?
            var s3_cover: String?
            var id: Int?
            var s3_path_url: String?
            required override init() {}

            /// override var debugDescription: String { return "" }
        }
        var res: [Res]?
        required override init() {}

        /// override var debugDescription: String { return "" }
    }
    var plan_list: [PlanList]?
    required override init() {}

    /// override var debugDescription: String { return "" }
}
