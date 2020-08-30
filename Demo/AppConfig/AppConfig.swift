//
//  AppConfig.swift
//  Demo
//
//  Created by dianyi jiang on 2020-08-27.
//  Copyright © 2020 ORG. All rights reserved.
//

import UIKit

struct AppConfig {
    static let baseURL: String = Bundle.main["BASE_URL"]
    static let enableNetworkingLogging: Bool = Bundle.main["ENABLE_NETWORK_LOGGING"] == "YES"
}

extension Bundle {
    subscript<T>(key: String) -> T {
        guard let infoDic = Bundle.main.infoDictionary else {
            fatalError("Can't find info.plist!")
        }
        guard let value = infoDic[key] as? T else {
            fatalError("There is no value of '\(T.self)' type for \(key) in Info.plist, Please check if the type of \(key) is correct or \(key) exists")
        }

        return value
    }
}
