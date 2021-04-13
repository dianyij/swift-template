//
//  NetworkError.swift
//  Demo
//
//  Created by djiang on 12/04/21.
//  Copyright © 2021 ORG. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    case parseResponseDataFalse(title: String)
    case requestError(title: String, message: String)
    
    public var description: String {
        switch self {
        case .parseResponseDataFalse:
            return "Parse response data false"
        case .requestError(_, let message):
            return message
        }
    }
    
    public var title: String {
        switch self {
        case .parseResponseDataFalse(let title):
            return title
        case .requestError(let title, _):
            return title
        }
    }
}
