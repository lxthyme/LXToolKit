//
//  XLBaseModel.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import HandyJSON

class XLAnyModel: HandyJSON {
    // MARK: 🔗Vaiables
    required init() {}
}
class XLBaseModel<T: HandyJSON>: HandyJSON {
    // MARK: 🔗Vaiables
    var code: Int = 0
    var msg: String = ""
    var tips: String = ""
    var data: T?
    var origin_json: String = ""
    // MARK: 🛠Life Cycle
    required init() {}
    func mapping(mapper: HelpingMapper) {
        mapper >>> origin_json
    }
}

class XLBaseListModel<T: HandyJSON>: HandyJSON {
    // MARK: 🔗Vaiables
    var page: Int = 1
    var totalPage: Int = 0
    var list: [T] = []
    // MARK: 🛠Life Cycle
    required init() {}
    func mapping(mapper: HelpingMapper) {
        mapper <<< totalPage <-- "total_page"
    }
}
