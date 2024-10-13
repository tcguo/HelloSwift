//
//  String+Extensions.swift
//  Binance
//
//  Created by Daniel Clelland on 1/11/18.
//  Copyright © 2018 Binance. All rights reserved.
//

extension String {
    public var isValidUppercaseLetter: Bool {
        matches(regex: "^[A-Z]$")
    }
}

extension String {
    public func isValidDecimal(digits: Int) -> Bool {
        guard isEmpty == false else {
            return true
        }

        guard matches(regex: "^([0-9]*)(\\\(Locale.current.decimalSeparator ?? ".")[0-9]{0,\(digits)})?$") else {
            return false
        }

        guard Decimal(string: self, locale: .current) != nil else {
            return false
        }

        return true
    }

    public func isValidMinusDecimal(digits: Int) -> Bool {
        guard isEmpty == false else {
            return true
        }

        guard matches(regex: "^-([0-9]*)(\\\(Locale.current.decimalSeparator ?? ".")[0-9]{0,\(digits)})?$") else {
            return false
        }

        guard Decimal(string: self, locale: .current) != nil else {
            return false
        }

        return true
    }

    public func isValidRealNumber(digits: Int) -> Bool {
        guard isEmpty == false else {
            return true
        }

        guard matches(regex: "^(-)?([0-9]*)(\\\(Locale.current.decimalSeparator ?? ".")[0-9]{0,\(digits)})?$") else {
            return false
        }

        guard Decimal(string: self, locale: .current) != nil else {
            return false
        }

        return true
    }

    public func isValidInputNumber(integerDigits: Int, digits: Int) -> Bool {
        guard isEmpty == false else {
            return true
        }
        guard matches(
            regex: "^([0-9]{0,\(integerDigits)})(\\\(Locale.current.decimalSeparator ?? ".")[0-9]{0,\(digits)})?$"
        )
        else {
            return false
        }

        guard Decimal(string: self, locale: .current) != nil else {
            return false
        }
        return true
    }
}

extension String {
    public var isPartiallyCompleteAuthenticationCode: Bool {
        matches(regex: "^[0-9]{0,6}$")
    }

    public var isValidAuthenticationCode: Bool {
        matches(regex: "^[0-9]{6}$")
    }
}

extension String {
    public var isValidFutureReferralID: Bool {
        matches(regex: "^[A-Za-z0-9]{0,16}$")
    }
}

extension String {
    public var maskedEmailAddress: String {
        let prefix = split(separator: "@").first?.prefix(2) ?? ""
        let suffix = split(separator: ".").last ?? ""
        return prefix + "***@***." + suffix
    }

    public var maskedPhone: String {
        var results = self
        if count > 3 {
            let start = 3
            let maxMaskLength = 4
            let startIndex = index(self.startIndex, offsetBy: start)
            let maskLength = min(count - start, maxMaskLength)
            let endIndex = index(startIndex, offsetBy: maskLength)
            var replaceString = ""
            for _ in 0..<maskLength { replaceString.append("*") }
            results.replaceSubrange(startIndex..<endIndex, with: replaceString)
        }
        return results
    }

    public var maskedFullPhone: String {
        let components = self.components(separatedBy: " ")
        guard components.count == 2 else {
            return self
        }
        return components[0] + components[1].maskedPhone
    }

    public var halfMaskedEmailAddress: String {
        let prefix = split(separator: "@").first?.prefix(2) ?? ""
        let suffix = split(separator: "@").last ?? ""
        return prefix + "***@" + suffix
    }

    public var maskedNickName: String {
        if count > 12 {
            let prefix = self.prefix(12)
            return prefix + "..."
        }
        return self
    }
}

extension String {
    public func matches(regex: String) -> Bool {
        range(of: regex, options: .regularExpression) != nil
    }
}

extension String {
    public func character(at offset: IndexDistance) -> Character? {
        guard offset < count else {
            return nil
        }

        return self[index(startIndex, offsetBy: offset)]
    }
}

extension String {
    public func removeWhitespace() -> String {
        components(separatedBy: .whitespacesAndNewlines).joined(separator: "")
    }
}

extension String {
    /// Decode number string from server.
    ///
    /// Number strings from server use "." as decimal separator, and has no grouping separator.
    ///
    /// **IMPORTANT:** Never call this property for number-formatted strings.
    public var decimalFromServer: Decimal {
        Decimal(string: self) ?? 0
    }

