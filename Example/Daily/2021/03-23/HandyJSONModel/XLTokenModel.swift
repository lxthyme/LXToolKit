//
//  XLTokenModel.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/3/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//
import Foundation
import HandyJSON

enum TokenType {
    case basic(token: String)
    case personal(token: String)
    case oAuth(token: String)
    case unauthorized

    var description: String {
        switch self {
        case .basic: return "basic"
        case .personal: return "personal"
        case .oAuth: return "OAuth"
        case .unauthorized: return "unauthorized"
        }
    }
}

class XLTokenModel: NSObject, HandyJSON {
    var isValid = false

    // Basic
    var basicToken: String?

    // Personal Access Token
    var personalToken: String?

    // OAuth2
    var accessToken: String?
    var tokenType: String?
    var scope: String?
    required override init() {}
    init(basicToken: String) {
        self.basicToken = basicToken
    }

    init(personalToken: String) {
        self.personalToken = personalToken
    }
    func type() -> TokenType {
        if let token = basicToken {
            return .basic(token: token)
        }
        if let token = personalToken {
            return .personal(token: token)
        }
        if let token = accessToken {
            return .oAuth(token: token)
        }
        return .unauthorized
    }
    // func mapping(mapper: HelpingMapper) {
    //     super.mapping(mapper: mapper)
    // }
    // override func didFinishMapping() {
    //     super.didFinishMapping()
    // }
    override var debugDescription: String { return toJSONString(prettyPrint: true) ?? "---" }
}
