//
//  BasePersistent.swift
//  BNCFoundationKit
//
//  Created by Ivan Nosov on 11.11.2021.
//

import Foundation
import LoggableKit

public enum PersistentError: Error {
    case castFailed
    case decodeFailed(reason: String)
}

struct BasePersistent<Value: Persistable> {
    let key: String
    let defaultValue: Value
    let storage: KVStoreStorage

    init(key: String, defaultValue: Value, storage: KVStoreStorage) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
        registerDefaultValue(defaultValue)
    }

    init<Wrapped>(key: String, storage: KVStoreStorage) where Value == Wrapped? {
        self.init(key: key, defaultValue: nil, storage: storage)
    }

    init<Wrapped>(key: String, defaultValue: Wrapped, storage: KVStoreStorage) where Value == Wrapped? {
        self.key = key
        self.defaultValue = Wrapped?.none
        self.storage = storage
        registerDefaultValue(defaultValue)
    }

    var value: Value {
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
        guard storage.contains(key: key) else {
            return defaultValue
        }

        if let type = Value.PersistentValue.self as? OptionalWrapped.Type {
            guard let wrapped = type.wrappedType as? KVStoreBasicType.Type,
                  let data = wrapped.getSelf(forKey: key, storage: storage) else {
                throw PersistentError.castFailed
            }

            if let result = data as? Value, deepUnwrap(result) != nil {
                return result
            }

            if let result = data as? Value.PersistentValue, deepUnwrap(result) != nil {
                return try Value.decode(result)
            }

            throw PersistentError.castFailed

        } else {
            guard let type = Value.PersistentValue.self as? KVStoreBasicType.Type,
                  let data = type.getSelf(forKey: key, storage: storage) else {
                throw PersistentError.castFailed
            }

            if let result = data as? Value, deepUnwrap(result) != nil {
                return result
            }

            if let result = data as? Value.PersistentValue, deepUnwrap(result) != nil {
                return try Value.decode(result)
            }

            throw PersistentError.castFailed
        }
    }

    mutating func setValue(_ value: Value) throws {
        if deepUnwrap(value) == nil {
            storage.removeObject(forKey: key)
            return
        }

        let result = try value.encode()
        if deepUnwrap(result) == nil {
            storage.removeObject(forKey: key)
            return
        }

        guard let newValue = result as? KVStoreBasicType else {
            throw PersistentError.castFailed
        }
        newValue.setSelf(forKey: key, storage: storage)
    }

    mutating func registerDefaultValue(_ value: Value) {
        guard !storage.contains(key: key) else { return }
        do {
            try setValue(value)
        } catch {
            log(message: "Register default value (\(defaultValue)) for key \"\(key)\" failed", error: error)
        }
    }
}

extension BasePersistent: Loggable {
    var category: BinanceLog.Category {
        BinanceLog.Category(String(describing: type(of: self)))
    }
}

// MARK: For basic types

protocol KVStoreBasicType {
    func setSelf(forKey key: String, storage: KVStoreStorage)
    static func getSelf(forKey key: String, storage: KVStoreStorage) -> Self?
}

extension Data: KVStoreBasicType {
    func setSelf(forKey key: String, storage: KVStoreStorage) {
        storage.set(self, forKey: key)
    }

    static func getSelf(forKey key: String, storage: KVStoreStorage) -> Self? {
        storage.data(forKey: key)
    }
}

extension Date: KVStoreBasicType {
    func setSelf(forKey key: String, storage: KVStoreStorage) {
        storage.set(self, forKey: key)
    }

    static func getSelf(forKey key: String, storage: KVStoreStorage) -> Self? {
        storage.date(forKey: key)
    }
}

extension String: KVStoreBasicType {
    func setSelf(forKey key: String, storage: KVStoreStorage) {
        storage.set(self, forKey: key)
    }

    static func getSelf(forKey key: String, storage: KVStoreStorage) -> Self? {
        storage.string(forKey: key)
    }
}

extension Bool: KVStoreBasicType {
    func setSelf(forKey key: String, storage: KVStoreStorage) {
        storage.set(self, forKey: key)
    }

    static func getSelf(forKey key: String, storage: KVStoreStorage) -> Self? {
        storage.bool(forKey: key)
    }
}

extension Int: KVStoreBasicType {
    func setSelf(forKey key: String, storage: KVStoreStorage) {
        storage.set(self, forKey: key)
    }

    static func getSelf(forKey key: String, storage: KVStoreStorage) -> Self? {
        storage.integer(forKey: key)
    }
}

extension Double: KVStoreBasicType {
    func setSelf(forKey key: String, storage: KVStoreStorage) {
        storage.set(self, forKey: key)
    }

    static func getSelf(forKey key: String, storage: KVStoreStorage) -> Self? {
        storage.double(forKey: key)
    }
}

extension Float: KVStoreBasicType {
    func setSelf(forKey key: String, storage: KVStoreStorage) {
        storage.set(self, forKey: key)
    }

    static func getSelf(forKey key: String, storage: KVStoreStorage) -> Self? {
        storage.float(forKey: key)
    }
}

// MARK: Optional unwrapping

func deepUnwrap(_ any: Any) -> Any? {
    if let optional = any as? OptionalWrapped {
        return optional.deepUnwrapped
    }
    return any
}
