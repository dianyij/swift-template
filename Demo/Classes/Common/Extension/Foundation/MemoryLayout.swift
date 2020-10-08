//
//  MemoryLayout.swift
//  Demo
//
//  Created by dianyi jiang on 30/08/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import Foundation

func sizeof <T> (_: T) -> Int {
    return (MemoryLayout<T>.size)
}

func sizeof <T> (_: T.Type) -> Int {
    return (MemoryLayout<T>.size)
}

func sizeof <T> (_ value: [T]) -> Int {
    return (MemoryLayout<T>.size * value.count)
}
