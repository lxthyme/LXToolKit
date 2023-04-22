//
//  ErrorResponse.swift
//  test
//
//  Created by lxthyme on 2023/3/23.
//
import Foundation

struct ErrorResponse: HandyJSON {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    var message: String?
    var errors: [ErrorModel] = []
    var documentationUrl: String?
    // MARK: 🛠Life Cycle

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.documentationUrl <-- "documentation_url"
    }
    // func didFinishMapping() {
    //     super.didFinishMapping()
    // }
    var debugDescription: String { return toJSONString(prettyPrint: true) ?? "---" }
}

extension ErrorResponse {
    func detail() -> String {
        return errors
            .map { $0.message ?? "" }
            .joined(separator: "\n")
    }
}

struct ErrorModel: HandyJSON {
    var code: String?
    var message: String?
    var field: String?
    var resource: String?
}
