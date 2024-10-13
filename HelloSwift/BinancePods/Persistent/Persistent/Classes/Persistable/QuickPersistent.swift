//
//  QuickPersistent.swift
//  BNCFoundationKit
//
//  Created by ameng.liu on 4/20/21.
//

import LoggableKit

/// What's the difference between this and Persistent?
///
/// It's almost same as `Persistent`, in additional it would store values in memory when you try to read a value
/// from KVStore/MMKV. It'll try to read object from memory first, if object not exist in memory,
/// then it'll try to read object from disk, if exist, it'll return the object and write it to memory,
/// so the object will be read from memory in next time.
///
/// In some cases, especially the custom type, MMKV cannot store these Swift Types,
/// It will encode the value into Binary and write Binary to Disk,
/// which takes a long time depend on the complexity of data structure.
/// Write may not be frequently, but Binary should be decoded into Object first,
/// every time when you try to read this value, so memory cache is significantly.
///
/// WARNING:
/// - Reference type (class) is not recommended, if you pass a reference type which will be stored in memory,
/// this mean it won't be released unless you remove it
/// from memory cache manually by calling `KVStore.shared.set(cache: nil, forKey: someKey)`
/// - Also, We MUST ensure all objects matching the same key
/// should be stored with the same `Persistent` manager(QuickPersistent/Persistent)
/// to guarantee the memory cache is same to the disk cache
///
@propertyWrapper public struct QuickPersistent<Value: Persistable> {
    let cache: KVStoreCache
    var persistent: BasePersistent<Value>
    var key: String { persistent.key }
    var defaultValue: Value { persistent.defaultValue }
    var storage: KVStoreStorage { persistent.storage }

    public init(key: String, defaultValue: Value) {
        cache = KVStore.shared
        persistent = .init(key: key, defaultValue: defaultValue, storage: KVStore.shared)
    }

    public init<Wrapped>(key: String) where Value == Wrapped? {
        self.init(key: key, defaultValue: nil)
    }

    public init<Wrapped>(key: String, defaultValue: Wrapped) where Value == Wrapped? {
        cache = KVStore.shared
        persistent = .init(key: key, defaultValue: Wrapped?.none, storage: KVStore.shared)
    }

    public var wrappedValue: Value {
        get {
            do {
                return try getValue()
            } catch {
                log(message: "Get value for key \"\(key)\" failed", error: error)
                return defaultValue
            }
        }
        mutating set {
            do {
                try setValue(newValue)
            } catch {
                log(message: "Set value (\(newValue)) for key \"\(key)\" failed", error: error)
            }
        }
    }

    func getValue() throws -> Value {
        if let cache = cache.cache(forKey: key),
           let value = deepUnwrap(cache) as? Value {
            return value
        }
        guard storage.contains(key: key) else {
            return defaultValue
        }
        let value = try persistent.getValue()
        cache.set(cache: value, forKey: key)
        return value
    }

    mutating func setValue(_ value: Value) throws {
        if deepUnwrap(value) == nil {
            storage.removeObject(forKey: key)
            cache.set(cache: nil, forKey: key)
            return
        }

        let result = try value.encode()
        if deepUnwrap(result) == nil {
            storage.removeObject(forKey: key)
            cache.set(cache: nil, forKey: key)
            return
        }

        guard let newValue = result as? KVStoreBasicType else {
            throw PersistentError.castFailed
        }
        newValue.setSelf(forKey: key, storage: storage)
        cache.set(cache: value, forKey: key)
    }
}

extension QuickPersistent {
    public var value: Value {
        get {
            wrappedValue
        }
        mutating set {
            wrappedValue = newValue
        }
    }
}

extension QuickPersistent: Loggable {
    public var category: BinanceLog.Category {
        BinanceLog.Category(String(describing: type(of: self)))
    }
}
