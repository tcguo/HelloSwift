//
//  KVStore.swift
//  BNCFoundationKit
//
//  Created by ganzhen on 2020/6/24.
//  Copyright © 2020 Binance. All rights reserved.
//

import Foundation

public protocol KVStoreStorage {
    func contains(key: String) -> Bool
    func removeObject(forKey key: String)

    func data(forKey key: String) -> Data?
    func date(forKey key: String) -> Date?
    func integer(forKey key: String) -> Int?
    func float(forKey key: String) -> Float?
    func double(forKey key: String) -> Double?
    func bool(forKey key: String) -> Bool?
    func string(forKey key: String) -> String?
    func codable<T>(forKey key: String) -> T? where T: Codable

    func set(_ value: String?, forKey key: String)
    func set(_ value: Int?, forKey key: String)
    func set(_ value: Double?, forKey key: String)
    func set(_ value: Float?, forKey key: String)
    func set(_ value: Data?, forKey key: String)
    func set(_ value: Date?, forKey key: String)
    func set(_ value: Bool?, forKey key: String)
    func set<T>(_ value: T?, forKey key: String) where T: Codable
}

public protocol KVStoreCache {
    func cache(forKey key: String) -> Any?
    func set(cache: Any?, forKey key: String)
}

public protocol KVStoreAction: AnyObject {
    func removeObject(forKey key: String)
    func data(forKey key: String) -> Data?
    func date(forKey key: String) -> Date?
    func integer(forKey key: String) -> Int?
    func float(forKey key: String) -> Float?
    func double(forKey key: String) -> Double?
    func bool(forKey key: String) -> Bool?
    func string(forKey key: String) -> String?
    func store(type: KVType, forKey key: String)
    func contains(key: String) -> Bool
    func clearAll()
    func getAllKeys() -> [String]
}

public enum KVStoreActionType {
    case int(value: Int)
    case double(value: Double)
    case float(value: Float)
    case string(value: String)
    case bool(value: Bool)
    case data(value: Data)
    case date(value: Date)
}

public enum KVType {
    case int(value: Int)
    case double(value: Double)
    case float(value: Float)
    case string(value: String)
    case bool(value: Bool)
    case data(value: Data)
    case date(value: Date)
    case codable(object: Codable, data: () -> Data?)

    public var actionType: KVStoreActionType {
        switch self {
        case let .int(value: value):
            return .int(value: value)
        case let .double(value: value):
            return .double(value: value)
        case let .float(value: value):
            return .float(value: value)
        case let .string(value: value):
            return .string(value: value)
        case let .bool(value: value):
            return .bool(value: value)
        case let .data(value: value):
            return .data(value: value)
        case let .date(value: value):
            return .date(value: value)
        case .codable(object: _, data: let data):
            return .data(value: data() ?? Data())
        }
    }
}

public protocol KVStoreCustomable {
    var customStore: KVStoreAction { get }
}

public class KVStore: KVStoreStorage, KVStoreCache {
    public static let shared = KVStore()

    private var custom: KVStoreAction {
        (KVStore.shared as? KVStoreCustomable)?.customStore ?? UserDefaults.standard
    }

    // memory cache

    private var cacheMap: [String: Any]? = [:]

    private let cacheLock = NSLock()

    public func set(_ value: String?, forKey key: String) {
        if let value = value {
            set(type: .string(value: value), forKey: key)
        } else {
            removeObject(forKey: key)
        }
    }

    public func set(_ value: Int?, forKey key: String) {
        if let value = value {
            set(type: .int(value: value), forKey: key)
        } else {
            removeObject(forKey: key)
        }
    }

    public func set(_ value: Double?, forKey key: String) {
        if let value = value {
            set(type: .double(value: value), forKey: key)
        } else {
            removeObject(forKey: key)
        }
    }

    public func set(_ value: Float?, forKey key: String) {
        if let value = value {
            set(type: .float(value: value), forKey: key)
        } else {
            removeObject(forKey: key)
        }
    }

    public func set(_ value: Data?, forKey key: String) {
        if let value = value {
            set(type: .data(value: value), forKey: key)
        } else {
            removeObject(forKey: key)
        }
    }

    public func set(_ value: Date?, forKey key: String) {
        if let value = value {
            set(type: .date(value: value), forKey: key)
        } else {
            removeObject(forKey: key)
        }
    }

    public func set(_ value: Bool?, forKey key: String) {
        if let value = value {
            set(type: .bool(value: value), forKey: key)
        } else {
            removeObject(forKey: key)
        }
    }

    public func set<T>(_ value: T?, forKey key: String) where T: Codable {
        if let value = value {
            set(type: .codable(object: value, data: { try? JSONEncoder().encode(value) }), forKey: key)
        } else {
            removeObject(forKey: key)
        }
    }

    public func removeObject(forKey key: String) {
        custom.removeObject(forKey: key)
    }

    public func contains(key: String) -> Bool {
        custom.contains(key: key)
    }

    public func clearAll() {
        custom.clearAll()
        clearAllCache()
    }
}

extension KVStore {
    public func data(forKey key: String) -> Data? {
        custom.data(forKey: key)
    }

    public func date(forKey key: String) -> Date? {
        custom.date(forKey: key)
    }

    public func integer(forKey key: String) -> Int? {
        custom.integer(forKey: key)
    }

    public func float(forKey key: String) -> Float? {
        custom.float(forKey: key)
    }

    public func double(forKey key: String) -> Double? {
        custom.double(forKey: key)
    }

    public func bool(forKey key: String) -> Bool? {
        custom.bool(forKey: key)
    }

    public func string(forKey key: String) -> String? {
        custom.string(forKey: key)
    }

    public func codable<T>(forKey key: String) -> T? where T: Codable {
        guard let data = data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}

extension KVStore {
    private func set(type: KVType, forKey key: String) {
        custom.store(type: type, forKey: key)
    }
}

// MARK: Memory cache
extension KVStore {
    public static let cacheValueDidChangeNotificationName = NSNotification.Name(
        "KVStoreCacheValueDidChangeNotificationKey"
    )

    public func enable(cache flag: Bool) {
        cacheLock.lock()

        defer {
            cacheLock.unlock()
        }

        guard flag else {
            return cacheMap = nil
        }

        guard cacheMap == nil else {
            return
        }

        cacheMap = [:]
    }

    public func clearAllCache() {
        cacheLock.lock()

        defer {
            cacheLock.unlock()
        }

        if cacheMap != nil {
            cacheMap = [:]
        }
    }

    public func cache(forKey key: String) -> Any? {
        cacheLock.lock()
        defer {
            cacheLock.unlock()
        }
        return cacheMap?[key]
    }

    public func set(cache: Any?, forKey key: String) {
        cacheLock.lock()

        if cacheMap == nil {
            return cacheLock.unlock()
        }

        if let cache = cache {
            cacheMap?[key] = cache
        } else {
            cacheMap?.removeValue(forKey: key)
        }

        cacheLock.unlock()

        NotificationCenter.default.post(
            name: Self.cacheValueDidChangeNotificationName,
            object: self,
            userInfo: ["key": key, "value": cache as Any]
        )
    }
}
