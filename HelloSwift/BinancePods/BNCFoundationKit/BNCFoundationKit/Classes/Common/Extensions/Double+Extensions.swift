//
//  Double+Extensions.swift
//  Binance
//
//  Created by Daniel Clelland on 26/01/19.
//  Copyright © 2019 Binance. All rights reserved.
//

import Foundation

extension Double {
    public init(_ decimal: Decimal) {
        self.init((decimal as NSDecimalNumber).doubleValue)
    }

    public var angleToRadian: CGFloat {
        CGFloat(self / Double(180.0) * .pi)
    }

    public var radianToAngle: CGFloat {
        CGFloat(self * Double(180.0) / .pi)
    }
}
