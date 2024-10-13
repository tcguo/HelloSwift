//
//  BinanceLogFilter.swift
//  LoggableKit
//
//  Created by Sergey Maslov on 23.10.2020.
//  Copyright © 2020 Binance. All rights reserved.
//

public enum BinanceLogFilter {
    case all
    case none
    case including(categories: [BinanceLog.Category])
    case excluding(categories: [BinanceLog.Category])

    public static let onlyUI = BinanceLogFilter.including(categories: uiCategories.map(BinanceLog.Category.init))
    public static let hideUI = BinanceLogFilter.excluding(categories: uiCategories.map(BinanceLog.Category.init))

    public static let onlyNetworking = BinanceLogFilter.including(
        categories: networkingCategories.map(BinanceLog.Category.init)
    )
    public static let hideNetworking = BinanceLogFilter.excluding(
        categories: networkingCategories.map(BinanceLog.Category.init)
    )

    public static func only(category name: String) -> BinanceLogFilter {
        BinanceLogFilter.including(categories: [BinanceLog.Category(name)])
    }

    public static let networkingCategories = [
        "APM-Http",
        "HTTP",
        "Client",
        "WSStream",
        "Firebase/Performance",
        "SessionDependentTask",
        "C2CFeed",
        "Feed"
    ]
    public static let uiCategories = ["First Frame", "Storyboard", "LifeCycle"]
}

extension BinanceLogFilter {
    func needToPrint(category: BinanceLog.Category) -> Bool {
        switch self {
        case .all:
            return true
        case .none:
            return false
        case let .including(categories: categories):
            return categories.contains { $0.name == category.name }
        case let .excluding(categories: categories):
            return !categories.contains { $0.name == category.name }
        }
    }
}
