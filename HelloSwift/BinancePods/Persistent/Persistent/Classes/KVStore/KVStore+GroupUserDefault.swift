//
//  KVStore+groupUserDefault.swift
//  BNCFoundationKit
//
//  Created by user on 2021/11/14.
//

import Foundation

extension KVStore {
    public func setWithGroup<T>(_ value: T?, forKey key: String) where T: Codable {
        UserDefaults.group.set(value, forKey: key)
        set(value, forKey: key)
    }

    public func removeObjectWithGroup(forKey key: String) {
        UserDefaults.group.removeObject(forKey: key)
        removeObject(forKey: key)
    }

    public func containsWithGroup(key: String) -> Bool {
        if UserDefaults.group.value(forKey: key) != nil {
            return true
        }
        return contains(key: key)
    }

    public func clearAllWithGroup() {
        UserDefaults.group
            .dictionaryRepresentation()
            .forEach {
                UserDefaults.group.removeObject(forKey: $0.key)
            }
        clearAll()
    }
}
