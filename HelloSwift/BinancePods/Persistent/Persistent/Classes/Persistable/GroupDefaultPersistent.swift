//
//  GroupDefaultPersistent.swift
//  BNCFoundationKit
//
//  Created by user on 2021/11/14.
//

import Foundation
import LoggableKit

@propertyWrapper public struct GroupDefaultPersistent<Value: Persistable> {
    let key: String
    var persistent: BasePersistent<Value>

    public init(key: String, defaultValue: Value) {
        self.key = key
        persistent = .init(key: key, defaultValue: defaultValue, storage: KVStore.shared)
    }

    public init<Wrapped>(key: String) where Value == Wrapped? {
        self.init(key: key, defaultValue: nil)
    }

    public init<Wrapped>(key: String, defaultValue: Wrapped) where Value == Wrapped? {
        self.key = key
        persistent = .init(key: key, defaultValue: Wrapped?.none, storage: KVStore.shared)
    }

    public var wrappedValue: Value {
        get {
            do {
                return try getValue()
            } catch {
                log(message: "Get value for key \"\(key)\" failed", error: error)
                return persistent.defaultValue
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
        if let result = UserDefaults.group.value(forKey: key) as? Value.PersistentValue,
           deepUnwrap(result) != nil {
            let resultValue = try Value.decode(result)
            return resultValue
        }
        return try persistent.getValue()
    }

    mutating func setValue(_ value: Value) throws {
        if deepUnwrap(value) == nil {
            persistent.storage.removeObject(forKey: key)
            UserDefaults.group.set(nil, forKey: key)

            return
        }

        let result = try value.encode()
        if deepUnwrap(result) == nil {
            persistent.storage.removeObject(forKey: key)
            UserDefaults.group.set(nil, forKey: key)

            return
        }

        guard let newValue = result as? KVStoreBasicType else {
            throw PersistentError.castFailed
        }
        UserDefaults.group.set(newValue, forKey: key)
        newValue.setSelf(forKey: key, storage: persistent.storage)
    }
}

extension GroupDefaultPersistent: Loggable {
    public var category: BinanceLog.Category {
        BinanceLog.Category(String(describing: type(of: self)))
    }
}
