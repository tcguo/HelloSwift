//
//  AppSettings.swift
//  HelloSwift
//
//  Created by gtc on 2021/7/1.
//

import Foundation

public enum AppSettings {
    
    /// 内嵌类型
    public enum App {
        public static let productName = "rawpic"
        public static let appId = "60"
        public static let appReportSid = "rawpic.api"
        public static let visitorSid = "rawpic.api.visitor"
    }
    
    public enum Bugly {
        private static let debug = ""
        private static let release = ""
        public static let appId = true ? debug : release
    }
}


