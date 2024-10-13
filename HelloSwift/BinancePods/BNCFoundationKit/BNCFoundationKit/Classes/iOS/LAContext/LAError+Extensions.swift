//
//  LAError+Extensions.swift
//  Binance
//
//  Created by Daniel Clelland on 16/04/19.
//  Copyright © 2019 Binance. All rights reserved.
//

import LocalAuthentication
import PromiseKit

extension LAError: CancellableError {
    public var isCancelled: Bool {
        switch code {
        case LAError.Code.userCancel:
            return true
        default:
            return false
        }
    }

    public var isNotAvailable: Bool {
        code == .biometryNotAvailable
    }

    public var isNotEnrolled: Bool {
        code == .biometryNotEnrolled
    }
}
