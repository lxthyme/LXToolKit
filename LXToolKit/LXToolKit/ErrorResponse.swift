//
//  ErrorResponse.swift
//  test
//
//  Created by lxthyme on 2023/3/23.
//
import Foundation
import ObjectMapper

public struct ErrorResponse: Codable {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    public var message: String?
    public var errors: [ErrorModel] = []
    public var documentationUrl: String?
    // MARK: 🛠Life Cycle
    public init() {}

    init?(map: ObjectMapper.Map) {}
    mutating func mapping(map: Map) {
        documentationUrl <- map["documentation_url"]
    }
    // func didFinishMapping() {
    //     super.didFinishMapping()
    // }
    // public var debugDescription: String { return toJSONString(prettyPrint: true) ?? "---" }
}

extension ErrorResponse {
    public func detail() -> String {
        return errors
            .map { $0.message ?? "" }
            .joined(separator: "\n")
    }
}

public struct ErrorModel: Codable {
    public var code: String?
    public var message: String?
    public var field: String?
    public var resource: String?
    // public init() {}
}
