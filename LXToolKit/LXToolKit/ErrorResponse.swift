//
//  ErrorResponse.swift
//  test
//
//  Created by lxthyme on 2023/3/23.
//
import Foundation
import HandyJSON

public struct ErrorResponse: HandyJSON {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    public var message: String?
    public var errors: [ErrorModel] = []
    public var documentationUrl: String?
    // MARK: 🛠Life Cycle
    public init() {}

    mutating public func mapping(mapper: HelpingMapper) {
        mapper <<< self.documentationUrl <-- "documentation_url"
    }
    // func didFinishMapping() {
    //     super.didFinishMapping()
    // }
    public var debugDescription: String { return toJSONString(prettyPrint: true) ?? "---" }
}

extension ErrorResponse {
    public func detail() -> String {
        return errors
            .map { $0.message ?? "" }
            .joined(separator: "\n")
    }
}

public struct ErrorModel: HandyJSON {
    public var code: String?
    public var message: String?
    public var field: String?
    public var resource: String?
    public init() {}
}
