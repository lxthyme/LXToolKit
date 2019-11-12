//
//  LXBaseModel.swift
//  Vaffle_demo
//
//  Created by LXThyme on 2019/1/10.
//  Copyright © 2019 DamonJow. All rights reserved.
//

import Foundation
import HandyJSON

public enum NetWorkError: Error {
    case errorCode
    case noData
    case jsonError
    case others(resultCode: Int?, resultMsg: String?)
    case networkError
}

open class LXBaseModel<T: HandyJSON>: NSObject, HandyJSON {
    deinit {
        dlog("---------- >>>Model: \(self.xl_typeName)\t\tdeinit <<<----------")
    }
    var code: Int?
    var msg: String?
    var data: T?
    var fullJsonString: String?
    required public override init() {}

    public func mapping(mapper: HelpingMapper) {
        mapper >>> self.fullJsonString
    }
}

open class LXBaseListModel<T: HandyJSON>: NSObject, HandyJSON {
    deinit {
        dlog("---------- >>>ModelList: \(self.xl_typeName)\t\tdeinit <<<----------")
    }
    var page: UInt?
    var total_page: UInt?

    var list: [T]?

    required public override init() {}

    public func mapping(mapper: HelpingMapper) {
//        mapper <<< self.list <-- "data.list"
    }
}
