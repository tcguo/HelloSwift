//
//  TimeChunk+Extensions.swift
//  BNCTransactionsModule
//
//  Created by Qing Wan, Kuah on 4/7/22.
//

import DateToolsSwift

extension TimeChunk {
    private static let threeMonthsTimeChunk = TimeChunk(
        seconds: 59,
        minutes: 59,
        hours: 23,
        days: 0,
        weeks: 0,
        months: 3,
        years: 0
    )

    private static let twelveMonthsTimeChunk = TimeChunk(
        seconds: 59,
        minutes: 59,
        hours: 23,
        days: 0,
        weeks: 0,
        months: 0,
        years: 1
    )

    public var isThreeMonthsTimeChunk: Bool {
        equals(chunk: .threeMonthsTimeChunk)
    }

    public var isTwelveMonthsTimeChunk: Bool {
        equals(chunk: .twelveMonthsTimeChunk)
    }
}
