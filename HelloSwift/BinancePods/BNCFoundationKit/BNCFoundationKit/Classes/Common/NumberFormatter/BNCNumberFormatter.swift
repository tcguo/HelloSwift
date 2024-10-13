//
//  BNCNumberFormatter.swift
//  BNCFoundationKit
//
//  Created by Derek Tseng on 2021/3/11.
//

import Foundation

// Documentation
// https://docs.devfdg.net/docs/ios/frameworks/BNCFoundationKit/number_formatter/BNCNumberFormatter
public class BNCNumberFormatter {
    // If you cannot find any formatter matches your requirement,
    // add a new type of formatter. Don't add parameters to existing types.
    public enum FormatterType: Hashable {
        case decimal(
            minimumFractionDigits: Int = 0,
            maximumFractionDigits: Int,
            rounding: NumberFormatter.RoundingMode = .down,
            usesGroupingSeparator: Bool = true
        )
        case fixedDigitsDecimal(
            digits: Int,
            rounding: NumberFormatter.RoundingMode = .down,
            usesGroupingSeparator: Bool = true
        )
        case percent(digits: Int = 2, sign: Bool = true, rounding: NumberFormatter.RoundingMode = .halfEven)
        case percentDynamicDigits(
            minimumFractionDigits: Int = 0,
            maximumFractionDigits: Int,
            sign: Bool = true,
            rounding: NumberFormatter.RoundingMode = .halfEven
        )
        case currency(
            digits: Int = 2,
            currencySymbol: String = "$",
            sign: Bool = false,
            rounding: NumberFormatter.RoundingMode = .down
        )
        case field(
            minimumFractionDigits: Int = 0,
            maximumFractionDigits: Int,
            rounding: NumberFormatter.RoundingMode = .halfEven
        )
        case multiplierDecimal(digits: Int = 2, unit: String = "")
        case multiplierDynamicDigits(
            minimumFractionDigits: Int = 0,
            maximumFractionDigits: Int,
            unit: String = "",
            rounding: NumberFormatter.RoundingMode = .halfUp,
            usesGroupingSeparator: Bool = true
        )
        case multiplierDynamicLocalizationOfDigits(
            minimumFractionDigits: Int = 0,
            maximumFractionDigits: Int,
            unit: String = "",
            rounding: NumberFormatter.RoundingMode = .halfUp,
            usesGroupingSeparator: Bool = true
        )
        case unformattedDecimal(
            minimumFractionDigits: Int = 0,
            maximumFractionDigits: Int,
            rounding: NumberFormatter.RoundingMode = .down
        )
        case fixedDigitsUnformattedDecimal(digits: Int)
    }

