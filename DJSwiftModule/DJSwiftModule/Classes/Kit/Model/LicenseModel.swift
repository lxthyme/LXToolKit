//
//  LicenseModel.swift
//  test
//
//  Created by lxthyme on 2023/3/23.
//

import Foundation
import HandyJSON

struct LicenseModel: HandyJSON {
    var key: String?
    var name: String?
    var nodeId: String?
    var spdxId: AnyObject?
    var url: AnyObject?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< nodeId <-- "node_id"
        mapper <<< spdxId <-- "spdx_id"
    }
}
