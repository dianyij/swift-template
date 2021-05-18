//
//  LogManager.swift
//  Demo
//
//  Created by dianyi jiang on 27/08/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import CocoaLumberjack
import Foundation

public func logDebug(_ message: @autoclosure () -> String) {
    DDLogDebug(message())
}

public func logError(_ message: @autoclosure () -> String) {
    DDLogError(message())
}

public func logInfo(_ message: @autoclosure () -> String) {
    DDLogInfo(message())
}

public func logVerbose(_ message: @autoclosure () -> String) {
    DDLogVerbose(message())
}

public func logWarn(_ message: @autoclosure () -> String) {
    DDLogWarn(message())
}
