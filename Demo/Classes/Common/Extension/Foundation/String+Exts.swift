//
//  String+Exts.swift
//  Demo
//
//  Created by dianyi jiang on 30/08/20.
//  Copyright © 2020 ORG. All rights reserved.
//

import Foundation
import UIKit

extension String {
    init(_ value: Float, precision: Int) {
        let nFormatter = NumberFormatter()
        nFormatter.numberStyle = .decimal
        nFormatter.maximumFractionDigits = precision
        self = nFormatter.string(from: NSNumber(value: value))!
    }

    init(_ value: Double, precision: Int) {
        let nFormatter = NumberFormatter()
        nFormatter.numberStyle = .decimal
        nFormatter.maximumFractionDigits = precision
        self = nFormatter.string(from: NSNumber(value: value))!
    }
}

public extension String {
    /// Init string with a base64 encoded string
    internal init ? (base64: String) {
        let pad = String(repeating: "=", count: base64.length % 4)
        let base64Padded = base64 + pad
        if let decodedData = Data(base64Encoded: base64Padded, options: NSData.Base64DecodingOptions(rawValue: 0)), let decodedString = NSString(data: decodedData, encoding: String.Encoding.utf8.rawValue) {
            self.init(decodedString)
            return
        }
        return nil
    }

    /// base64 encoded of string
    internal var base64: String {
        let plainData = (self as NSString).data(using: String.Encoding.utf8.rawValue)
        let base64String = plainData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        return base64String
    }

    /// Cut string from integerIndex to the end
    subscript(integerIndex: Int) -> Character {
        let index = self.index(startIndex, offsetBy: integerIndex)
        return self[index]
    }

    /// Cut string from range
    subscript(integerRange: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: integerRange.lowerBound)
        let end = index(startIndex, offsetBy: integerRange.upperBound)
        return String(self[start ..< end])
    }

    /// Cut string from closedrange
    subscript(integerClosedRange: ClosedRange<Int>) -> String {
        return self[integerClosedRange.lowerBound ..< (integerClosedRange.upperBound + 1)]
    }
}

public extension String {
    /// Character count
    var length: Int {
        return count
    }

    /// Counts number of instances of the input inside String
    func count(_ substring: String) -> Int {
        return components(separatedBy: substring).count - 1
    }
}

public extension String {
    /// Trims white space and new line characters
    mutating func trim() {
        self = trimmed()
    }

    /// Trims white space and new line characters, returns a new string
    func trimmed() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// Capitalizes first character of String
    mutating func capitalizeFirst() {
        guard !isEmpty else { return }
        replaceSubrange(startIndex ... startIndex, with: String(self[startIndex]).capitalized)
    }

    /// Capitalizes first character of String, returns a new string
    func capitalizedFirst() -> String {
        guard !isEmpty else { return self }
        var result = self

        result.replaceSubrange(startIndex ... startIndex, with: String(self[startIndex]).capitalized)
        return result
    }

    /// Uppercases first 'count' characters of String
    mutating func uppercasePrefix(_ count: Int) {
        guard !isEmpty, count > 0 else { return }
        replaceSubrange(startIndex ..< index(startIndex, offsetBy: min(count, length)), with: String(self[startIndex ..< index(startIndex, offsetBy: min(count, length))]).uppercased())
    }

    /// Uppercases first 'count' characters of String, returns a new string
    func uppercasedPrefix(_ count: Int) -> String {
        guard !isEmpty, count > 0 else { return self }
        var result = self
        result.replaceSubrange(startIndex ..< index(startIndex, offsetBy: min(count, length)), with: String(self[startIndex ..< index(startIndex, offsetBy: min(count, length))]).uppercased())
        return result
    }

    /// Uppercases last 'count' characters of String
    mutating func uppercaseSuffix(_ count: Int) {
        guard !isEmpty, count > 0 else { return }
        replaceSubrange(index(endIndex, offsetBy: -min(count, length)) ..< endIndex, with: String(self[index(endIndex, offsetBy: -min(count, length)) ..< endIndex]).uppercased())
    }

