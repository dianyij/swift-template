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
    case hello(param: String)
}

extension HomeApi: TargetType {
    var baseURL: URL {
        let url = URL(string: Konfigs.Network.baseURL)!
        return url
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
        return Konfigs.Network.headerContentTypeJSON
    }

    var parameters: [String: Any]? {
        var params: [String: Any] = [:]

        switch self {
        case let .hello(param):
            params["param"] = param
        }
        return params
    }

    var jsonEncoding: JSONEncoding {
        return JSONEncoding.default
    }

    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }

    var sampleData: Data {
        var dataUrl: URL?
        switch self {
        case .hello:
            if let file = Bundle.main.url(forResource: "SearchRepositoriesResponse", withExtension: "json") {
                dataUrl = file
            }
        }
        if let url = dataUrl, let data = try? Data(contentsOf: url) {
            return data
        }
        return Data()
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
