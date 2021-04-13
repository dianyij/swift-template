//
//  Konfigs.swift
//  Demo
//
//  Created by dianyi jiang on 2020-08-27.
//  Copyright © 2020 ORG. All rights reserved.
//

import UIKit

struct Konfigs {

    struct App {
        static let baseURL: String = Bundle.main["BASE_URL"]
        static let bundleIdentifier = "com.public.DEMO"
    }
    
    struct Network {
        static let baseURL: String = Bundle.main["BASE_URL"]
        static let enableNetworkingLogging: Bool = Bundle.main["ENABLE_NETWORK_LOGGING"] == "YES"
        static let useStaging = false  // set true for tests and generating screenshots with fastlane
        static let loggingEnabled = false
        static let headerContentTypeJSON = ["Content-Type": "application/json"]
    }
    
    struct BaseDimensions {
        static let inset: CGFloat = 8
        static let tabBarHeight: CGFloat = 58
        static let toolBarHeight: CGFloat = 66
        static let navBarWithStatusBarHeight: CGFloat = 64
        static let cornerRadius: CGFloat = 5
        static let borderWidth: CGFloat = 1
        static let buttonHeight: CGFloat = 40
        static let textFieldHeight: CGFloat = 40
        static let tableRowHeight: CGFloat = 36
        static let segmentedControlHeight: CGFloat = 40
    }
    
    struct Path {
        static let Documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        static let Tmp = NSTemporaryDirectory()
    }
    
    struct UserDefaultsKeys {
        static let bannersEnabled = "BannersEnabled"
    }
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
