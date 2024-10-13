//
//  YTNotificationDefine.swift
//  HelloSwift
//
//  Created by gtc on 2021/7/1.
//

import Foundation

public enum NotificationDefine: String {
    case LoginSuccess
    case logoutSuccess
    
    public func notifactionName() -> Notification.Name {
        return Notification.Name("notif_name_" + rawValue)
    }
}
