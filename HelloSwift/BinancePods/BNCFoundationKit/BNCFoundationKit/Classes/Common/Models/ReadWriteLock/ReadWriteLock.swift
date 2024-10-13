//
//  ReadWriteLock.swift
//  BNCFoundationKit
//
//  Created by Danis on 2020/6/9.
//

import Foundation

public class ReadWriteLock {
    private let queue = DispatchQueue(label: "com.binance.rwlock", attributes: .concurrent)

    public init() {}

    public func read<T>(_ handler: () throws -> T) rethrows -> T {
        try queue.sync { () -> T in
            try handler()
        }
    }

    public func write(_ handler: @escaping (() -> Void)) {
        queue.async(flags: .barrier) {
            handler()
        }
    }
}
