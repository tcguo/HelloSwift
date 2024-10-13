//
//  Persistent.swift
//  Binance
//
//  Created by Daniel Clelland on 23/09/18.
//  Copyright © 2018 Binance. All rights reserved.
//

/** PropertyWrapper for Persistent

 * @Persistent(key: "123", defaultValue: 0)
 *   public var someInt: Int

 * @Persistent(rawKey: SomeEnum.someKey, defaultValue: 0)
 *  public var someInt: Int

 * @Persistent(rawKey: SomeEnum.someKey)
 * public var someInt: Int?

 * @Persistent(rawKey: SomeEnum.someKey, defaultValue: 0)
 * public var someInt: Int?

 * @Persistent(rawKey: SomeEnum.someKey, defaultValue: nil)
 * public var someInt: Int?
 */

@propertyWrapper public struct Persistent<Value: Persistable> {
    var persistent: BasePersistent<Value>

    public init(key: String, defaultValue: Value) {
        persistent = .init(key: key, defaultValue: defaultValue, storage: KVStore.shared)
    }

    public init<Wrapped>(key: String) where Value == Wrapped? {
        self.init(key: key, defaultValue: nil)
    }

    public init<Wrapped>(key: String, defaultValue: Wrapped) where Value == Wrapped? {
        persistent = .init(key: key, defaultValue: Wrapped?.none, storage: KVStore.shared)
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

extension Persistent {
    public var value: Value {
        get { wrappedValue }
        mutating set { wrappedValue = newValue }
    }
}
