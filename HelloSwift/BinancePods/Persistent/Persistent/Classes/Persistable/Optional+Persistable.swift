//
//  Optional+Persistable.swift
//  BNCFoundationKit
//
//  Created by Ivan Nosov on 11.11.2021.
//

// For Optional deep unwrap
extension Optional: Persistable where Wrapped: Persistable {
    public static func decode(_ value: Wrapped.PersistentValue?) throws -> Wrapped? {
        if let value = value {
            return try Wrapped.decode(value)
        } else {
            return Optional.none
        }
    }

    public func encode() throws -> Wrapped.PersistentValue? {
        if let value = self {
            return try value.encode()
        } else {
            return Wrapped.PersistentValue?.none
        }
    }

    public typealias PersistentValue = Wrapped.PersistentValue?
}

protocol OptionalWrapped {
    var deepUnwrapped: Any? { get }
    static var wrappedType: Any.Type { get }
}

extension Optional: OptionalWrapped {
    var deepUnwrapped: Any? {
        if let wrapped = self {
            return deepUnwrap(wrapped)
        }
        return nil
    }

    static var wrappedType: Any.Type {
        Wrapped.self
    }
}
