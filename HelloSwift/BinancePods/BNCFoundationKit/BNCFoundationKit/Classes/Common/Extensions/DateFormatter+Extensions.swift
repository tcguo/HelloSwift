//
//  DateFormatter+Extensions.swift
//  Binance
//
//  Created by Daniel Clelland on 18/09/18.
//  Copyright © 2018 Binance. All rights reserved.
//

// swiftlint:disable identifier_name line_length

import Foundation

extension DateFormatter {
    public convenience init(dateFormat: String, locale: Locale? = nil) {
        self.init()

        self.dateFormat = dateFormat
        if let locale = locale {
            self.locale = locale
        }
    }
}

/*
 * Apple <Date Formatting Guide>
 *
 * If you're working with fixed-format dates, you should first set the locale of the date formatter to something appropriate for your fixed format. In most cases the best locale to choose is en_US_POSIX, a locale that's specifically designed to yield US English results regardless of both user and system preferences. en_US_POSIX is also invariant in time (if the US, at some point in the future, changes the way it formats dates, en_US will change to reflect the new behavior, but en_US_POSIX will not), and between platforms (en_US_POSIX works the same on iPhone OS as it does on OS X, and as it does on other platforms)
 */

extension DateFormatter {
    public static let year = DateFormatter(dateFormat: "yyyy", locale: Locale(identifier: "en_US_POSIX"))

    public static let yearsAndMonths = DateFormatter(dateFormat: "yyyy-MM", locale: Locale(identifier: "en_US_POSIX"))

    public static let yearsAndShortMonths = DateFormatter(
        dateFormat: "yyyy-MMM",
        locale: Locale(identifier: "en_US_POSIX")
    )

    public static let shortMonths = DateFormatter(dateFormat: "MMM", locale: Locale(identifier: "en_US_POSIX"))

    public static let yearsAndMonthsAndDays = DateFormatter(
        dateFormat: "yyyy-MM-dd",
        locale: Locale(identifier: "en_US_POSIX")
    )
    public static let aYearsAndMonthsAndDays = DateFormatter(
        dateFormat: "yyyy/MM/dd",
        locale: Locale(identifier: "en_US_POSIX")
    )

    public static let yearsAndMonthsAndDaysAndHoursAndMinutesAndSeconds = DateFormatter(
        dateFormat: "yyyy-MM-dd HH:mm:ss",
        locale: Locale(identifier: "en_US_POSIX")
    )

    public static let yearsAndMonthsAndDaysAndHoursAndMinutes = DateFormatter(
        dateFormat: "yyyy-MM-dd HH:mm",
        locale: Locale(identifier: "en_US_POSIX")
    )

    /// Output example: "2022-04-28 13:00 (GMT+8)"
    public static let yearsAndMonthsAndDaysAndHoursAndMinutesAndTimeZone = DateFormatter(
        dateFormat: "yyyy-MM-dd HH:mm (O)",
        locale: Locale(identifier: "en_US_POSIX")
    )

    public static let monthsAndDays = DateFormatter(dateFormat: "MM-dd", locale: Locale(identifier: "en_US_POSIX"))

    public static let monthsAndDaysAndHoursAndMinutes = DateFormatter(
        dateFormat: "MM-dd HH:mm",
        locale: Locale(identifier: "en_US_POSIX")
    )

    public static let hoursAndMinutes = DateFormatter(dateFormat: "HH:mm", locale: Locale(identifier: "en_US_POSIX"))

    public static let hoursAndMinutesAndSeconds = DateFormatter(
        dateFormat: "HH:mm:ss",
        locale: Locale(identifier: "en_US_POSIX")
    )

    public static let monthsAndDaysAndHoursAndMinutesAndSeconds = DateFormatter(
        dateFormat: "MM-dd HH:mm:ss",
        locale: Locale(identifier: "en_US_POSIX")
    )
}

extension DateFormatter {
    public func string(from timeInterval: TimeInterval) -> String {
        string(from: Date(timeIntervalSince1970: timeInterval))
    }
}
