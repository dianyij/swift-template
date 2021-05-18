//
//  ViewController+HUD.swift
//  Demo
//
//  Created by djiang on 23/11/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import Foundation
import MBProgressHUD

internal enum HUDAssociatedKeys {
    static var Loading = "HUDAssociatedKeys.Loading"
}

public protocol HUDDisplayable {}

extension UIViewController {
    var loadingHUD: MBProgressHUD? {
        get {
            return objc_getAssociatedObject(self, &HUDAssociatedKeys.Loading) as? MBProgressHUD
        }
        set {
            objc_setAssociatedObject(self, &HUDAssociatedKeys.Loading, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension UIViewController: HUDDisplayable {
    public func showLoading(title: String? = nil, subtitle: String? = nil) {
        let hud: MBProgressHUD

        if let loadingHUD = loadingHUD {
            hud = loadingHUD
            hud.label.text = title
            hud.detailsLabel.text = subtitle
            view.addSubview(hud)
            hud.show(animated: true)
        } else {
            hud = MBProgressHUD.showAdded(to: view, animated: true)
            hud.label.numberOfLines = 0
            hud.detailsLabel.numberOfLines = 0
            hud.label.text = title
            hud.detailsLabel.text = subtitle
            hud.animationType = .fade
            loadingHUD = hud
        }
    }

    public func hideLoading() {
        loadingHUD?.hide(animated: true)
    }

    public func showSuccess(title: String? = nil, subtitle: String? = nil, duration: TimeInterval = 1.5) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.numberOfLines = 0
        hud.detailsLabel.numberOfLines = 0
        hud.mode = .customView
        hud.label.text = title
        hud.detailsLabel.text = subtitle
        hud.customView = UIImageView(image: R.image.check())
        hud.animationType = .fade
        hud.hide(animated: true, afterDelay: duration)
    }

    public func showError(title: String? = nil, subtitle: String? = nil, duration: TimeInterval = 1.5) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.numberOfLines = 0
        hud.detailsLabel.numberOfLines = 0
        hud.mode = .customView
        hud.label.text = title
        hud.detailsLabel.text = subtitle
        hud.customView = UIImageView(image: R.image.error())
        hud.animationType = .fade
        hud.hide(animated: true, afterDelay: duration)
    }

    public func showInfo(title: String, subtitle: String? = nil, duration: TimeInterval = 1.5) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.numberOfLines = 0
        hud.detailsLabel.numberOfLines = 0
        hud.mode = .text
        hud.label.text = title
        hud.detailsLabel.text = subtitle
        hud.animationType = .fade
        hud.minShowTime = 1
        hud.minSize = CGSize(width: 50, height: 50)
        hud.hide(animated: true, afterDelay: duration)
    }
}