    /// Uppercases last 'count' characters of String, returns a new string
    func uppercasedSuffix(_ count: Int) -> String {
        guard !isEmpty, count > 0 else { return self }
        var result = self
        result.replaceSubrange(index(endIndex, offsetBy: -min(count, length)) ..< endIndex, with: String(self[index(endIndex, offsetBy: -min(count, length)) ..< endIndex]).uppercased())
        return result
    }

    /// Uppercases string in range 'range' (from range.startIndex to range.endIndex)
    mutating func uppercase(range: CountableRange<Int>) {
        let from = max(range.lowerBound, 0), to = min(range.upperBound, length)
        guard !isEmpty, (0 ..< length).contains(from) else { return }
        replaceSubrange(index(startIndex, offsetBy: from) ..< index(startIndex, offsetBy: to), with: String(self[index(startIndex, offsetBy: from) ..< index(startIndex, offsetBy: to)]).uppercased())
    }

    /// Uppercases string in range 'range' (from range.startIndex to range.endIndex), returns new string
    func uppercased(range: CountableRange<Int>) -> String {
        let from = max(range.lowerBound, 0), to = min(range.upperBound, length)
        guard !isEmpty, (0 ..< length).contains(from) else { return self }
        var result = self
        result.replaceSubrange(index(startIndex, offsetBy: from) ..< index(startIndex, offsetBy: to), with: String(self[index(startIndex, offsetBy: from) ..< index(startIndex, offsetBy: to)]).uppercased())
        return result
    }

    /// Lowercases first character of String
    mutating func lowercaseFirst() {
        guard !isEmpty else { return }
        replaceSubrange(startIndex ... startIndex, with: String(self[startIndex]).lowercased())
    }

    /// Lowercases first character of String, returns a new string
    func lowercasedFirst() -> String {
        guard !isEmpty else { return self }
        var result = self
        result.replaceSubrange(startIndex ... startIndex, with: String(self[startIndex]).lowercased())
        return result
    }

    /// Lowercases first 'count' characters of String
    mutating func lowercasePrefix(_ count: Int) {
        guard !isEmpty, count > 0 else { return }
        replaceSubrange(startIndex ..< index(startIndex, offsetBy: min(count, length)), with: String(self[startIndex ..< index(startIndex, offsetBy: min(count, length))]).lowercased())
    }

    /// Lowercases first 'count' characters of String, returns a new string
    func lowercasedPrefix(_ count: Int) -> String {
        guard !isEmpty, count > 0 else { return self }
        var result = self
        result.replaceSubrange(startIndex ..< index(startIndex, offsetBy: min(count, length)), with: String(self[startIndex ..< index(startIndex, offsetBy: min(count, length))]).lowercased())
        return result
    }

    /// Lowercases last 'count' characters of String
    mutating func lowercaseSuffix(_ count: Int) {
        guard !isEmpty, count > 0 else { return }
        replaceSubrange(index(endIndex, offsetBy: -min(count, length)) ..< endIndex, with: String(self[index(endIndex, offsetBy: -min(count, length)) ..< endIndex]).lowercased())
    }

    /// Lowercases last 'count' characters of String, returns a new string
    func lowercasedSuffix(_ count: Int) -> String {
        guard !isEmpty, count > 0 else { return self }
        var result = self
        result.replaceSubrange(index(endIndex, offsetBy: -min(count, length)) ..< endIndex, with: String(self[index(endIndex, offsetBy: -min(count, length)) ..< endIndex]).lowercased())
        return result
    }

    /// Lowercases string in range 'range' (from range.startIndex to range.endIndex)
    mutating func lowercase(range: CountableRange<Int>) {
        let from = max(range.lowerBound, 0), to = min(range.upperBound, length)
        guard !isEmpty, (0 ..< length).contains(from) else { return }
        replaceSubrange(index(startIndex, offsetBy: from) ..< index(startIndex, offsetBy: to), with: String(self[index(startIndex, offsetBy: from) ..< index(startIndex, offsetBy: to)]).lowercased())
    }

    /// Lowercases string in range 'range' (from range.startIndex to range.endIndex), returns new string
    func lowercased(range: CountableRange<Int>) -> String {
        let from = max(range.lowerBound, 0), to = min(range.upperBound, length)
        guard !isEmpty, (0 ..< length).contains(from) else { return self }
        var result = self
        result.replaceSubrange(index(startIndex, offsetBy: from) ..< index(startIndex, offsetBy: to), with: String(self[index(startIndex, offsetBy: from) ..< index(startIndex, offsetBy: to)]).lowercased())
        return result
    }
}