    private lazy var decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumIntegerDigits = 1
        return formatter
    }()

    private lazy var percentFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumIntegerDigits = 1
        return formatter
    }()

    private lazy var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumIntegerDigits = 1
        return formatter
    }()

    private lazy var fieldFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumIntegerDigits = 1
        formatter.usesGroupingSeparator = false
        return formatter
    }()

    private lazy var multiplierDecimalFormatter: MetricPrefixNumberFormatter = {
        let formatter = MetricPrefixNumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumIntegerDigits = 1
        formatter.allowsFloats = true
        formatter.roundingMode = .halfUp
        return formatter
    }()

    private lazy var unformattedDecimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.minimumIntegerDigits = 1
        return formatter
    }()

    private lazy var multiplierDynamicFormatter: MetricPrefixNumberFormatter = {
        let formatter = MetricPrefixNumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumIntegerDigits = 1
        formatter.allowsFloats = true
        formatter.roundingMode = .halfUp
        formatter.minimumMagnitude = 3
        formatter.delimiter = ""
        formatter.localizationDictionary = MetricPrefix.DefaultPrefixes
        return formatter
    }()

    private lazy var multiplierDynamicLocalizationFormatter: MetricPrefixNumberFormatter = {
        let formatter = MetricPrefixNumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumIntegerDigits = 1
        formatter.allowsFloats = true
        formatter.roundingMode = .halfUp
        formatter.minimumMagnitude = 3
        formatter.delimiter = ""
        formatter.localizationDictionary = MetricPrefix.DefaultPrefixes
        return formatter
    }()

    private let decimalFormatterQueue = DispatchQueue(label: "com.binance.decimalFormatterQueue")

    private let percentFormatterQueue = DispatchQueue(label: "com.binance.percentFormatterQueue")

    private let currencyFormatterQueue = DispatchQueue(label: "com.binance.currencyFormatterQueue")

    private let fieldFormatterQueue = DispatchQueue(label: "com.binance.fieldFormatterQueue")

    private let multiplierDecimalFormatterQueue = DispatchQueue(label: "com.binance.multiplierDecimalFormatterQueue")

    private let multiplierDynamicFormatterQueue = DispatchQueue(label: "com.binance.multiplierDynamicFormatterQueue")

    private let multiplierDynamicLocalizationFormatterQueue = DispatchQueue(label: "com.binance.multiplierDynamicLocalizationFormatterQueue")

    private let unformattedDecimalFormatterQueue = DispatchQueue(label: "com.binance.unformattedDecimalFormatterQueue")

    public static let shared = BNCNumberFormatter()

    public func setLanguage(_ language: String) {
        multiplierDecimalFormatterQueue.sync {
            let setting = MetricPrefixSetting(rawValue: language) ?? .en
            multiplierDecimalFormatter.localizationDictionary = setting.prefixes
            multiplierDecimalFormatter.delimiter = setting.delimiter
        }

        multiplierDynamicLocalizationFormatterQueue.sync {
            let setting = MetricPrefixSetting(rawValue: language) ?? .en
            multiplierDynamicLocalizationFormatter.localizationDictionary = setting.prefixes
            multiplierDynamicLocalizationFormatter.delimiter = setting.delimiter
        }
    }

    public func formatNumber<Value: BNCNumberFormattable>(_ value: Value, type: FormatterType) -> String {
        switch type {
        case let .decimal(minimumFractionDigits, maximumFractionDigits, rounding, usesGroupingSeparator):
            return decimalFormatterQueue.sync {
                decimalFormatter.minimumFractionDigits = minimumFractionDigits
                decimalFormatter.maximumFractionDigits = maximumFractionDigits
                decimalFormatter.roundingMode = rounding
                decimalFormatter.usesGroupingSeparator = usesGroupingSeparator
                return decimalFormatter.string(from: value)
            }
        case let .fixedDigitsDecimal(digits, rounding, usesGroupingSeparator):
            return formatNumber(
                value,
                type: .decimal(
                    minimumFractionDigits: digits,
                    maximumFractionDigits: digits,
                    rounding: rounding,
                    usesGroupingSeparator: usesGroupingSeparator
                )
            )
        case let .percent(digits, sign, rounding):
            return formatNumber(
                value,
                type: .percentDynamicDigits(
                    minimumFractionDigits: digits,
                    maximumFractionDigits: digits,
                    sign: sign,
                    rounding: rounding
                )
            )
        case let .percentDynamicDigits(minimumFractionDigits, maximumFractionDigits, sign, rounding):
            return percentFormatterQueue.sync {
                percentFormatter.minimumFractionDigits = minimumFractionDigits
                percentFormatter.maximumFractionDigits = maximumFractionDigits
                percentFormatter.roundingMode = rounding

                guard let number = value as? NSNumber else {
                    return ""
                }

                if sign && number.doubleValue >= 0 {
                    return "+\(percentFormatter.string(from: value))"
                } else {
                    return percentFormatter.string(from: value)
                }
            }
        case let .currency(digits, currencySymbol, sign, rounding):
            return currencyFormatterQueue.sync {
                currencyFormatter.minimumFractionDigits = digits
                currencyFormatter.maximumFractionDigits = digits
                currencyFormatter.currencySymbol = currencySymbol
                currencyFormatter.roundingMode = rounding

                guard let number = value as? NSNumber else {
                    return ""
                }

                if sign && number.doubleValue >= 0 {
                    return "+\(currencyFormatter.string(from: value))"
                } else {
                    return currencyFormatter.string(from: value)
                }
            }
        case let .field(minimumFractionDigits, maximumFractionDigits, roundingMode):
            return fieldFormatterQueue.sync {
                fieldFormatter.minimumFractionDigits = minimumFractionDigits
                fieldFormatter.maximumFractionDigits = maximumFractionDigits
                fieldFormatter.roundingMode = roundingMode
                return fieldFormatter.string(from: value)
            }
        case let .multiplierDecimal(digits, unit):
            return multiplierDecimalFormatterQueue.sync {
                multiplierDecimalFormatter.minimumFractionDigits = digits
                multiplierDecimalFormatter.maximumFractionDigits = digits
                multiplierDecimalFormatter.unit = unit

                guard let value = value as? NSNumber else {
                    return ""
                }

                return multiplierDecimalFormatter.string(from: value) ?? ""
            }
        case let .unformattedDecimal(minimumFractionDigits, maximumFractionDigits, roundingMode):
            return unformattedDecimalFormatterQueue.sync {
                unformattedDecimalFormatter.minimumFractionDigits = minimumFractionDigits
                unformattedDecimalFormatter.maximumFractionDigits = maximumFractionDigits
                unformattedDecimalFormatter.roundingMode = roundingMode
                return unformattedDecimalFormatter.string(from: value)
            }
        case let .fixedDigitsUnformattedDecimal(digits):
            return formatNumber(
                value,
                type: .unformattedDecimal(minimumFractionDigits: digits, maximumFractionDigits: digits)
            )
        case let .multiplierDynamicDigits(
            minimumFractionDigits,
            maximumFractionDigits,
            unit,
            rounding,
            usesGroupingSeparator
        ):
            return multiplierDynamicFormatterQueue.sync {
                multiplierDynamicFormatter.minimumFractionDigits = minimumFractionDigits
                multiplierDynamicFormatter.maximumFractionDigits = maximumFractionDigits
                multiplierDynamicFormatter.roundingMode = rounding
                multiplierDynamicFormatter.unit = unit
                multiplierDynamicFormatter.usesGroupingSeparator = usesGroupingSeparator

                guard let value = value as? NSNumber else {
                    return ""
                }

                return multiplierDynamicFormatter.string(from: value) ?? ""
            }
        case let .multiplierDynamicLocalizationOfDigits(
            minimumFractionDigits,
            maximumFractionDigits,
            unit,
            rounding,
            usesGroupingSeparator
        ):
            return multiplierDynamicLocalizationFormatterQueue.sync {
                multiplierDynamicLocalizationFormatter.minimumFractionDigits = minimumFractionDigits
                multiplierDynamicLocalizationFormatter.maximumFractionDigits = maximumFractionDigits
                multiplierDynamicLocalizationFormatter.roundingMode = rounding
                multiplierDynamicLocalizationFormatter.unit = unit
                multiplierDynamicLocalizationFormatter.usesGroupingSeparator = usesGroupingSeparator

                guard let value = value as? NSNumber else {
                    return ""
                }

                return multiplierDynamicLocalizationFormatter.string(from: value) ?? ""
            }
        }
    }
}

