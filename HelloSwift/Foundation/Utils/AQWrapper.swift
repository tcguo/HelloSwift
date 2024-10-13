//
//  AQWarper.swift
//  IronMan
//
//  Created by chenwei on 2021/1/13.
//

import UIKit

/// Wrapper for Kingfisher compatible types. This type provides an extension point for
/// connivence methods in Kingfisher.
public struct AQWrapper<Base> {
    public let base: Base
    public let baseSelf: Self.Type
    public init(_ base: Base) {
        self.base = base
        baseSelf = Self.self
        
    }
}

/// Represents an object type that is compatible with AQWrapper. You can use `aq` property to get a
public protocol AQCompatible: AnyObject {}
// swiftlint:disable identifier_name
public extension AQCompatible {
    var aq: AQWrapper<Self> {
        get { return AQWrapper(self) }
        set {}
    }

    static var aq: AQWrapper<Self>.Type {
        get { return AQWrapper<Self>.self }
        set {}
    }
}

// swiftlint:enable identifier_name
