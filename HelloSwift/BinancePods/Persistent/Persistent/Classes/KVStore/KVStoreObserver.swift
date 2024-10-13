//
//  QuickPersistentObserver.swift
//  BNCFoundationKit
//
//  Created by ameng.liu on 4/21/21.
//

public protocol KVStoreObserver: Associatable {
    func kvStoreCacheValue(didChangeValue value: Any?, forKey key: String)
}

private var kvStoreCahcedValueDidChangeTokenKey: UInt8 = 0

extension KVStoreObserver {
    private var kvStoreCacheValueDidChangeToken: NSObjectProtocol? {
        get {
            getAssociatedObject(forKey: &kvStoreCahcedValueDidChangeTokenKey)
        } set {
            setAssociatedObject(newValue, forKey: &kvStoreCahcedValueDidChangeTokenKey)
        }
    }

    public func startObservingKVStore(keys: Set<String>? = nil) {
        kvStoreCacheValueDidChangeToken = NotificationCenter.default.addObserver(
            forName: KVStore.cacheValueDidChangeNotificationName,
            object: KVStore.shared,
            queue: .main,
            using: { [weak self] notification in
                guard let self = self else {
                    return
                }

                guard let key = notification.userInfo?["key"] as? String else {
                    return
                }

                // if keys is not exist, it should response all changes
                guard let keys = keys else {
                    return self.kvStoreCacheValue(didChangeValue: notification.userInfo?["value"], forKey: key)
                }

                // if keys exist and not contain the key matching the changed value, just ignore it
                guard keys.contains(key) else {
                    return
                }

                self.kvStoreCacheValue(didChangeValue: notification.userInfo?["value"], forKey: key)
            }
        )
    }

    public func stopObservingKVStore() {
        kvStoreCacheValueDidChangeToken.flatMap {
            NotificationCenter.default.removeObserver(
                $0,
                name: KVStore.cacheValueDidChangeNotificationName,
                object: KVStore.shared
            )
        }
    }
}
