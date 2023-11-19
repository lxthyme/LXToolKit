//
//  LXBaseModel+HandyJSON.swift
//  LXToolKit
//
//  Created by lxthyme on 2023/11/19.
//

import Foundation
import HandyJSON

open class LXBaseHandyJSON: LXAnyModel, HandyJSON, LXBaseModelProtocol {
    // MARK: 🔗Vaiables
    public var msg: String?
    public var code: Int?
    public var errorTips: String?
    public var successTips: String?
    public var xl_origin_json: String?
    // MARK: 🛠Life Cycle
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    required public init() {
        super.init()
    }
    // open override func mapping(mapper: HelpingMapper) {
    //     mapper <<< self.xl_origin_json <-- "xl_origin_json"
    // }

    open override var debugDescription: String {
        return toJSONString(prettyPrint: true) ?? "--NaN-"
    }
}
open class LXBaseGenericHandyJSON<T: HandyJSON>: LXAnyModel, HandyJSON, LXBaseModelProtocol {
    // MARK: 🔗Vaiables
    public var code: Int?
    public var msg: String?
    public var errorTips: String?
    public var successTips: String?
    public var xl_origin_json: String?
    public var data: T?
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    required public init() {
        super.init()
    }

    // init?(map: ObjectMapper.Map) {}
    // mutating func mapping(map: Map) {
    //     xl_origin_json <- map["xl_origin_json"]
    // }

    open override var debugDescription: String {
        return toJSONString(prettyPrint: true) ?? "--NaN-"
    }
}

open class LXBaseListHandyJSON<T: HandyJSON>: LXAnyModel, HandyJSON, LXBaseModelProtocol {
    public var code: Int?
    public var msg: String?
    public var errorTips: String?
    public var successTips: String?
    public var xl_origin_json: String?
    public var page: UInt?
    public var total_page: UInt?
    public var list: [T]?
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    required public init() {
        super.init()
    }

    /// override var debugDescription: String { return "" }
}

// MARK: - 👀
public extension HandyJSON {
    var debugDescription: String { return toJSONString(prettyPrint: true) ?? "---" }
}
