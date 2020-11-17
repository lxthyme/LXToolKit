//
//  LXBaseModel.swift
//  Vaffle_demo
//
//  Created by LXThyme on 2019/1/10.
//  Copyright © 2019 DamonJow. All rights reserved.
//

import Foundation
import HandyJSON

open class LXAnyModel: NSObject, HandyJSON {
    deinit {
        dlog("---------- >>>Model: \(self.xl_typeName)\t\tdeinit <<<----------")
    }
    required public override init() {}

    /// override var debugDescription: String { return "" }
}
open class BaseModel: LXAnyModel {
    public var code: Int?
    public var msg: String?
    public var tips: String?
    public var fullJsonString: String?
    required public override init() {}

    public func mapping(mapper: HelpingMapper) {
        mapper >>> self.fullJsonString
    }

    /// override var debugDescription: String { return "" }
}
open class LXBaseModel<T: HandyJSON>: BaseModel {
    public var data: T?
    required public override init() {}

//    public func mapping(mapper: HelpingMapper) {}

    /// override var debugDescription: String { return "" }
}

open class LXBaseListModel<T: HandyJSON>: BaseModel {
    public var page: UInt?
    public var total_page: UInt?
    public var list: [T]?

    required public override init() {}

    /// override var debugDescription: String { return "" }
}
