//
//  NetworkBaseData.swift
//  HelloSwift
//
//  Created by gtc on 2021/8/5.
//

import Foundation

struct NetworkBaseData<T: Codable>: Codable {
    var status: Int
    var message: String
    var serverTm: UInt64
    var data: T?
}
