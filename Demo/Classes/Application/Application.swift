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
        authManager = AuthManager.shared

        _ = authManager.tokenChanged.subscribe(onNext: { [weak self] token in
            if let window = self?.window, token == nil || token?.isValid == true {
                self?.presentInitialScreen(in: window)
            }
        })
    }

    func presentInitialScreen(in window: UIWindow) {
        self.window = window

//        if let user = User.currentUser() {
//        }

        let loggedIn = authManager.hasToken

        var vc: UIViewController

        if !loggedIn {
            let viewModel = RootTabBarViewModel()
            vc = RootTabBarViewController(viewModel: viewModel)
        } else {
            let viewModel = LoginViewModel()
            vc = LoginViewController(viewModel: viewModel)
        }

        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            self.window.rootViewController = vc
        }, completion: nil)
    }

    func logout() {
        AuthManager.removeToken()
        let viewModel = LoginViewModel()
        let vc = LoginViewController(viewModel: viewModel)
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            self.window.rootViewController = vc
        }, completion: nil)
    }
}
