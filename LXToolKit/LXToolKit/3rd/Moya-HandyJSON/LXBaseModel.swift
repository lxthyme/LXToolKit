//
//  LXBaseModel.swift
//  Vaffle_demo
//
//  Created by LXThyme on 2019/1/10.
//  Copyright © 2019 DamonJow. All rights reserved.
//

import Foundation

public protocol LXAnyProtocol {}
public protocol LXBaseModelProtocol {
    // MARK: 🔗Vaiables
    var code: Int? { get set }
    var msg: String? { get set }
    // public var tips { get set }
    var errorTips: String? { get set }
    var successTips: String? { get set }
    var f_origin_json: String? { get set }
}

// MARK: - 👀
// public extension LXBaseModelProtocol {
//     var errorTips: String? { return nil }
//     var successTips: String? { return nil }
//     var f_origin_json: String? { return nil }
// }

public protocol LXBaseModelGenericProtocol: LXBaseModelProtocol {
    associatedtype T
    // MARK: 🔗Vaiables
    var data: T? { get set }
}
public protocol LXBaseListModelGenericProtocol: LXBaseModelProtocol {
    associatedtype T
    // MARK: 🔗Vaiables
    var page: Int? { get set }
    var totalPage: Int? { get set }
    var list: [T]? { get set }
}

open class LXAnyModel: NSObject {
    deinit {
        LogKit.traceLifeCycle(.model, typeName: xl.typeNameString, type: .deinit)
    }
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    required public override init() {}
}
