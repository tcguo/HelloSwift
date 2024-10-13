//
//  MetricPrefix.swift
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

public enum MetricPrefixSetting: String {
    case tr
    case zhHans = "zh-CN"
    case zhHant = "zh-TW"
    case ptBR = "pt-BR"
    case ru
    case hi
    case de
    case nl
    case fr
    case en

    public var prefixes: [MetricPrefix: String] {
        switch self {
        case .tr:
            return MetricPrefix.TurkishPrefixes
        case .zhHans:
            return MetricPrefix.SimplifiedChinesePrefixes
        case .zhHant:
            return MetricPrefix.TraditionalChinesePrefixes
        case .ptBR:
            return MetricPrefix.BrazilianPrefixes
        case .ru:
            return MetricPrefix.RussianPrefixes
        case .hi:
            return MetricPrefix.HindiPrefixes
        case .de:
            return MetricPrefix.GermanPrefixes
        case .nl:
            return MetricPrefix.DutchPrefixes
        case .fr:
            return MetricPrefix.FrenchPrefixes
        default:
            return MetricPrefix.EnglishPrefixes
        }
    }

    public var delimiter: String {
        switch self {
        case .zhHans, .zhHant, .en:
            return ""
        default:
            return " "
        }
    }
}

public enum MetricPrefix: Int, CaseIterable {
    case tera = 12
    case giga = 9
    case hundredMega = 8
    case tenMega = 7
    case mega = 6
    case hundredKilo = 5
    case tenKilo = 4
    case kilo = 3
    case zero = 0

    static var DefaultPrefixes: [MetricPrefix: String] {
        [
            .tera: "T",
            .giga: "B",
            .mega: "M",
            .kilo: "K",
            .zero: ""
        ]
    }

    static var EnglishPrefixes: [MetricPrefix: String] {
        [
            .tera: "T",
            .giga: "B",
            .mega: "M",
            .zero: ""
        ]
    }

    static var TurkishPrefixes: [MetricPrefix: String] {
        [
            .tera: "trilyon",
            .giga: "milyar",
            .mega: "milyon",
            .zero: ""
        ]
    }

    static var SimplifiedChinesePrefixes: [MetricPrefix: String] {
        [
            .tera: "兆",
            .hundredMega: "亿",
            .tenKilo: "万",
            .zero: ""
        ]
    }

    static var TraditionalChinesePrefixes: [MetricPrefix: String] {
        [
            .tera: "兆",
            .hundredMega: "億",
            .tenKilo: "萬",
            .zero: ""
        ]
    }

    static var BrazilianPrefixes: [MetricPrefix: String] {
        [
            .tera: "tri",
            .giga: "bi",
            .mega: "mi",
            .zero: ""
        ]
    }

    static var RussianPrefixes: [MetricPrefix: String] {
        [
            .tera: "трлн",
            .giga: "млрд",
            .mega: "млн",
            .zero: ""
        ]
    }

    static var HindiPrefixes: [MetricPrefix: String] {
        [
            .tera: "लाख करोड़",
            .tenMega: "करोड़",
            .hundredKilo: "लाख",
            .zero: ""
        ]
    }

    static var GermanPrefixes: [MetricPrefix: String] {
        [
            .tera: "Bio.",
            .giga: "Mrd.",
            .mega: "Mio.",
            .zero: ""
        ]
    }

    static var DutchPrefixes: [MetricPrefix: String] {
        [
            .tera: "bln.",
            .giga: "mld.",
            .mega: "mln.",
            .zero: ""
        ]
    }

    static var FrenchPrefixes: [MetricPrefix: String] {
        [
            .giga: "Mrd",
            .mega: "Mio",
            .zero: ""
        ]
    }
}

extension MetricPrefix: Comparable {}

public func < (lhs: MetricPrefix, rhs: MetricPrefix) -> Bool {
    lhs.rawValue < rhs.rawValue
}
