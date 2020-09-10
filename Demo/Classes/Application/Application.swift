//
//  Application.swift
//  Demo
//
//  Created by dianyi jiang on 2020-08-27.
//  Copyright © 2020 ORG. All rights reserved.
//

import UIKit

final class Application {
    static let shared = Application()

    var window: UIWindow!

    let authManager: AuthManager

    init() {
        self.authManager = AuthManager.shared
    }

    func presentInitialScreen(in window: UIWindow) {
        self.window = window

//        if let user = User.currentUser() {
//        }

        let loggedIn = authManager.hasToken

        var vc: UIViewController
        if loggedIn {
            vc = HomeViewController()
        } else {
            vc = HomeViewController()
        }

        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            self.window.rootViewController = vc
        }, completion: nil)
    }

    func logout() {
        AuthManager.removeToken()
//        let vc = LoginViewController()
//        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
//            self.window.rootViewController = vc
//        }, completion: nil)
    }
}
