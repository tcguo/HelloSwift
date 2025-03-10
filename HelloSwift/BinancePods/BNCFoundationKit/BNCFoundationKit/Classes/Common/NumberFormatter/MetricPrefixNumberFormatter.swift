//
//  MetricPrefixNumberFormatter.swift
//  MetricPrefixNumberFormatter
//
//  Created by Rostyslav Dovhaliuk on 16.03.2019.
//  Copyright © 2019 Rostyslav Dovhaliuk. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

// Documentation
// https://docs.devfdg.net/docs/ios/frameworks/BNCFoundationKit/number_formatter/MetricPrefixNumberFormatter
open class MetricPrefixNumberFormatter: NumberFormatter {
    public var unit = ""
    public var minimumMagnitude = 6 // Million
    public var delimiter = " "
    public var localizationDictionary = MetricPrefix.EnglishPrefixes

    override open func string(from number: NSNumber) -> String? {
        let numberAsDouble = number.doubleValue
        guard !numberAsDouble.isNaN else { return nil }

        let prefix: MetricPrefix
        let scaledNumber: NSNumber

        if number == 0 {
            prefix = .zero
            scaledNumber = number
        } else {
            let orderOfMagnitude = Int(log10(fabs(numberAsDouble)))

            if orderOfMagnitude < minimumMagnitude {
                prefix = .zero
                scaledNumber = number
            } else {
                let smallerOrEqualPrefixes = MetricPrefix.allCases.filter {
                    $0.rawValue <= orderOfMagnitude &&
                        localizationDictionary[$0] != nil
                }
                prefix = smallerOrEqualPrefixes.max() ?? MetricPrefix.zero
                scaledNumber = NSNumber(value: numberAsDouble / pow(10.0, Double(prefix.rawValue)))
            }
        }

        guard let formattedNumber = super.string(from: scaledNumber),
              let prefixString = localizationDictionary[prefix] else { return nil }

        var ret = ""
        if prefixString.isEmpty {
            ret = formattedNumber
        } else {
            ret = "\(formattedNumber)\(delimiter)\(prefixString)"
        }

        if !unit.isEmpty {
            ret.append(" \(unit)")
        }
        return ret
    }
}
