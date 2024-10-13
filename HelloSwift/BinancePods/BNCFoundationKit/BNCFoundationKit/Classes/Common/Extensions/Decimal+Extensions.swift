//
//  Decimal+Extensions.swift
//  Binance
//
//  Created by Daniel Clelland on 10/01/19.
//  Copyright © 2019 Binance. All rights reserved.
//

import UIKit

extension Decimal {
    public init(_ value: CGFloat) {
        self.init(Double(value))
    }
}

extension Decimal {
    public init(exponent: Int) {
        self.init(sign: .plus, exponent: exponent, significand: 1.0)
    }
}

extension Decimal {
    public enum ComparisonResult {
        case ascending
        case same
        case descending
    }

    public func compare(with decimal: Decimal) -> ComparisonResult {
        switch (self as NSDecimalNumber).compare(decimal as NSDecimalNumber) {
        case .orderedAscending:
            return .ascending
        case .orderedSame:
            return .same
        case .orderedDescending:
            return .descending
        }
    }
}

extension Decimal {
    public func decrementing(exponent: Int) -> Decimal {
        self - Decimal(exponent: exponent)
    }

    public func incrementing(exponent: Int) -> Decimal {
        self + Decimal(exponent: exponent)
    }
}

extension Decimal {
    public func rounding(_ roundingMode: NSDecimalNumber.RoundingMode, scale: Int) -> Decimal {
        (self as NSDecimalNumber).rounding(roundingMode, scale: scale).decimalValue
    }

    public func roundingMultiples(_ roundingMode: NSDecimalNumber.RoundingMode, scale: Int, multiples: Int) -> Decimal {
        let doubleSelf = (self as NSDecimalNumber).doubleValue
        if roundingMode == .up {
            return doubleSelf.rounding(multiples, .up)
        } else if roundingMode == .down {
            return doubleSelf.rounding(multiples, .down)
        } else {
            return (self as NSDecimalNumber).rounding(roundingMode, scale: scale).decimalValue
        }
    }
}

extension Double {
    public func rounding(_ multiples: Int, _ side: FloatingPointRoundingRule) -> Decimal {
        precondition(multiples > 0, "multiples has to be positive")

        let result = Int((self / Double(multiples)).rounded(side)) * multiples
        return Decimal(string: String(result)) ?? 0
    }
}

extension NSDecimalNumber {
    public func rounding(_ roundingMode: NSDecimalNumber.RoundingMode, scale: Int) -> NSDecimalNumber {
        rounding(
            accordingToBehavior: NSDecimalNumberHandler(
                roundingMode: roundingMode,
                scale: Int16(scale),
                raiseOnExactness: false,
                raiseOnOverflow: false,
                raiseOnUnderflow: false,
                raiseOnDivideByZero: false
            )
        )
    }
}

extension Decimal {
    public var significantFractionalDecimalDigits: Int {
        max(-exponent, 0)
    }
}

extension Decimal {
    public var balanceString: String {
        BNCNumberFormatter.decimalString(
            self,
            minimumFractionDigits: .zero,
            maximumFractionDigits: .defaultQuoteAssetDigits
        )
    }

    public var unformattedBalanceString: String {
        BNCNumberFormatter.unformattedDecimalString(
            self,
            minimumFractionDigits: .zero,
            maximumFractionDigits: .defaultQuoteAssetDigits
        )
        .replaceLocalDecimalSeparatorWithDot()
    }

    public var balanceInputString: String {
        let numberFormatter = NumberFormatter(
            style: .none,
            minimumDigits: .zero,
            maximumDigits: .defaultQuoteAssetDigits
        )
        numberFormatter.roundingMode = .down
        return numberFormatter.string(from: self)
    }
}

extension Decimal {
    public var cryptoString: String {
        BNCNumberFormatter.decimalString(
            self,
            minimumFractionDigits: .defaultBaseAssetDigits,
            maximumFractionDigits: .defaultQuoteAssetDigits
        )
    }

    public var currencyString: String {
        let numberFormatter = NumberFormatter(
            style: .currency,
            minimumDigits: .defaultBaseAssetDigits,
            maximumDigits: .defaultQuoteAssetDigits
        )
        numberFormatter.roundingMode = .down
        return numberFormatter.string(from: self)
    }

    public func referenceString(_ reference: Decimal, style: NumberFormatter.Style = .decimal) -> String {
        let numberFormatter = NumberFormatter(style: style, digits: abs(reference.exponent))
        numberFormatter.roundingMode = .down
        return numberFormatter.string(from: self)
    }
}

extension Decimal {
    public var digits: Int {
        abs(exponent)
    }
}

// Futures
extension Decimal {
    public var endInterval: Decimal {
        switch self {
        case ..<0.0000001:
            return 0.0000001
        case 0.0000001..<0.000001:
            return 0.0000001
        case 0.000001..<0.00001:
            return 0.000001
        case 0.00001..<0.0001:
            return 0.00001
        case 0.0001..<0.001:
            return 0.0001
        case 0.001..<0.01:
            return 0.001
        case 0.01..<0.1:
            return 0.01
        case 0.1..<1:
            return 0.1
        case 1..<10:
            return 1
        case 10..<50:
            return 10
        case 50..<100:
            return 50
        case 100...:
            return 100
        default:
            return 100
        }
    }

    public var accuracyDigit: Int {
        switch self {
        case 0.0000001:
            return 7
        case 0.000001:
            return Int.defaultMaxCurrencyDigits
        case 0.00001:
            return 5
        case 0.0001:
            return 4
        case 0.001:
            return Int.defaultBaseFutureAmountDigits
        case 0.01:
            return Int.defaultBaseAssetDigits
        case 0.1:
            return 1
        case 1:
            return 0
        case 10:
            return -1
        case 50:
            return -2
        case 100:
            return -2
        default:
            return Int.defaultQuoteAssetDigits
        }
    }
}
