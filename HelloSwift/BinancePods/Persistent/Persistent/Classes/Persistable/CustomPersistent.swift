// Copyright © 2022 Binance. All rights reserved.

import Foundation

@propertyWrapper public struct CustomPersistent<Value: Persistable> {
    var persistent: BasePersistent<Value>

    public init(key: String, defaultValue: Value, storage: KVStoreStorage) {
        persistent = .init(key: key, defaultValue: defaultValue, storage: storage)
    }

    public init<Wrapped>(key: String, storage: KVStoreStorage) where Value == Wrapped? {
        self.init(key: key, defaultValue: nil, storage: storage)
    }

    public init<Wrapped>(key: String, defaultValue: Wrapped, storage: KVStoreStorage) where Value == Wrapped? {
        persistent = .init(key: key, defaultValue: Wrapped?.none, storage: storage)
    }

    public var wrappedValue: Value {
        get {
            persistent.value
        }
        mutating set {
            persistent.value = newValue
        }
    }
}

extension CustomPersistent {
    public var value: Value {
        get { wrappedValue }
        mutating set { wrappedValue = newValue }
    }
}
