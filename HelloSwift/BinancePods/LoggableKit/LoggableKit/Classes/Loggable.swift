//
//  Loggable.swift
//  Binance
//
//  Created by Daniel Clelland on 29/11/18.
//  Copyright © 2018 Binance. All rights reserved.
//

public protocol Loggable {
    var category: BinanceLog.Category { get }
}

extension Loggable {
    public func log(message: String) {
        BinanceLog.log(category: category, message: message)
    }

    public func log(message: String, error: Error) {
        BinanceLog.log(category: category, message: message, error: error)
    }
}
