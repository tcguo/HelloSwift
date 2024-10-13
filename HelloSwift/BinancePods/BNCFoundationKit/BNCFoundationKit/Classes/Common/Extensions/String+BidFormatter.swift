//
//  String+BidFormatter.swift
//  BNCFoundationKit
//
//  Created by fox on 2020/9/29.
//

import Foundation

extension String {
    public func appendBidFormatterString(ltrString: String) -> String {
        self + "\u{202A}" + ltrString + "\u{202C}"
    }
}
