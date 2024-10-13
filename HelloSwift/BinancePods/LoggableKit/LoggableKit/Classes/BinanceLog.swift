//
//  BinanceLog.swift
//  Binance
//
//  Created by Binance on 7/01/18.
//

import Foundation
import os

public enum BinanceLogLevel: UInt {
    case loganInternal = 1 // This type is occupied by Logan
    case warning = 2
    case custom = 3
    case netwrok = 4
    case action = 5
}

// MARK: - public  BinanceLog Category
extension BinanceLog.Category {
    public static let http = BinanceLog.Category("HTTP")
    public static let sensors = BinanceLog.Category("Sensors")
}

public struct BinanceLog {
    static var logQueue = DispatchQueue(label: "BinanceLogQueue", qos: .background, target: DispatchQueue.global())
    public static var logs: [String] = []

    public struct Category {
        public let name: String

        public init(_ name: String) {
            self.name = name
        }
    }

    fileprivate static var hasInitLogan = false

    fileprivate static var logService: LogService?

    internal static var loganQueue = DispatchQueue(label: "Binance.Logan.queue", attributes: .concurrent)

    public static var logFilter: BinanceLogFilter = .all

    public static let main = BinanceLog()

    public static func configLogger() {
        if let logger = main as? LogService {
            loganQueue.sync(flags: .barrier) {
                type(of: logger).loggerInit()
            }
            hasInitLogan = true
        }
    }
}

extension BinanceLog {
    fileprivate static func safeLog(_ level: UInt, _ message: String) {
        if let logger = main as? LogService, hasInitLogan {
            loganQueue.sync(flags: .barrier) {
                type(of: logger).log(level: level, message: message)
            }
        }
    }

    public static func log(category: BinanceLog.Category, event: [String: Any]) {
        BinanceLog.log(category: category, message: event.toJSONString() ?? "")
    }

    public static func log(category: BinanceLog.Category, message: String) {
        let level = configLogType(category: category)
        let msg = "[\(category.name)] \(message)"
        safeLog(level.rawValue, msg)

        guard logFilter.needToPrint(category: category) else { return }

        #if DEBUG
            if #available(OSX 10.12, *) {
                os_log("%{public}@", log: OSLog(subsystem: "Binance", category: category.name), type: .default, message)
            } else {
                // swiftlint:disable:next disable_print
                print(msg)
            }

            if category.name == "HTTP" {
                logQueue.async {
                    logs.append(msg)
                    if logs.count % 100 == 0 {
                        logs.removeFirst(logs.count / 2)
                    }
                }
            }
        #endif
    }

    public static func log(category: BinanceLog.Category, message: String, error: Error) {
        let msg = "[\(category.name)] \(message), \(error)"
        safeLog(BinanceLogLevel.warning.rawValue, msg)

        guard logFilter.needToPrint(category: category) else { return }

        #if DEBUG
            if #available(OSX 10.12, *) {
                os_log(
                    "%{public}@ %{public}@",
                    log: OSLog(subsystem: "Binance", category: category.name),
                    type: .error,
                    message,
                    String(describing: error)
                )
            } else {
                // swiftlint:disable:next disable_print
                print(msg)
            }
        #endif
    }

    private static func configLogType(category: BinanceLog.Category) -> BinanceLogLevel {
        var level = BinanceLogLevel.custom
        switch category.name {
        case BinanceLog.Category.http.name:
            level = .netwrok
        case BinanceLog.Category.sensors.name:
            level = .action
        default:
            level = .custom
        }
        return level
    }
}

public func log(category: BinanceLog.Category, message: String) {
    BinanceLog.log(category: category, message: message)
}

public func log(category: BinanceLog.Category, message: String, error: Error) {
    BinanceLog.log(category: category, message: message, error: error)
}

extension NSObject: ObjcLogService {
    public static func bncLog(level: UInt, message: String) {
        BinanceLog.safeLog(level, message)
    }
}
