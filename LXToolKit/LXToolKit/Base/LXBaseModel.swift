//
//  LXBaseModel.swift
//  Vaffle_demo
//
//  Created by LXThyme on 2019/1/10.
//  Copyright © 2019 DamonJow. All rights reserved.
//

import Foundation
import HandyJSON

enum RxSwiftMoyaError: Error {
    case RxSwiftMoyaNoRepresentor
    case RxSwiftMoyaNotSuccessfulHTTP
    case RxSwiftMoyaNoData
    case RxSwiftMoyaCouldNotMakeObjectError
    case RxSwiftMoyaBizError(resultCode: Int?, resultMsg: String?)
    case RXSwiftMoyaNoNetwork
}

public enum NetWorkError: Error {
    case errorCode
    case noData
    case jsonError
    case others(resultCode: Int?, resultMsg: String?)
    case networkError
}

open class LXAnyModel: NSObject, HandyJSON {
    required public override init() {}

    /// override var debugDescription: String { return "" }
}

open class BaseModel: LXAnyModel {
    var code: Int?
    var msg: String?
    var tips: String?
    var data: [String: Any]?
    required public init() {}

    /// override var debugDescription: String { return "" }
}

open class LXBaseModel<T: HandyJSON>: LXAnyModel {
    deinit {
        dlog("---------- >>>Model: \(self.xl_typeName)\t\tdeinit <<<----------")
    }
    var code: Int?
    var msg: String?
    var tips: String?
    var data: T?
    var fullJsonString: String?
    required public override init() {}

    public func mapping(mapper: HelpingMapper) {
        mapper >>> self.fullJsonString
    }

    /// override var debugDescription: String { return "" }
}

open class LXBaseListModel<T: HandyJSON>: LXAnyModel {
    deinit {
        dlog("---------- >>>ModelList: \(self.xl_typeName)\t\tdeinit <<<----------")
    }
    var page: UInt?
    var total_page: UInt?

    var list: [T]?

    /// v4.0.5
    /// 帮助中心问题列表【POST】
    var officialUuid: String?

    required public override init() {}

    public func mapping(mapper: HelpingMapper) {
//        mapper <<< self.list <-- "data.list"
    }
}
