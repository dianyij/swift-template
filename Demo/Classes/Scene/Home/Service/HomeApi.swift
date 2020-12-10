//
//  HomeApi.swift
//  Demo
//
//  Created by djiang on 1/12/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import Foundation
import Moya

enum HomeApi {
    case hello
}

extension HomeApi: TargetType {
    var baseURL: URL {
        return NetworkingConstant.baseURL
    }

    var path: String {
        switch self {
        case .hello:
            return "/Categories/0.json"
        }
    }

    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }

    var task: Task {
        switch self {
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

extension HomeApi: AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
        switch self {
        default:
            return .none
        }
    }
}
