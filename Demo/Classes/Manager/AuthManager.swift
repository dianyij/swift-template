//
//  AuthManager.swift
//  Demo
//
//  Created by dianyi jiang on 27/08/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import Foundation
import KeychainAccess
import RxSwift

struct LoginResponse: Codable {
    let token: String
    let user: User
}

struct Token: Codable {
    var basicToken: String?
    var isValid = false

    init(basicToken: String, isValid: Bool) {
        self.basicToken = basicToken
        self.isValid = isValid
    }
}

class AuthManager {
    static let shared = AuthManager()

    fileprivate let tokenKey = "TokenKey"
    fileprivate let keychain = Keychain()
    let tokenChanged = PublishSubject<Token?>()

    var token: Token? {
        get {
            guard let jsonData = try? keychain.getData(tokenKey) else { return nil }
            return try? JSONDecoder().decode(Token.self, from: jsonData)
        }

        set {
            if let token = newValue, let data = try? JSONEncoder().encode(token) {
                try? keychain.set(data, key: tokenKey)
            } else {
                try? keychain.remove(tokenKey)
            }
            tokenChanged.onNext(newValue)
        }
    }

    var hasToken: Bool {
        if let basicToken = token?.basicToken, token?.isValid == true {
            return !basicToken.isEmpty
        }
        return false
    }

    class func setToken(token: Token) {
        AuthManager.shared.token = token
    }

    class func removeToken() {
        AuthManager.shared.token = nil
    }

    class func tokenValidated() {
        AuthManager.shared.token?.isValid = true
    }
}
