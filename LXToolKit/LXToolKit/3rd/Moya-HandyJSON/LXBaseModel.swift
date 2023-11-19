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
    var xl_origin_json: String? { get set }
}

public protocol LXBaseModelGenericProtocol: LXBaseModelProtocol {
    associatedtype T
    // MARK: 🔗Vaiables
    var data: T? { get set }
}
public protocol LXBaseListGenericProtocol {
    associatedtype T
    // MARK: 🔗Vaiables
    var page: Int { get set }
    var totalPage: Int { get set }
    var list: [T] { get set }
}