public extension String {
    /// Checks if string is empty or consists only of whitespace and newline characters
    var isBlank: Bool {
        let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty
    }

    /// Checks if String contains Email
    var isEmail: Bool {
        let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let firstMatch = dataDetector?.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSRange(location: 0, length: length))
        return (firstMatch?.range.location != NSNotFound && firstMatch?.url?.scheme == "mailto")
    }

    /// Returns if String is a number
    func isNumber() -> Bool {
        return NumberFormatter().number(from: self) != nil ? true : false
    }

    /// Checking if String contains input with comparing options
    func contains(_ find: String, compareOption: NSString.CompareOptions) -> Bool {
        return range(of: find, options: compareOption) != nil
    }

    /// Checks if String contains Emoji
    func includesEmoji() -> Bool {
        for i in 0 ... length {
            let c: unichar = (self as NSString).character(at: i)
            if (c >= 0xD800 && c <= 0xDBFF) || (c >= 0xDC00 && c <= 0xDFFF) {
                return true
            }
        }
        return false
    }
}

public extension String {
    /// split string using a spearator string, returns an array of string
    func split(_ separator: String) -> [String] {
        return components(separatedBy: separator).filter {
            !$0.trimmed().isEmpty
        }
    }

    /// split string with delimiters, returns an array of string
    func split(_ characters: CharacterSet) -> [String] {
        return components(separatedBy: characters).filter {
            !$0.trimmed().isEmpty
        }
    }
}

public extension String {
    func extractNumber() -> Int? {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined().toInt()
    }

    /// Converts String to Int
    func toInt() -> Int? {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return nil
        }
    }

    /// Converts String to Double
    func toDouble() -> Double? {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }

    /// Converts String to Float
    func toFloat() -> Float? {
        if let num = NumberFormatter().number(from: self) {
            return num.floatValue
        } else {
            return nil
        }
    }

    /// Converts String to Bool
    func toBool() -> Bool? {
        let trimmedString = trimmed().lowercased()
        if trimmedString == "true" || trimmedString == "false" {
            return (trimmedString as NSString).boolValue
        }
        return nil
    }

    /// Converts String to NSString
    var toNSString: NSString { return self as NSString }
}

public extension String {
    /// Position of begining character of substing
    func positionOfSubstring(_ subString: String, caseInsensitive: Bool = false, fromEnd: Bool = false) -> Int {
        if subString.isEmpty {
            return -1
        }
        var searchOption = fromEnd ? NSString.CompareOptions.anchored : NSString.CompareOptions.backwards
        if caseInsensitive {
            searchOption.insert(NSString.CompareOptions.caseInsensitive)
        }
        if let range = self.range(of: subString, options: searchOption), !range.isEmpty {
            return distance(from: startIndex, to: range.lowerBound)
        }
        return -1
    }

    /// EZSE : Returns count of words in string
    var countofWords: Int {
        let regex = try? NSRegularExpression(pattern: "\\w+", options: NSRegularExpression.Options())
        return regex?.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions(), range: NSRange(location: 0, length: length)) ?? 0
    }

    /// EZSE : Returns count of paragraphs in string
    var countofParagraphs: Int {
        let regex = try? NSRegularExpression(pattern: "\\n", options: NSRegularExpression.Options())
        let str = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return (regex?.numberOfMatches(in: str, options: NSRegularExpression.MatchingOptions(), range: NSRange(location: 0, length: str.length)) ?? -1) + 1
    }

    internal func rangeFromNSRange(_ nsRange: NSRange) -> Range<String.Index>? {
        let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location)
        let to16 = utf16.index(from16, offsetBy: nsRange.length)
        if let from = String.Index(from16, within: self),
           let to = String.Index(to16, within: self) {
            return from ..< to
        }
        return nil
    }

    /// Find matches of regular expression in string
    func matchesForRegexInText(_ regex: String!) -> [String] {
        let regex = try? NSRegularExpression(pattern: regex, options: [])
        let results = regex?.matches(in: self, options: [], range: NSRange(location: 0, length: length)) ?? []
        return results.map { String(self[self.rangeFromNSRange($0.range)!]) }
    }

    /// Extracts URLS from String
    var extractURLs: [URL] {
        var urls: [URL] = []
        let detector: NSDataDetector?
        do {
            detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        } catch _ as NSError {
            detector = nil
        }

        let text = self

        if let detector = detector {
            detector.enumerateMatches(in: text,
                                      options: [],
                                      range: NSRange(location: 0, length: text.count),
                                      using: { (result: NSTextCheckingResult?, _, _) -> Void in
                                          if let result = result, let url = result.url {
                                              urls.append(url)
                                          }
                                      })
        }

        return urls
    }

    /// Returns the first index of the occurency of the character in String
    func getIndexOf(_ char: Character) -> Int? {
        for (index, c) in enumerated() where c == char {
            return index
        }
        return nil
    }

    #if os(iOS)

        /// copy string to pasteboard
        func addToPasteboard() {
            let pasteboard = UIPasteboard.general
            pasteboard.string = self
        }

    #endif
}

