//
//  WKWebsiteDataStore+Extensions.swift
//  BNCFoundationKit
//
//  Created by Cocoa Zhou on 2021/7/22.
//

#if !os(watchOS)
import WebKit

extension WKWebsiteDataStore {
    public func removeAllData() {
        let websiteDataTypes = WKWebsiteDataStore.allWebsiteDataTypes()
        let date = Date(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes, modifiedSince: date, completionHandler: {})
    }
}
#endif