extension BNCNumberFormatter {
    /// For unit test only (not thread safe)
    func setLocale(locale: Locale) {
        decimalFormatter.locale = locale
        percentFormatter.locale = locale
        currencyFormatter.locale = locale
        fieldFormatter.locale = locale
        multiplierDecimalFormatter.locale = locale
        unformattedDecimalFormatter.locale = locale
        multiplierDynamicFormatter.locale = locale
    }
}

extension BNCNumberFormatter {
    // IMPORTANT: Default values should keep aligned with those in enum definition
    public static func decimalString<Value: BNCNumberFormattable>(
        _ value: Value,
        minimumFractionDigits: Int = 0,
        maximumFractionDigits: Int,
        rounding: NumberFormatter.RoundingMode = .down,
        usesGroupingSeparator: Bool = true
    ) -> String {
        Self.shared.formatNumber(
            value,
            type: .decimal(
                minimumFractionDigits: minimumFractionDigits,
                maximumFractionDigits: maximumFractionDigits,
                rounding: rounding,
                usesGroupingSeparator: usesGroupingSeparator
            )
        )
    }

    public static func fixedDigitsDecimalString<Value: BNCNumberFormattable>(
        _ value: Value,
        digits: Int,
        rounding: NumberFormatter.RoundingMode = .down,
        usesGroupingSeparator: Bool = true
    ) -> String {
        Self.shared.formatNumber(
            value,
            type: .fixedDigitsDecimal(
                digits: digits,
                rounding: rounding,
                usesGroupingSeparator: usesGroupingSeparator
            )
        )
    }

    public static func percentString<Value: BNCNumberFormattable>(
        _ value: Value,
        digits: Int = 2,
        sign: Bool = true,
        rounding: NumberFormatter.RoundingMode = .halfEven
    ) -> String {
        Self.shared.formatNumber(value, type: .percent(digits: digits, sign: sign, rounding: rounding))
    }

