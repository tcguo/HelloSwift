//
//  UNAuthorizationStatus+Extensions.swift
//  Binance
//
//  Created by Daniel Clelland on 26/03/19.
//  Copyright © 2019 Binance. All rights reserved.
//

import Foundation
import UserNotifications

extension UNAuthorizationStatus {
    public var isAuthorized: Bool {
        switch self {
        case .notDetermined:
            return false
        case .denied:
            return false
        case .authorized:
            return true
        case .provisional:
            return true
        case .ephemeral:
            fallthrough
        @unknown default:
            return false
        }
    }
}
