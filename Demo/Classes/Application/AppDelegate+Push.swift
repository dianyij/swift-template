//
//  AppDelegate+Push.swift
//  Demo
//
//  Created by dianyi jiang on 27/08/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import UIKit
import UserNotifications

// MARK: - register

extension AppDelegate {
    func registerRemotePushNotification() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound]) { granted, _ in
            DispatchQueue.main.sync {
                UIApplication.shared.registerForRemoteNotifications()
            }
            debugPrint(granted ? "success" : "failure")
        }
    }

    func getNotificationAuthorizationStatus() -> UNAuthorizationStatus {
        var status: UNAuthorizationStatus = .notDetermined
        let sema = DispatchSemaphore(value: 0)
        UNUserNotificationCenter.current().getNotificationSettings { setting in
            status = setting.authorizationStatus
            sema.signal()
        }
        _ = sema.wait(timeout: DispatchTime.now() + 0.5)
        return status
    }
}

// MARK: - UIApplicationDelegate

extension AppDelegate {
    func application(_: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken _: Data) {}

    func application(_: UIApplication, didFailToRegisterForRemoteNotificationsWithError _: Error) {}
}

// MARK: - UNUserNotificationCenterDelegate

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_: UNUserNotificationCenter, willPresent _: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }

    func userNotificationCenter(_: UNUserNotificationCenter, didReceive _: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
