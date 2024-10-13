//
//  LAContext+Extensions.swift
//  Binance
//
//  Created by Daniel Clelland on 29/11/18.
//  Copyright © 2018 Binance. All rights reserved.
//

import LocalAuthentication
import PromiseKit

public enum BiometricAuthenticationOptions {
    case none
    case touchID
    case faceID
}

extension LAContext {
    public func canEvaluatePolicy(_ policy: LAPolicy) -> Promise<Void> {
        Promise { resolver in
            var error: NSError?
            switch (canEvaluatePolicy(policy, error: &error), error) {
            case (true, .none):
                resolver.fulfill(())
            case (false, let .some(error)):
                resolver.reject(error)
            default:
                throw PMKError.invalidCallingConvention
            }
        }
    }

    public func evaluatePolicy(_ policy: LAPolicy, localizedReason: String) -> Promise<Void> {
        Promise { resolver in
            evaluatePolicy(policy, localizedReason: localizedReason) { result, error in
                switch (result, error) {
                case (true, .none):
                    resolver.fulfill(())
                case (false, let .some(error)):
                    resolver.reject(error)
                default:
                    resolver.reject(PMKError.invalidCallingConvention)
                }
            }
        }
    }
}

extension LAContext {
    public func getBiometricAuthenticationOptions() -> Promise<BiometricAuthenticationOptions> {
        canEvaluatePolicy(.deviceOwnerAuthentication).map {
            switch self.biometryType {
            case .none:
                return .none
            case .touchID:
                return .touchID
            case .faceID:
                return .faceID
            @unknown default:
                return .none
            }
        }
    }

    public func getAuthenticationOptions() -> Bool {
        canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
    }
}
