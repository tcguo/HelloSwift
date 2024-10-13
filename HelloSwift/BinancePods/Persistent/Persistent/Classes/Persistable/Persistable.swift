//
//  DefaultsPersistable.swift
//  Binance
//
//  Created by Daniel Clelland on 23/09/18.
//  Copyright © 2018 Binance. All rights reserved.
//

import Foundation

public protocol Persistable {
    associatedtype PersistentValue

    static func decode(_ value: PersistentValue) throws -> Self

    func encode() throws -> PersistentValue
}

extension Persistable where Self == PersistentValue {
    public static func decode(_ value: PersistentValue) throws -> Self {
        value
    }

    public func encode() throws -> PersistentValue {
        self
    }
}

extension Persistable where Self: RawRepresentable {
    public static func decode(_ value: RawValue) throws -> Self {
        guard let result = Self(rawValue: value) else {
            throw PersistentError.decodeFailed(
                reason: "Decode RawRepresentable value of type \(self) failed, invalid raw value: \(value)"
            )
        }

        return result
    }

    public func encode() throws -> RawValue {
        rawValue
    }
}

extension Persistable where Self: Codable {
    public static func decode(_ value: Data) throws -> Self {
        try JSONDecoder().decode(Self.self, from: value)
    }

    public func encode() throws -> Data {
        try JSONEncoder().encode(self)
    }
}

extension RawRepresentable where Self: Persistable {
    public typealias PersistentValue = RawValue
}

extension Bool: Persistable {
    public typealias PersistentValue = Bool
}

extension Int: Persistable {
    public typealias PersistentValue = Int
}

extension Float: Persistable {
    public typealias PersistentValue = Float
}

extension Double: Persistable {
    public typealias PersistentValue = Double
}

extension String: Persistable {
    public typealias PersistentValue = String
}

extension Date: Persistable {
    public typealias PersistentValue = Date
}

// Decimal should convert from String. https://forums.swift.org/t/parsing-decimal-values-from-json
extension Decimal: Persistable {
    public static func decode(_ value: String) throws -> Self {
        guard let result = Decimal(string: value) else {
            throw PersistentError.decodeFailed(
                reason: "Decode decimal value of type \(self) failed, invalid decimal value: \(value)"
            )
        }
        return result
    }

    public func encode() throws -> String {
        description
    }
}

extension Array: Persistable where Element: Persistable {
    public static func decode(_ value: Data) throws -> Self {
        let data = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(value)
        if let array = data as? [Element] {
            return array
        }
        if let arrayData = data as? [Element.PersistentValue] {
            return try arrayData.map {
                try Element.decode($0)
            }
        }
        throw PersistentError.decodeFailed(
            reason: "Decode Array value of type \(Element.self) failed, invalid value: \(value)"
        )
    }

    public func encode() throws -> Data {
        let array = try map {
            try $0.encode()
        }
        return try NSKeyedArchiver.archivedData(withRootObject: array, requiringSecureCoding: false)
    }
}

extension Dictionary: Persistable where Value: Persistable {
    public static func decode(_ value: Data) throws -> Self {
        let data = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(value)
        if let dict = data as? [Key: Value] {
            return dict
        }
        if let dictData = data as? [Key: Value.PersistentValue] {
            return try dictData.mapValues {
                try Value.decode($0)
            }
        }
        throw PersistentError.decodeFailed(
            reason: "Decode Dictionary value of type \(Value.self) failed, invalid value: \(value)"
        )
    }

    public func encode() throws -> Data {
        let dict = try mapValues {
            try $0.encode()
        }
        return try NSKeyedArchiver.archivedData(withRootObject: dict, requiringSecureCoding: false)
    }
}
