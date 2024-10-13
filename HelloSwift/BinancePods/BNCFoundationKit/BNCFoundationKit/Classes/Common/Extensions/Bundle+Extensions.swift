//
//  Bundle+Extensions.swift
//  Binance
//
//  Created by Daniel Clelland on 22/01/19.
//  Copyright © 2019 Binance. All rights reserved.
//

import Foundation

extension Bundle {
    public func object<T>(forKey key: String) -> T? {
        object(forInfoDictionaryKey: key) as? T
    }
}

extension Bundle {
    public var version: String? {
        guard let shortVersionString = shortVersionString else {
            return nil
        }

        return "v" + shortVersionString
    }

    public var shortVersionString: String? {
        object(forKey: "CFBundleShortVersionString")
    }

    public var build: String? {
        guard let versionString: String = object(forKey: "CFBundleVersion") else {
            return nil
        }

        return "build " + versionString
    }
}

extension Bundle {
    /// return all urlSchemes in info.plist
    public static var urlSchemes: [String] {
        var urlSchemes: [String] = []
        if let urlTypes = Bundle.main.object(forInfoDictionaryKey: "CFBundleURLTypes") as? [[String: Any]] {
            for type in urlTypes {
                if let schemes = type["CFBundleURLSchemes"] as? [String] {
                    urlSchemes.append(contentsOf: schemes.map { $0.lowercased() })
                }
            }
        }
        return urlSchemes
    }

    /// return usable urlSchemes in info.plist. Filter out some known occupied schemes
    public static var usableUrlSchemes: [String] {
        let schemes: [String] = Bundle.urlSchemes
        let usableUrlSchemes = schemes.filter { scheme -> Bool in
            !(scheme.lowercased() == "binance")
        }
        return usableUrlSchemes
    }
}