extension String {
    func htmlAttributedString(with fontName: String = "Futura", fontSize: Int = 15, colorHex: String = "ff0000") -> NSAttributedString? {
        do {
            let cssPrefix = "<style>* { font-family: \(fontName); color: #\(colorHex); font-size: \(fontSize); }</style>"
            let html = cssPrefix + self
            guard let data = html.data(using: String.Encoding.utf8) else { return nil }
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }

    // URL encode a string (percent encoding special chars)
    public func urlEncoded() -> String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    // URL encode a string (percent encoding special chars) mutating version
    mutating func urlEncode() {
        self = urlEncoded()
    }

    // Removes percent encoding from string
    public func urlDecoded() -> String {
        return removingPercentEncoding ?? self
    }

    // EZSE : Mutating versin of urlDecoded
    mutating func urlDecode() {
        self = urlDecoded()
    }
}

public extension String {
    #if os(iOS)

        /// Returns hight of rendered string
        func height(_ width: CGFloat, font: UIFont, lineBreakMode: NSLineBreakMode?) -> CGFloat {
            var attrib: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
            if lineBreakMode != nil {
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineBreakMode = lineBreakMode!
                attrib.updateValue(paragraphStyle, forKey: NSAttributedString.Key.paragraphStyle)
            }
            let size = CGSize(width: width, height: CGFloat(Double.greatestFiniteMagnitude))
            return ceil((self as NSString).boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attrib, context: nil).height)
        }

    #endif

    #if os(iOS)

        /// Returns underlined NSAttributedString
        func underline() -> NSAttributedString {
            let underlineString = NSAttributedString(string: self, attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
            return underlineString
        }

    #endif

    #if os(iOS)

        /// Returns italic NSAttributedString
        func italic() -> NSAttributedString {
            let italicString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
            return italicString
        }

    #endif

    #if os(iOS) || os(tvOS)

        /// Returns NSAttributedString
        func color(_ color: UIColor) -> NSAttributedString {
            let colorString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.foregroundColor: color])
            return colorString
        }

        /// Returns NSAttributedString
        func colorSubString(_ subString: String, color: UIColor) -> NSMutableAttributedString {
            var start = 0
            var ranges: [NSRange] = []
            while true {
                let range = (self as NSString).range(of: subString, options: NSString.CompareOptions.literal, range: NSRange(location: start, length: (self as NSString).length - start))
                if range.location == NSNotFound {
                    break
                } else {
                    ranges.append(range)
                    start = range.location + range.length
                }
            }
            let attrText = NSMutableAttributedString(string: self)
            for range in ranges {
                attrText.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
            }
            return attrText
        }

    #endif
}

/// Pattern matching of strings via defined functions
public func ~= <T>(pattern: (T) -> Bool, value: T) -> Bool {
    return pattern(value)
}

/// Can be used in switch-case
public func hasPrefix(_ prefix: String) -> (_ value: String) -> Bool {
    return { (value: String) -> Bool in
        value.hasPrefix(prefix)
    }
}

/// Can be used in switch-case
public func hasSuffix(_ suffix: String) -> (_ value: String) -> Bool {
    return { (value: String) -> Bool in
        value.hasSuffix(suffix)
    }
}
