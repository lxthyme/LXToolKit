//
//  ErrorResponse.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/24.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import ObjectMapper
import Moya
struct ErrorResponse: Mappable {
    var message: String?
    var errors: [ErrorModel] = []
    var documentationUrl: String?
    var response: Moya.Response?

    init?(map: Map) {}
    init(response: Moya.Response?) {
        self.response = response
    }

    mutating func mapping(map: Map) {
        message <- map["message"]
        errors <- map["errors"]
        documentationUrl <- map["documentation_url"]
    }

    func detail() -> String {
        return errors.map { $0.message ?? "" }
            .joined(separator: "\n")
    }
}

struct ErrorModel: Mappable {
    var code: String?
    var message: String?
    var field: String?
    var resource: String?

    init?(map: Map) {}
    init() {}

    mutating func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
        field <- map["field"]
        resource <- map["resource"]
    }
}
