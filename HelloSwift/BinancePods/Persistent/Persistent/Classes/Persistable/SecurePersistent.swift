//
//  SecurePersistent.swift
//  BNCFoundationKit
//
//  Created by Ivan Nosov on 11.11.2021.
//

import LoggableKit

@propertyWrapper public struct SecurePersistent<Value: Persistable> {
    var persistent: BasePersistent<Value>

    public init(
        config: SecurePersistentConfig = .migratable,
        key: String,
        defaultValue: Value
    ) {
        // get value from legacy storage
        let initialValue = Self.getLegacyValue(config: config, key: key, defaultValue: defaultValue) ?? defaultValue
        // initialize secure persistent
        persistent = .init(key: Self.secureKey(for: key), defaultValue: initialValue, storage: config.secureStorage)
        // remove legacy value if needed
        Self.removeLegacyValue(config: config, key: key)
    }

    public init<Wrapped>(
        config: SecurePersistentConfig = .migratable,
        key: String
    ) where Value == Wrapped? {
        self.init(config: config, key: key, defaultValue: nil)
    }

    public init<Wrapped>(
        config: SecurePersistentConfig = .migratable,
        key: String,
        defaultValue: Wrapped
    ) where Value == Wrapped? {
        // figure out the default value
        let noneValue = Wrapped?.none
        // get value from legacy storage
        let initialValue = Self.getLegacyValue(config: config, key: key, defaultValue: noneValue) ?? noneValue
        // initialize secure persistent
        persistent = .init(key: Self.secureKey(for: key), defaultValue: initialValue, storage: KVStore.shared)
        // remove legacy value if needed
        Self.removeLegacyValue(config: config, key: key)
    }

    public var wrappedValue: Value {
        get {
            persistent.value
        }
        mutating set {
            persistent.value = newValue
        }
    }

    static func getLegacyValue(
        config: SecurePersistentConfig,
        key: String,
        defaultValue: Value
    ) -> Value? {
        guard let legacyStorage = config.legacyStorage, legacyStorage.contains(key: key) else {
            return nil
        }
        return BasePersistent<Value>(key: key, defaultValue: defaultValue, storage: legacyStorage).value
    }

    static func removeLegacyValue(
        config: SecurePersistentConfig,
        key: String
    ) {
        if config.removeLegacyValue, let legacyStorage = config.legacyStorage {
            legacyStorage.removeObject(forKey: key)
        }
    }

    private static func secureKey(for key: String) -> String {
        // This is required for safe migration to the new place,
        // in case if legacyStorage and secureStorage is the same instance.
        "\(key)_SecurePersistent"
    }
}

extension SecurePersistent {
    public var value: Value {
        get { wrappedValue }
        mutating set { wrappedValue = newValue }
    }
}
