//
//  BNCFoundationConstants.swift
//  BinanceUI
//
//  Created by user on 2020/1/19.
//

// swiftlint:disable identifier_name

import Foundation
import LoggableKit

public let SAEventPropertyElementID = "$element_id"
public let SAEventPropertyElementTargetURL = "$element_target_url"
public let SAEventPropertyScreenName = "$screen_name"
public let SAEventPropertyTitleID = "$title"
public let SAEventPropertyAppPopup = "$AppPopup"
public let SAEventPropertyExposureName = "$AppExposure"
public let SAEventPropertyAppFocuseName = "$AppFocus"
public let SAEventPropertyApponChangeName = "ApponChange"
public let SAEventPropertyAppKeyPressName = "AppKeyPress"
public let SAEventPropertyPage = "pageName"
public let SAEventPropertyPageCurrency = "page_currency"

extension String {
    public static let bitcoin = "BTC"

    public static let binanceCoin = "BNB"

    public static let ethereum = "ETH"

    public static let altcoins = "ALTS"

    public static let tether = "USDT"

    public static let stablecoins = "USDⓈ"

    public static let stablecoinsShorthand = "USDS"

    public static let all = "ALL"

    public static let btc_usdt = "BTCUSDT"

    public static let btc_busd = "BTCBUSD"

    public static let binanceUSD = "BUSD"

    public static let crypto = "Crypto"
}

extension String {
    public static let placeholder = "--"

    public static let assetHidingPlaceholder = "******"
}

extension String {
    public static let aud = "AUD"
    public static let brl = "BRL"
    public static let cad = "CAD"
    public static let cny = "CNY"
    public static let eur = "EUR"
    public static let gbp = "GBP"
    public static let idr = "IDR"
    public static let inr = "INR"
    public static let jpy = "JPY"
    public static let krw = "KRW"
    public static let rub = "RUB"
    public static let _try = "TRY"
    public static let ugx = "UGX"
    public static let usd = "USD"
}

extension Int {
    public static let defaultQuoteAssetDigits = 8

    public static let defaultBaseAssetDigits = 2

    public static let defaultMinCurrencyDigits = 2

    public static let defaultMinTradeDigits = 4

    public static let defaultMaxCurrencyDigits = 6

    public static let defaultBaseFutureAmountDigits = 3
}

public func memoize<Input: Equatable, Output>(_ function: @escaping ((Input) -> Output)) -> ((Input) -> Output) {
    var memory: (input: Input, output: Output)?

    return { input in
        if let memory = memory, memory.input == input {
            return memory.output
        }

        let output = function(input)
        memory = (input, output)
        return output
    }
}
