//
//  UIImage+Bitmap.swift
//  Demo
//
//  Created by dianyi jiang on 30/08/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import CoreGraphics
import Foundation
import UIKit

protocol Kolor {
    associatedtype T

    var r: T { get set }
    var g: T { get set }
    var b: T { get set }
    var a: T { get set }
}

struct Kolor8: Kolor {
    var r, g, b: UInt8
    var a = UInt8.max
}

struct Kolor16: Kolor {
    var r, g, b: UInt16
    var a = UInt16.max
}

struct Kolor32: Kolor {
    var r, g, b: UInt32
    var a = UInt32.max
}

struct Bitmap<T: Kolor> {
    let width: Int
    var pixels: [T]
    var height: Int { pixels.count / width }

    subscript(x: Int, y: Int) -> T {
        get { pixels[y * width + x] }
        set { pixels[y * width + x] = newValue }
    }

    init(width: Int, height: Int, color: T) {
        self.width = width
        pixels = Array(repeating: color, count: width * height)
    }

    init(width: Int, height _: Int, colors: [T]) {
        self.width = width
        pixels = colors
    }
}

extension UIImage {
    convenience init?<T>(bitmap: Bitmap<T>) {
        let alphaInfo = CGImageAlphaInfo.premultipliedLast
        let bytesPerPixel = MemoryLayout<T>.stride
        let bytesPerRow = bitmap.width * bytesPerPixel

        guard let providerRef = CGDataProvider(data: Data(bytes: bitmap.pixels, count: bitmap.height * bytesPerRow) as CFData) else { return nil }

        guard let cgImage = CGImage(
            width: bitmap.width,
            height: bitmap.height,
            bitsPerComponent: 8,
            bitsPerPixel: bytesPerPixel * 8,
            bytesPerRow: bytesPerRow,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGBitmapInfo(rawValue: alphaInfo.rawValue),
            provider: providerRef,
            decode: nil,
            shouldInterpolate: true,
            intent: .defaultIntent
        ) else {
            return nil
        }

        self.init(cgImage: cgImage)
    }
}
