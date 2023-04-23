//
//  LXBaseModel.swift
//  test
//
//  Created by lxthyme on 2023/3/23.
//

import Foundation
import HandyJSON

struct LXBaseModel: HandyJSON {

    // func mapping(mapper: HelpingMapper) {
    //     super.mapping(mapper: mapper)
    // }
    // override func didFinishMapping() {
    //     super.didFinishMapping()
    // }
    var debugDescription: String { return toJSONString(prettyPrint: true) ?? "---" }
}

