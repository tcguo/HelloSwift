//
//  UserDefaults+Extensions.swift
//  Binance
//
//  Created by 仇弘扬 on 2019/4/2.
//  Copyright © 2019 Binance. All rights reserved.
//

import Foundation

extension UserDefaults {
    public static var groupID: String {
        guard var bundleID = Bundle.main.bundleIdentifier else {
            return ""
        }
        let suffixes = [".Share", ".SiriIntents", ".WidgetIntent", ".NewWidget", ".Widget", ".Broadcast"]
        for suffix in suffixes {
            if let range = bundleID.range(of: suffix) {
                bundleID.removeSubrange(range)
            }
        }
        return "group." + bundleID
    }

    public static let group = UserDefaults(suiteName: groupID)!
}
