//
//  LXBaseModel.swift
//  Vaffle_demo
//
//  Created by LXThyme on 2019/1/10.
//  Copyright © 2019 DamonJow. All rights reserved.
//

import Foundation
import HandyJSON

public protocol LXBaseModelProtocol {
    // MARK: 🔗Vaiables
    var code: Int? { get set }
    // public var msg { get set }
    // public var tips { get set }
    var errorTips: String? { get set }
    var successTips: String? { get set }
    var xl_origin_json: String? { get set }
}

public protocol LXBaseModelGenericProtocol: LXBaseModelProtocol {
    associatedtype T
    // MARK: 🔗Vaiables
    var data: T? { get set }
}
public protocol LXBaseListGenericModelProtocol {
    associatedtype T
    // MARK: 🔗Vaiables
    var page: Int { get set }
    var totalPage: Int { get set }
    var list: [T] { get set }
}

open class LXAnyModel: NSObject, HandyJSON {
    deinit {
        dlog("---------- >>>Model: \(self.xl.xl_typeName)\t\tdeinit <<<----------")
    }
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    required public override init() {}
    open override var debugDescription: String {
        return toJSONString(prettyPrint: true) ?? "NaN"
    }
    // func mapping(mapper: HelpingMapper) {
    //     super.mapping(mapper: mapper)
    // }
    // override func didFinishMapping() {
    //     super.didFinishMapping()
    // }
}
// open class LXBaseModel: LXAnyModel, LXBaseModelProtocol {
//     // MARK: 🔗Vaiables
//     public var code: Int?
//     public var errorTips: String?
//     public var successTips: String?
//     public var xl_origin_json: String?
//     // MARK: 🛠Life Cycle
//     required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
//     required public init() {
//         super.init()
//     }
//
//     public func mapping(mapper: HelpingMapper) {
//         mapper >>> self.xl_origin_json
//     }
//
//     /// override var debugDescription: String { return "" }
// }
open class LXBaseGenericModel<T: HandyJSON>: LXAnyModel, LXBaseModelProtocol {
    // MARK: 🔗Vaiables
    public var code: Int?
    public var errorTips: String?
    public var successTips: String?
    public var xl_origin_json: String?
    public var data: T?
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    required public init() {
        super.init()
    }

    public func mapping(mapper: HelpingMapper) {
        mapper >>> self.xl_origin_json
    }

    // override var debugDescription: String { return "" }
}

open class LXBaseListModel<T: HandyJSON>: LXAnyModel {
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
