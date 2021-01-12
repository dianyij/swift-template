//
//  UIFont+Exts.swift
//  Demo
//
//  Created by djiang on 11/12/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import UIKit

extension UIFont {
    // MARK: All Fonts
    static func allSystemFontsNames() -> [String] {
        var fontsNames = [String]()
        let fontFamilies = UIFont.familyNames
        for fontFamily in fontFamilies {
            let fontsForFamily = UIFont.fontNames(forFamilyName: fontFamily)
            for fontName in fontsForFamily {
                fontsNames.append(fontName)
            }
        }
        return fontsNames
    }
    
    // MARK: Randomizing Fonts
    static func randomFont(ofSize size: CGFloat) -> UIFont {
        let allFontsNames = UIFont.allSystemFontsNames()
        let randomFontIndex = Int.random(in: 0..<allFontsNames.count)
        let randomFontName = allFontsNames[randomFontIndex]
        return UIFont(name: randomFontName, size: size)!
    }
}
