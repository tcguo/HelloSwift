//
//  UserDefaults+KVStoreAction.swift
//  BNCFoundationKit
//
//  Created by Ivan Nosov on 12.11.2021.
//

import Foundation

extension UserDefaults: KVStoreAction {
    public func date(forKey key: String) -> Date? {
        object(forKey: key) as? Date
    }

    public func integer(forKey key: String) -> Int? {
        object(forKey: key) as? Int
    }

    public func float(forKey key: String) -> Float? {
        object(forKey: key) as? Float
    }

    public func double(forKey key: String) -> Double? {
        object(forKey: key) as? Double
    }

    public func bool(forKey key: String) -> Bool? {
        object(forKey: key) as? Bool
    }

    public func store(type: KVType, forKey key: String) {
        switch type {
        case let .int(value):
            set(value, forKey: key)
        case let .double(value):
            set(value, forKey: key)
        case let .float(value):
            set(value, forKey: key)
        case let .string(value):
            set(value, forKey: key)
        case let .data(value):
            set(value, forKey: key)
        case let .date(value):
            set(value, forKey: key)
        case let .bool(value):
            set(value, forKey: key)
        case let .codable(_, data: getData):
            set(getData(), forKey: key)
        }
    }

    public func contains(key: String) -> Bool {
        object(forKey: key) != nil
    }

    public func clearAll() {
        dictionaryRepresentation().forEach {
            removeObject(forKey: $0.key)
        }
    }

    public func getAllKeys() -> [String] {
        .init(dictionaryRepresentation().keys)
    }
}
