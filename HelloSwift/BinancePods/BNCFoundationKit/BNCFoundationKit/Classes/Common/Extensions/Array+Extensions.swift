//
//  Array+Extensions.swift
//  Binance
//
//  Created by Daniel Clelland on 23/01/19.
//  Copyright © 2019 Binance. All rights reserved.
//

import Foundation

extension Array {
    public func padding(toLength length: Int) -> [Element?] {
        Array(prefix(length)) + [Element?](repeating: nil, count: Swift.max(length - count, 0))
    }

    public func padding(toLength length: Int, withPad element: Element) -> [Element] {
        Array(prefix(length)) + Array(repeating: element, count: Swift.max(length - count, 0))
    }

    public mutating func appendToQueue(_ element: Element, size: Int) {
        guard size > 0 else {
            return
        }
        removeFirst(Swift.max(0, count + 1 - size))
        append(element)
    }

    public mutating func prependToQueue(_ element: Element, size: Int) {
        guard size > 0 else {
            return
        }
        removeLast(Swift.max(0, count + 1 - size))
        insert(element, at: 0)
    }

    public func filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({ filter($0) }).contains(key) {
                result.append(value)
            }
        }
        return result
    }

    public func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }

    public subscript(safe range: Range<Index>) -> ArraySlice<Element> {
        self[Swift.min(range.startIndex, endIndex) ..< Swift.min(range.endIndex, endIndex)]
    }
}
