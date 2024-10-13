//
//  Optional+Extensions.swift
//  BNCFoundationKit
//
//  Created by Sergey Maslov on 19.11.2020.
//

extension Optional where Wrapped == String {
    /// Prefer using this property rather than nil coalescing operator to decrease compile time
    /// Example:
    /// yourOptionalString.orEmpty  [Compiles Faster]
    /// yourOptionalString ?? ""
    public var orEmpty: String {
        self ?? .empty
    }

    /// Prefer using this property rather than nil coalescing operator with conversion to Int
    /// Example:
    /// yourOptionalString.toIntOrZero  [Compiles More Faster]
    /// Int(yourOptionalString ?? "0") ?? 0
    public var toIntOrZero: Int {
        self?.toIntOrZero ?? 0
    }

    /// Prefer using this property rather than nil coalescing operator with condition isEmpty
    /// Example:
    /// yourOptionalString.isNilOrEmpty  [Compiles Faster]
    /// (yourOptionalString ?? "").isEmpty
    public var isNilOrEmpty: Bool {
        orEmpty.isEmpty
    }
}
