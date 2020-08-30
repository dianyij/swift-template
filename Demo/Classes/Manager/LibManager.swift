//
//  LibManager.swift
//  Demo
//
//  Created by dianyi jiang on 27/08/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SDWebImage
import SnapKit
import Rswift
import CocoaLumberjack

class LibsManager {
    static let shared = LibsManager()

    func setupLibs(with window: UIWindow? = nil) {
        let libsManager = LibsManager.shared
        libsManager.setupCocoaLumberjack()
        libsManager.setupKeyboardManager()
        libsManager.setupSDWebImage()
    }

    func setupCocoaLumberjack() {
//        DDLog.add(DDTTYLogger.sharedInstance) // TTY = Xcode console
//        DDLog.add(DDASLLogger.sharedInstance) // ASL = Apple System Logs
        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = TimeInterval(60 * 60 * 24) // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
    }

    func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
    }

    func setupSDWebImage() {
        SDWebImageDownloader.shared.config.downloadTimeout = 15
    }
}
