//
//  AccountApi.swift
//  Demo
//
//  Created by dianyi jiang on 28/08/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import Foundation
import Moya

enum Account {
    case login(param: [String: String])
    case userInfo(id: Int)
    case hello
}

extension Account: TargetType {
    var baseURL: URL {
        return NetworkingConstant.baseURL
    }

    var path: String {
        switch self {
        case .login:
            return "/api/auth/tokens/"
        case .userInfo(let id):
            return "/api/user/\(id)"
        case .hello:
            return "/Categories/0.json"
        }
    }

    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .userInfo:
            return .get
        default:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .login(let param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }

    var validationType: ValidationType {
        return .successAndRedirectCodes
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    // data for testing
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
}

extension Account: AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
        switch self {
        case .login, .hello:
            return .none
        default:
            return .custom("Token")
        }
    }
}
