//
//  Collection+Extensions.swift
//  Binance
//
//  Created by Daniel Clelland on 11/11/18.
//  Copyright © 2018 Binance. All rights reserved.
//

import Foundation

extension Collection {
    public subscript(safe index: Index) -> Element? {
        guard indices.contains(index) else {
            return nil
        }

        return self[index]
    }
}

extension Collection where Element: Equatable {
    public var uniques: [Element] {
        reduce(into: []) { result, element in
            if !result.contains(element) {
                result += [element]
            }
        }
    }
}

extension Collection where Element: Comparable {
    public func sorted(withBaseOrder order: [Element]) -> [Element] {
        sorted { lhs, rhs in
            switch (order.firstIndex(of: lhs), order.firstIndex(of: rhs)) {
            case let (.some(lhs), .some(rhs)):
                return lhs < rhs
            case (.some, .none):
                return true
            case (.none, .some):
                return false
            case (.none, .none):
                return lhs < rhs
            }
        }
    }
}

extension Collection {
    public func sorted<T>(withBaseOrder order: [T], _ map: (Element) -> T) -> [Element] where T: Comparable {
        sorted { lhs, rhs in
            switch (order.firstIndex(of: map(lhs)), order.firstIndex(of: map(rhs))) {
            case let (.some(lhs), .some(rhs)):
                return lhs < rhs
            case (.some, .none):
                return true
            case (.none, .some):
                return false
            case (.none, .none):
                return map(lhs) < map(rhs)
            }
        }
    }
}
