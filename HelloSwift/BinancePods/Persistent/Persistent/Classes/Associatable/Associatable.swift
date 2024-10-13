//
//  Associatable.swift
//  Binance
//
//  Created by Daniel Clelland on 8/03/19.
//  Copyright © 2019 Binance. All rights reserved.
//

import Foundation

public protocol Associatable: AnyObject {}

extension Associatable {
    public func getAssociatedObject<T>(forKey key: UnsafeRawPointer) -> T? {
        objc_getAssociatedObject(self, key) as? T
    }

    public func setAssociatedObject<T>(
        _ value: T?,
        forKey key: UnsafeRawPointer,
        policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC
    ) {
        objc_setAssociatedObject(self, key, value, policy)
    }
}
