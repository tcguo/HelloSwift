//
//  NumberFormatter+Extensions.swift
//  Binance
//
//  Created by Daniel Clelland on 18/09/18.
//  Copyright © 2018 Binance. All rights reserved.
//

import CoreGraphics
import Foundation

extension NumberFormatter {
    public convenience init(style: NumberFormatter.Style, minimumDigits: Int = 0, maximumDigits: Int) {
        self.init()
        numberStyle = style
        minimumIntegerDigits = 1
        minimumFractionDigits = minimumDigits
        maximumFractionDigits = maximumDigits
    }

    public convenience init(style: NumberFormatter.Style, digits: Int) {
        self.init(style: style, minimumDigits: digits, maximumDigits: digits)
    }
}

extension NumberFormatter {
    public func string(from integer: Int) -> String {
        string(from: integer as NSNumber) ?? ""
    }

    public func string(from float: Float) -> String {
        string(from: float as NSNumber) ?? ""
    }

    public func string(from double: Double) -> String {
        string(from: double as NSNumber) ?? ""
    }

    public func string(from cgFloat: CGFloat) -> String {
        string(from: cgFloat as NSNumber) ?? ""
    }

    public func string(from decimal: Decimal) -> String {
        string(from: decimal as NSDecimalNumber) ?? ""
    }
}