    /// Decode number string from input field (or string for input use).
    ///
    /// Number strings for input use has **localized** decimal separator.
    /// Using decimalFromServer will cause wrong conversion.
    ///
    /// **IMPORTANT:** Never call this property for strings from server.
    public func decimalFromInputUsedString(locale: Locale = .current) -> Decimal {
        Decimal(string: removeGroupSeparator(locale: locale), locale: locale) ?? 0
    }

    @available(*, deprecated, message: "Use decimalFromServer or decimalFromInputUsedString instead")
    public var decimal: Decimal {
        Decimal(string: removeGroupSeparator(), locale: .current) ?? 0
    }

    public func removeGroupSeparator(locale: Locale = .current) -> String {
        if let groupingSeparator = locale.groupingSeparator {
            return replacingOccurrences(of: groupingSeparator, with: "")
        }
        return self
    }

    public func replaceLocalDecimalSeparatorWithDot(locale: Locale = .current) -> String {
        if let decimalSeparator = locale.decimalSeparator {
            return replacingOccurrences(of: decimalSeparator, with: ".")
        }
        return self
    }
}

extension String {
    public var isUrlString: Bool {
        matches(regex: "\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?")
    }
}

extension String {
    public func findSubstringRange(subString: String) -> (Int, Int)? {
        guard let range = range(of: subString), !range.isEmpty else {
            return nil
        }
        return (distance(from: startIndex, to: range.lowerBound), subString.count)
    }
}

extension String {
    public static var empty: String {
        ""
    }
}

extension String {
    public func secure() -> String {
        if isEmpty {
            return ""
        }
        switch count {
        case 1:
            return "*"
        case 2:
            return prefix(1) + "*"
        case 3...5:
            return prefix(1) + "*" + suffix(1)
        default:
            return prefix(2) + "***" + suffix(3)
        }
    }
}

// MARK: - Version compare

extension String {
    public func ck_compare(with version: String) -> ComparisonResult {
        compare(version, options: .numeric, range: nil, locale: nil)
    }

    public func isNewer(than aVersionString: String) -> Bool {
        ck_compare(with: aVersionString) == .orderedDescending
    }

    public func isOlder(than aVersionString: String) -> Bool {
        ck_compare(with: aVersionString) == .orderedAscending
    }

    public func isSame(to aVersionString: String) -> Bool {
        ck_compare(with: aVersionString) == .orderedSame
    }
}

extension StringProtocol where Index == String.Index {
    public func nsRange(from range: Range<Index>) -> NSRange {
        NSRange(range, in: self)
    }

    public func nsRanges(
        of searchString: String,
        options mask: NSString.CompareOptions = [],
        locale: Locale? = nil
    ) -> [NSRange] {
        let ranges = self.ranges(of: searchString, options: mask, locale: locale)
        return ranges.map { nsRange(from: $0) }
    }

    public func ranges(
        of searchString: String,
        options mask: NSString.CompareOptions = [],
        locale: Locale? = nil
    ) -> [Range<String.Index>] {
        var ranges: [Range<String.Index>] = []
        while let range = range(
            of: searchString,
            options: mask,
            range: (ranges.last?.upperBound ?? startIndex)..<endIndex,
            locale: locale
        ) {
            ranges.append(range)
        }
        return ranges
    }
}

#if !os(watchOS)
extension String {
    public func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        // swiftformat:disable:next all
        return self.size(withAttributes: fontAttributes)
    }
}
#endif

extension String {
    public subscript<T>(range: T) -> String? where T: RangeExpression, T.Bound == Int {
        let range = range.relative(to: 0..<Int.max)
        guard let lowerIndex = index(startIndex, offsetBy: range.lowerBound, limitedBy: endIndex),
              let upperIndex = index(
                  startIndex,
                  offsetBy: range.upperBound,
                  limitedBy: endIndex
              ) else {
            return nil
        }
        return String(self[lowerIndex..<upperIndex])
    }
}

extension String {
    public var toIntOrZero: Int {
        Int(self) ?? 0
    }
}

extension String {
    public var firstCharacter: String {
        guard let firstChar = first else {
            return ""
        }
        return String(firstChar)
    }
}

extension String {
    public var double: Double? {
        Double(self)
    }
}
