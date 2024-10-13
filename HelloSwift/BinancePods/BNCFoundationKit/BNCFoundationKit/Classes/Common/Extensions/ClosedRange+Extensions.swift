//
//  ClosedRange+Extensions.swift
//  Binance
//
//  Created by Daniel Clelland on 16/01/19.
//  Copyright © 2019 Binance. All rights reserved.
//

import Foundation

extension ClosedRange {
    public func clamp(_ value: Bound) -> Bound {
        Swift.min(Swift.max(value, lowerBound), upperBound)
    }
}

extension ClosedRange where Bound == Decimal {
    public var center: Bound {
        (lowerBound + upperBound) / 2.0
    }
}
