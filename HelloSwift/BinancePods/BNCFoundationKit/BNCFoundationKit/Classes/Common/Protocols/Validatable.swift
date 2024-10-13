//
//  Validatable.swift
//  Binance
//
//  Created by Daniel Clelland on 1/11/18.
//  Copyright © 2018 Binance. All rights reserved.
//

import Foundation

public protocol Validatable {
    associatedtype ValidationError: Error

    func validate() throws
}

extension Validatable {
    public var isValid: Bool {
        do {
            try validate()
            return true
        } catch {
            return false
        }
    }

    public var error: ValidationError? {
        do {
            try validate()
            return nil
        } catch let error as ValidationError {
            return error
        } catch {
            fatalError("Validatable threw a non-compatible validation error: \(error)")
        }
    }
}
