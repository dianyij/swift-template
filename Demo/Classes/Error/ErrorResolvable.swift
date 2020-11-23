//
//  ErrorResolvable.swift
//  Demo
//
//  Created by djiang on 23/11/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import Foundation
import Moya

struct ErrorResponse: Codable {
    let detail: String
}

extension Swift.Error {
    func resolve() -> (String?, String?, TimeInterval?) {
        guard let moyaError = self as? MoyaError else {
            return ("Unknown", nil, nil)
        }
        let title: String?
        let subtitle: String?
        let timeInterval: TimeInterval = 2
        switch moyaError {
        case let .underlying(error, response?):
            title = error.localizedDescription
            subtitle = response.description
        case let .underlying(error, nil):
            title = error.localizedDescription
            subtitle = nil
        case let .statusCode(response):
            let errorResponse = try? response.map(ErrorResponse.self)
            title = errorResponse?.detail
            subtitle = nil
#if DEBUG
        case let .imageMapping(response):
            title = "can't convert \(response) to image"
            subtitle = response.description
        case let .jsonMapping(response):
            title = "can't convert \(response) to json"
            subtitle = response.description
        case let .stringMapping(response):
            title = "can't convert \(response) to string"
            subtitle = response.description
        case let .objectMapping(error, response):
            title = error.localizedDescription
            subtitle = response.description
        case let .encodableMapping(error):
            title = error.localizedDescription
            subtitle = nil
        case let .requestMapping(string):
            title = string
            subtitle = nil
        case let .parameterEncoding(error):
            title = error.localizedDescription
            subtitle = nil
#else
        default:
            title = nil
            subtitle = nil
#endif
        }
        return (title, subtitle, timeInterval)
    }
}
