//
//  Debug.swift
//  Demo
//
//  Created by djiang on 25/11/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

func xprint<T: CustomStringConvertible>(_ label: String = "-", _ event: Event<T>) {
#if DEBUG
    print(label, (event.element ?? event.error) ?? event)
#endif
}
