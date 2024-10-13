//
//  Dictionary+Extensions.swift
//  Binance
//
//  Created by 洪鑫 on 2019/11/28.
//  Copyright © 2019 Binance. All rights reserved.
//

import Foundation

extension Dictionary where Key == AnyHashable, Value == Any {
    public static func += (lhs: inout [Key: Value], rhs: [Key: Value]) {
        rhs.forEach { lhs[$0] = $1 }
    }

    public static func + (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        var result = lhs
        rhs.forEach { result[$0] = $1 }
        return result
    }
}
