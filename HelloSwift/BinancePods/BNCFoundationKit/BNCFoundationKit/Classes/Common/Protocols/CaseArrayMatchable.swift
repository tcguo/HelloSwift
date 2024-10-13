//
//  CaseArrayMatchable.swift
//  Alamofire
//
//  Created by Alex Lin on 2021/6/7.
//

import Foundation

public protocol CaseArrayMatchable where Self: Equatable {
    static func ~= (array: [Self], value: Self) -> Bool
}

extension CaseArrayMatchable {
    public static func ~= (array: [Self], value: Self) -> Bool {
        array.contains(value)
    }
}
