//
//  UNUserNotificationCenter+Extensions.swift
//  Binance
//
//  Created by Daniel Clelland on 6/01/19.
//  Copyright © 2019 Binance. All rights reserved.
//

import PromiseKit
import UserNotifications
import UIKit

extension UNUserNotificationCenter {
    public func getNotificationSettings() -> Guarantee<UNNotificationSettings> {
        Guarantee { resolver in
            getNotificationSettings { settings in
                resolver(settings)
            }
        }
    }

    public func registerForPushNotifications(
        options: UNAuthorizationOptions = [.alert, .sound, .badge]
    ) -> Promise<Void> {
        requestAuthorization(options: options).done { granted in
            guard granted else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }

    public func requestAuthorization(
        options: UNAuthorizationOptions = [.alert, .sound, .badge]
    ) -> Promise<Bool> {
        Promise { resolver in
            requestAuthorization(options: options) { granted, error in
                if let error = error {
                    resolver.reject(error)
                } else {
                    resolver.fulfill(granted)
                }
            }
        }
    }
}