    public static func percentDynamicDigitsString<Value: BNCNumberFormattable>(
        _ value: Value,
        minimumFractionDigits: Int = 0,
        maximumFractionDigits: Int,
        sign: Bool = true,
        rounding: NumberFormatter.RoundingMode = .halfEven
    ) -> String {
        Self.shared.formatNumber(
            value,
            type: .percentDynamicDigits(
                minimumFractionDigits: minimumFractionDigits,
                maximumFractionDigits: maximumFractionDigits,
                sign: sign,
                rounding: rounding
            )
        )
    }

    public static func currencyString<Value: BNCNumberFormattable>(
        _ value: Value,
        digits: Int = 2,
        currencySymbol: String = "$",
        sign: Bool = false,
        rounding: NumberFormatter.RoundingMode = .down
    ) -> String {
        Self.shared.formatNumber(
            value,
            type: .currency(
                digits: digits,
                currencySymbol: currencySymbol,
                sign: sign,
                rounding: rounding
            )
        )
    }

    public static func fieldString<Value: BNCNumberFormattable>(
        _ value: Value,
        minimumFractionDigits: Int = 0,
        maximumFractionDigits: Int,
        rounding: NumberFormatter.RoundingMode = .halfEven
    ) -> String {
        Self.shared.formatNumber(
            value,
            type: .field(
                minimumFractionDigits: minimumFractionDigits,
                maximumFractionDigits: maximumFractionDigits,
                rounding: rounding
            )
        )
    }

    public static func multiplierDecimalString<Value: BNCNumberFormattable>(
        _ value: Value,
        digits: Int = 2,
        unit: String = ""
    ) -> String {
        Self.shared.formatNumber(value, type: .multiplierDecimal(digits: digits, unit: unit))
    }

    public static func multiplierDynamicDigitsString<Value: BNCNumberFormattable>(
        _ value: Value,
        minimumFractionDigits: Int = .zero,
        maximumFractionDigits: Int = 2,
        unit: String = "",
        rounding: NumberFormatter.RoundingMode = .halfUp,
        usesGroupingSeparator: Bool = true
    ) -> String {
        Self.shared.formatNumber(value, type: .multiplierDynamicDigits(
            minimumFractionDigits: minimumFractionDigits,
            maximumFractionDigits: maximumFractionDigits,
            unit: unit,
            rounding: rounding
        ))
    }

    public static func multiplierDynamicLocalizationOfDigits<Value: BNCNumberFormattable>(
        _ value: Value,
        minimumFractionDigits: Int = .zero,
        maximumFractionDigits: Int = 2,
        unit: String = "",
        rounding: NumberFormatter.RoundingMode = .halfUp,
        usesGroupingSeparator: Bool = true
    ) -> String {
        Self.shared.formatNumber(value, type: .multiplierDynamicLocalizationOfDigits(
            minimumFractionDigits: minimumFractionDigits,
            maximumFractionDigits: maximumFractionDigits,
            unit: unit,
            rounding: rounding
        ))
    }

    public static func unformattedDecimalString<Value: BNCNumberFormattable>(
        _ value: Value,
        minimumFractionDigits: Int = 0,
        maximumFractionDigits: Int,
        rounding: NumberFormatter.RoundingMode = .down
    ) -> String {
        Self.shared.formatNumber(
            value,
            type: .unformattedDecimal(
                minimumFractionDigits: minimumFractionDigits,
                maximumFractionDigits: maximumFractionDigits,
                rounding: rounding
            )
        )
    }

    public static func fixedDigitsUnformattedDecimalString<Value: BNCNumberFormattable>(
        _ value: Value,
        digits: Int
    ) -> String {
        Self.shared.formatNumber(value, type: .fixedDigitsUnformattedDecimal(digits: digits))
    }
}

public protocol BNCNumberFormattable {}

extension Int: BNCNumberFormattable {}
extension Float: BNCNumberFormattable {}
extension Double: BNCNumberFormattable {}
extension CGFloat: BNCNumberFormattable {}
extension Decimal: BNCNumberFormattable {}

extension NumberFormatter {
    fileprivate func string<Value: BNCNumberFormattable>(from number: Value) -> String {
        if let decimal = number as? Decimal {
            return string(from: decimal as NSDecimalNumber) ?? ""
        } else if let number = number as? NSNumber {
            return string(from: number as NSNumber) ?? ""
        }
        return ""
    }
}
