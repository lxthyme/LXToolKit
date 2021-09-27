//
//  API.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2020/12/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import LXToolKit

enum SongService: APIService {
    case recordList(sort: String?, page: Int?, pageSize: Int?) /// 儿歌列表
    /// 音乐广场
    case musicCenter
    ///我的录制
    case myRecord
    ///成长值充值记录
    case growthRecord(page: Int, lastYearMonth: String, last_id: String)
    var baseURL: String {
        return "http://api.com:3003/api/uu"
    }
    var params: APIParameter {
        switch self {
            case .recordList(let sort, let page, let pageSize):
                var p: [String: Any] = [:]
                if let s = sort {
                    p["sort"] = s
                }
                if let page = page {
                    p["page"] = page
                }
                if let ps = pageSize {
                    p["pageSize"] = ps
                }
                return APIParameter(path: "kidsong/song-api/get-list", params: p)
            case .musicCenter: return APIParameter(path: "kidsong/song-api/kidsong-square", params: [:])
            case .myRecord: return APIParameter(path: "kidsong/song-api/get-user-list", params: [:])
            case .growthRecord(let page, let lastYearMonth, let last_id):
                return APIParameter(path: "/account/growth/record", params: [
                    "page": page,
                    "lastYearMonth": lastYearMonth,
                    "last_id": last_id
                ])
        }
    }
}
