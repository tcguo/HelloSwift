//
//  TimeZone+Extensions.swift
//  BinanceClient
//
//  Created by Binance on 15/03/18.
//

import Foundation

extension TimeZone {
    public var isChinaStandardTime: Bool {
        let locale = Locale(identifier: "EN")
        let style = NSTimeZone.NameStyle.generic
        guard let name = localizedName(for: style, locale: locale),
              let cnTimeZone = TimeZone(identifier: "Asia/Shanghai"),
              let cnName = cnTimeZone.localizedName(for: style, locale: locale) else {
            return false
        }
        return name == cnName
    }

    // BNC-Time-Zone
    public var bncTimeZone: String {
        TimeZone.current.identifier
    }
}
