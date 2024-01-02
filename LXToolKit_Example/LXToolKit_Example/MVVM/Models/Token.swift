//
//  Token.swift
//  test
//
//  Created by lxthyme on 2023/3/23.
//
import UIKit
// import HandyJSON

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

struct Token: HandyJSON {

    // MARK: 🔗Vaiables
    var isValid = false

    // Basic
    var basicToken: String?

    // Personal Access Token
    var personalToken: String?

    // OAuth2
    var accessToken: String?
    var tokenType: String?
    var scope: String?

    init() {}
    init(basicToken: String) {
        self.basicToken = basicToken
    }

    init(personalToken: String) {
        self.personalToken = personalToken
    }
}

// MARK: 👀Public Actions
extension Token {
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
}

// MARK: 🔐Private Actions
private extension Token {}
