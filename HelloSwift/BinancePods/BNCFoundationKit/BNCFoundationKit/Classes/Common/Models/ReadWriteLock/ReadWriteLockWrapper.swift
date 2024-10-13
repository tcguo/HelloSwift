//
//  ReadWriteLockWrapper.swift
//  Monitor
//
//  Created by Harry Duan on 2020/9/2.
//

// swiftlint:disable type_name

import Foundation

/**
 * Add atomicity to the attributes of Class
 *
 * ```swift
 * class Demo {
 *   @readWriteAtomic public var x = 1
 * }
 * ```
 *
 * You can use the `@readWriteAtomic` property wrapper to wrap propery in your class.
 */
@propertyWrapper
public final class readWriteAtomic<T> {
    private var value: T

    private var lock = ReadWriteLock()

    public init(wrappedValue value: T) {
        self.value = value
    }

    public var wrappedValue: T {
        get { getValue() }
        set { setValue(newValue: newValue) }
    }

    func getValue() -> T {
        lock.read { value }
    }

    func setValue(newValue: T) {
        lock.write { [weak self] in
            self?.value = newValue
        }
    }
}

@propertyWrapper
public final class lockAtomic<T> {
    private var value: T
    private let lock = NSLock()

    public init(wrappedValue value: T) {
        self.value = value
    }

    public var wrappedValue: T {
        get { getValue() }
        set { setValue(newValue: newValue) }
    }

    func getValue() -> T {
        lock.lock()
        defer { lock.unlock() }

        return value
    }

    func setValue(newValue: T) {
        lock.lock()
        defer { lock.unlock() }

        value = newValue
    }
}

/**
 * This extension can make the static property atomic.
 *
 * ```swift
 * class Foo {
 *   private static let adaptorsLock = NSLock()
 *
 *   private static var _bar: Int = 0
 *   public static var bar: Int {
 *     get {
 *       adaptorsLock.withCriticalSection { _bar }
 *     }
 *     set {
 *       adaptorsLock.withCriticalSection { _bar = newValue }
 *     }
 *   }
 *
 * }
 * ```
 */
extension NSLocking {
    public func withCriticalSection<T>(block: () throws -> T) rethrows -> T {
        lock()
        defer { unlock() }
        return try block()
    }
}
