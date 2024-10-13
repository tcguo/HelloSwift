//
//  UserInfoModel.swift
//  HelloSwift
//
//  Created by gtc on 2021/8/5.
//

import Foundation

struct UserInfoModel: Codable {
    var token: String = ""
    var userId: String =  ""
    var scores: [Int]?
}
