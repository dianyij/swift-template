//
//  UIView+Exts.swift
//  Demo
//
//  Created by dianyi jiang on 30/08/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import UIKit

// MARK: - Blinkable
protocol Blinkable {
    func blink()
}

extension Blinkable where Self: UIView {
    func blink() {
        alpha = 1
        let duration = 0.5
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0
        }, completion: { (_) in
            UIView.animate(withDuration: duration) {
                self.alpha = 1
            }
        })
    }
}

// MARK: - Scalable
protocol Scalable {
    func scale()
}

extension Scalable where Self: UIView {
    func scale() {
        transform = .identity

        UIView.animate(
            withDuration: 0.5,
            delay: 0.25,
            options: [.repeat, .autoreverse],
            animations: {
                self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            })
    }
}

// MARK: - CornersRoundable
protocol CornersRoundable {
    func roundCorners()
}

extension CornersRoundable where Self: UIView {
    func roundCorners() {
        layer.cornerRadius = bounds.width * 0.1
        layer.masksToBounds = true
    }
}

extension UIView: Scalable, Blinkable, CornersRoundable { }
