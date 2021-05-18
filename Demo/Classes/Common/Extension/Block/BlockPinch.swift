//
//  BlockPinch.swift
//  Kamera
//
//  Created by dianyi jiang on 30/08/20.
//  Copyright © 2020 ORG. All rights reserved.
//

#if os(iOS)

    import UIKit

    /// Make sure you use  "[weak self] (gesture) in" if you are using the keyword self inside the closure or there might be a memory leak
    open class BlockPinch: UIPinchGestureRecognizer {
        private var pinchAction: ((UIPinchGestureRecognizer) -> Void)?

        override public init(target: Any?, action: Selector?) {
            super.init(target: target, action: action)
        }

        public convenience init(action: ((UIPinchGestureRecognizer) -> Void)?) {
            self.init()
            pinchAction = action
            addTarget(self, action: #selector(BlockPinch.didPinch(_:)))
        }

        @objc
        open func didPinch(_ pinch: UIPinchGestureRecognizer) {
            pinchAction?(pinch)
        }
    }

#endif
