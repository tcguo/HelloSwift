//
//  NotificationName+Extensions.swift
//  Binance
//
//  Created by 洪鑫 on 2019/9/25.
//  Copyright © 2019 Binance. All rights reserved.
//

import Foundation

public enum NotificationType: String {
    case fundsFilterAssetsAreHiddenDidChange
    case c2cChatMessagesMarkRead
    case c2cAppModeDidChange
    case c2cMakeOrderSuccess
    case c2cNeedUpdateTradeDropMenubar
    case c2cReloadNewUserOnboarding
    case c2cUserBlockStateDidChanged
    case c2cGuidanceFlotViewDisplyChanged
}

extension Notification.Name {
    public init(_ type: NotificationType) {
        self = Notification.Name(type.rawValue)
    }
}
