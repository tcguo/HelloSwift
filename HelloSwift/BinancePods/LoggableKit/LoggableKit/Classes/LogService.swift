//
//  LogService.swift
//  LoggableKit
//
//  Created by edmond on 2021/8/17.
//

public protocol LogService {
    static func loggerInit()
    static func log(level: UInt, message: String)
}

@objc
public protocol ObjcLogService: AnyObject {
    static func bncLog(level: UInt, message: String)
}
