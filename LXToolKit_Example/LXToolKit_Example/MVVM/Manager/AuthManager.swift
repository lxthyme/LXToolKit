//
//  AuthManager.swift
//  test
//
//  Created by lxthyme on 2023/3/23.
//
import UIKit
import KeychainAccess
import HandyJSON
import RxSwift
import RxCocoa

let loggedIn = BehaviorRelay<Bool>(value: false)
class AuthManager {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    fileprivate let tokenKey = "TokenKey"
    fileprivate let keychain = Keychain(service: AppConfig.App.bundleIdentifier)
    let tokenChanged = PublishSubject<Token?>()
    // MARK: 🛠Life Cycle
    static let shared = AuthManager()
    init() {
        loggedIn.accept(true)
    }
}

// MARK: 👀Public Actions
extension AuthManager {
    var token: Token? {
        get {
            guard let json = keychain[tokenKey] else { return nil }
            return Token.deserialize(from: json)
        }
        set {
            if let newValue, let json = token?.toJSONString() {
                keychain[tokenKey] = json
            } else {
                keychain[tokenKey] = nil
            }
            tokenChanged.onNext(newValue)
            loggedIn.accept(hasValidToken)
        }
    }
    var hasValidToken: Bool {
        return token?.isValid == true
    }

    class func removeToken() {
        AuthManager.shared.token = nil
    }
    class func tokenValidated() {
        AuthManager.shared.token?.isValid = true
    }
}

// MARK: 🔐Private Actions
private extension AuthManager {}
