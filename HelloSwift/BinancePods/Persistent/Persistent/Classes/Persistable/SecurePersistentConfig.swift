//
//  SecurePersistentConfig.swift
//  BNCFoundationKit
//
//  Created by Ivan Nosov on 11.11.2021.
//

import Foundation

public protocol SecurePersistentConfigCustomable {
    func provideMigratable() -> SecurePersistentConfig
    func provideNonMigratable() -> SecurePersistentConfig
    func provideForFingerprint() -> SecurePersistentConfig
}

public struct SecurePersistentConfig {
    public var secureStorage: KVStoreStorage!
    public var legacyStorage: KVStoreStorage?
    public var removeLegacyValue: Bool = true

    public init(
        secureStorage: KVStoreStorage,
        legacyStorage: KVStoreStorage?,
        removeLegacyValue: Bool = true
    ) {
        self.secureStorage = secureStorage
        self.legacyStorage = legacyStorage
        self.removeLegacyValue = removeLegacyValue
    }

    // only used for SecurePersistentConfigCustomable accessing
    fileprivate init() {}
}

extension SecurePersistentConfig {
    public static let migratable: Self = {
        guard var customable = SecurePersistentConfig() as? SecurePersistentConfigCustomable else {
            return Self.default
        }
        return customable.provideMigratable()
    }()

    public static let nonMigratable: Self = {
        guard var customable = SecurePersistentConfig() as? SecurePersistentConfigCustomable else {
            return Self.default
        }
        return customable.provideNonMigratable()
    }()

    public static let forFingerprint: Self = {
        guard var customable = SecurePersistentConfig() as? SecurePersistentConfigCustomable else {
            return Self.default
        }
        return customable.provideForFingerprint()
    }()

    private static let `default`: SecurePersistentConfig = .init(
        secureStorage: KVStore.shared,
        legacyStorage: KVStore.shared
    )
}
