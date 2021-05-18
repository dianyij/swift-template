//
//  BlockTap.swift
//  Kamera
//
//  Created by dianyi jiang on 30/08/20.
//  Copyright © 2020 ORG. All rights reserved.
//

#if os(iOS) || os(tvOS)

    import UIKit

    /// Make sure you use  "[weak self] (gesture) in" if you are using the keyword self inside the closure or there might be a memory leak
    open class BlockTap: UITapGestureRecognizer {
        private var tapAction: ((UITapGestureRecognizer) -> Void)?

        override public init(target: Any?, action: Selector?) {
            super.init(target: target, action: action)
        }

        public convenience init(
            tapCount: Int = 1,
            fingerCount: Int = 1,
            action: ((UITapGestureRecognizer) -> Void)?
        ) {
            self.init()
            numberOfTapsRequired = tapCount

            #if os(iOS)

                numberOfTouchesRequired = fingerCount

            #endif

            tapAction = action
            addTarget(self, action: #selector(BlockTap.didTap(_:)))
        }

        @objc
        open func didTap(_ tap: UITapGestureRecognizer) {
            tapAction?(tap)
        }
    }

#endif
