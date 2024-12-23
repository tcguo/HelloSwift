//
//  MobileProvision.swift
//  Binance
//
//  Created by Rocker on 2020/11/9.
//  Copyright © 2020 Binance. All rights reserved.
//
import Foundation

/* Decode mobileprovision plist file
 Usage:
 1. To get mobileprovision data as embedded in your app:
 MobileProvision.read()
 2. To get mobile provision data from a file on disk:
 MobileProvision.read(from: "my.mobileprovision")
 */

public struct MobileProvision: Decodable {
    public var name: String
    public var appIDName: String
    public var platform: [String]
    public var isXcodeManaged: Bool? = false
    public var creationDate: Date
    public var expirationDate: Date
    public var entitlements: Entitlements

    private enum CodingKeys: String, CodingKey {
        case name = "Name"
        case appIDName = "AppIDName"
        case platform = "Platform"
        case isXcodeManaged = "IsXcodeManaged"
        case creationDate = "CreationDate"
        case expirationDate = "ExpirationDate"
        case entitlements = "Entitlements"
    }

    // decode entitlements informations
    public struct Entitlements: Decodable {
        public let keychainAccessGroups: [String]
        public let getTaskAllow: Bool
        public let apsEnvironment: Environment
        public let teamIdentifier: String
        public let appGroups: [String]

        private enum CodingKeys: String, CodingKey {
            case keychainAccessGroups = "keychain-access-groups"
            case getTaskAllow = "get-task-allow"
            case apsEnvironment = "aps-environment"
            case teamIdentifier = "com.apple.developer.team-identifier"
            case appGroups = "com.apple.security.application-groups"
        }

        public enum Environment: String, Decodable {
            case development, production, disabled
        }

        init(
            keychainAccessGroups: [String],
            getTaskAllow: Bool,
            apsEnvironment: Environment,
            teamIdentifier: String,
            appGroups: [String]
        ) {
            self.keychainAccessGroups = keychainAccessGroups
            self.getTaskAllow = getTaskAllow
            self.apsEnvironment = apsEnvironment
            self.teamIdentifier = teamIdentifier
            self.appGroups = appGroups
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let keychainAccessGroups: [String] = (
                try? container
                    .decode([String].self, forKey: .keychainAccessGroups)
            ) ??
                []
            let getTaskAllow: Bool = (try? container.decode(Bool.self, forKey: .getTaskAllow)) ?? false
            let apsEnvironment: Environment = (try? container.decode(Environment.self, forKey: .apsEnvironment)) ??
                .disabled
            let teamIdentifier: String = (try? container.decode(String.self, forKey: .teamIdentifier)) ?? ""
            let appGroups: [String] = (
                try? container
                    .decode([String].self, forKey: .appGroups)
            ) ?? []

            self.init(
                keychainAccessGroups: keychainAccessGroups,
                getTaskAllow: getTaskAllow,
                apsEnvironment: apsEnvironment,
                teamIdentifier: teamIdentifier,
                appGroups: appGroups
            )
        }
    }
}

// Factory methods
extension MobileProvision {
    // Read mobileprovision file embedded in app.
    public static func read(bundle: Bundle = .main) -> MobileProvision? {
        let profilePath: String? = bundle.path(forResource: "embedded", ofType: "mobileprovision")
        guard let path = profilePath else { return nil }
        return read(from: path)
    }

    // Read a .mobileprovision file on disk
    public static func read(from profilePath: String) -> MobileProvision? {
        guard let plistDataString = try? NSString(
            contentsOfFile: profilePath,
            encoding: String.Encoding.isoLatin1.rawValue
        ) else { return nil }

        // Skip binary part at the start of the mobile provisionning profile
        let scanner = Scanner(string: plistDataString as String)
        guard scanner.scanUpTo("<plist", into: nil) != false else { return nil }

        // ... and extract plist until end of plist payload (skip the end binary part.
        var extractedPlist: NSString?
        guard scanner.scanUpTo("</plist>", into: &extractedPlist) != false else { return nil }

        guard let plist = extractedPlist?.appending("</plist>").data(using: .isoLatin1) else { return nil }
        let decoder = PropertyListDecoder()
        do {
            let provision = try decoder.decode(MobileProvision.self, from: plist)
            return provision
        } catch {
            return nil
        }
    }
}
