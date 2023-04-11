//
//  ErrorResponse.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/24.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Moya
import HandyJSON

struct ErrorResponse: HandyJSON {
    var message: String?
    var errors: [ErrorModel] = []
    var documentationUrl: String?
    var response: Moya.Response?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< documentationUrl <-- "documentation_url"
    }

    func detail() -> String {
        return errors.map { $0.message ?? "" }
            .joined(separator: "\n")
    }
}

struct ErrorModel: HandyJSON {
    var code: String?
    var message: String?
    var field: String?
    var resource: String?
}
