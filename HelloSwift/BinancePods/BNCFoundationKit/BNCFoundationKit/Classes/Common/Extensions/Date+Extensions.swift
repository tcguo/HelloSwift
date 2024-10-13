//
//  Date+Extensions.swift
//  Binance
//
//  Created by Daniel Clelland on 16/01/19.
//  Copyright © 2019 Binance. All rights reserved.
//

import DateToolsSwift
import Foundation

extension Date {
    public var isMidnight: Bool {
        (timeIntervalSince1970 + Double(TimeZone.current.secondsFromGMT()))
            .truncatingRemainder(dividingBy: 86400.0) == 0.0
    }

    public var midnight: Date {
        if let midnight = DateFormatter.yearsAndMonthsAndDays
            .date(from: DateFormatter.yearsAndMonthsAndDays.string(from: self)) {
            return midnight
        } else {
            // calendar is more appropriate
            let calendar = Calendar.current
            let compos = calendar.dateComponents([.year, .month, .day], from: self)

            return calendar.date(from: compos)!
        }
    }

    @available(*, deprecated, message: "Use oneMillisecondBeforeMidnight instead.")
    public var beforeMidnight: Date {
        1.seconds.earlier(than: 1.days.later(than: midnight))
    }

    public var oneMillisecondBeforeMidnight: Date {
        1.seconds.earlier(than: 1.days.later(than: midnight)).addingTimeInterval(0.999)
    }

    public var tomorrow: Date {
        1.days.later(than: self)
    }

    public static var today: Date {
        Date()
    }

    public static var current: Date {
        Date()
    }
}

extension Date {
    public func rounded(_ rule: FloatingPointRoundingRule) -> Date {
        let interval = timeIntervalSinceReferenceDate.rounded(rule)
        return Date(timeIntervalSinceReferenceDate: interval)
    }
}

extension Date {
    public var countingDownString: String? {
        guard isLater(than: .current) else {
            return nil
        }
        let chunk = chunkBetween(date: .current)
        let hours = abs(chunk.hours)
        let minutes = abs(chunk.minutes)
        let seconds = abs(chunk.seconds)
        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%d:%02d", minutes, seconds)
        }
    }

    public func countingDown(sinceDate: Date) -> Int {
        guard isLater(than: .current) else {
            return 0
        }
        return Calendar.current.dateComponents([.second], from: sinceDate, to: self).second ?? 0
    }
}

extension Date {
    public var millisecondsSince1970: Int64 {
        Int64(timeIntervalSince1970 * 1000.0)
    }
}
