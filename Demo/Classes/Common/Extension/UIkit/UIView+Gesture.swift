//
//  UIView+Gesture.swift
//  Demo
//
//  Created by dianyi jiang on 30/08/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import Foundation
import UIKit

// MARK: Gesture Extensions
extension UIView {

    public func addTapGesture(tapNumber: Int = 1, action: ((UITapGestureRecognizer) -> Void)?) {
        let tap = BlockTap(tapCount: tapNumber, fingerCount: 1, action: action)
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }

    public func addLongPressGesture(action: ((UILongPressGestureRecognizer) -> Void)?) {
        let lp = BlockLongPress(action: action)
        addGestureRecognizer(lp)
        isUserInteractionEnabled = true
    }
    
}
