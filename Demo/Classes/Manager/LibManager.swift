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
import CocoaLumberjack
import RxSwift
import RxCocoa
#if DEBUG
import FLEX
#endif
import NVActivityIndicatorView
import NSObject_Rx
import RxViewController
import RxOptional
import RxGesture
import SwifterSwift
import SwiftDate
import Hero
//import Firebase
//import FirebaseCrashlytics

class LibsManager: NSObject {
    
    static let shared = LibsManager()

    let bannersEnabled = BehaviorRelay(value: UserDefaults.standard.bool(forKey: Konfigs.UserDefaultsKeys.bannersEnabled))
//    bannerEnabled = BehaviorRelay(value: LibsManager.shared.bannersEnabled.value)

    private override init() {
        super.init()
        
        if UserDefaults.standard.object(forKey: Konfigs.UserDefaultsKeys.bannersEnabled) == nil {
            bannersEnabled.accept(true)
        }
        
        bannersEnabled.skip(1).subscribe(onNext: { (enabled) in
            UserDefaults.standard.set(enabled, forKey: Konfigs.UserDefaultsKeys.bannersEnabled)
//            analytics.set(.adsEnabled(value: enabled))
        }).disposed(by: rx.disposeBag)
    }

    func setupLibs(with window: UIWindow? = nil) {
        let libsManager = LibsManager.shared
        libsManager.setupCocoaLumberjack()
        libsManager.setupAnalytics()
        libsManager.setupAds()
        libsManager.setupKeyboardManager()
        libsManager.setupSDWebImage()
    }

    func setupCocoaLumberjack() {
        DDLog.add(DDOSLogger.sharedInstance)
        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = TimeInterval(60*60*24)  // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
    }

    func setupFLEX() {
        #if DEBUG
        FLEXManager.shared.isNetworkDebuggingEnabled = true
        #endif
    }
    
    func setupAnalytics() {
//        FirebaseApp.configure()
//        FirebaseConfiguration.shared.setLoggerLevel(.min)
    }
    
    func setupAds() {
//        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    
    func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
    }

    func setupSDWebImage() {
        SDWebImageDownloader.shared.config.downloadTimeout = 15
    }
}


extension LibsManager {
    func showFlex() {
        #if DEBUG
        FLEXManager.shared.showExplorer()
//        analytics.log(.flexOpened)
        #endif
    }
}
