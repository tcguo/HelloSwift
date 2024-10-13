//
//  MoyaRxSwift+Map.swift
//  HelloSwift
//
//  Created by gtc on 2021/8/5.
//

import Foundation
import Alamofire
import Moya
import RxSwift
import AnyCodable

public enum AQApiError: Swift.Error {
    case serverError(statusCode: Int, msg: String?)
    case jsonMapping(Response)
    case objectEmpty
}

private struct NetBaseData<T: Codable>: Codable {
    var status: Int
    var message: String?
    var data: T?
}

private let kAqServerStatusSuccessCode: Int = 0

public extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    func mapObject<T: Codable>(type: T.Type, using decoder: JSONDecoder = JSONDecoder()) -> Single<T?> {
        return map { response in
            return try response.mapObject(type: type, using: decoder)
        }
    }

    func mapDataJson(decoder: JSONDecoder = JSONDecoder()) -> Single<[String: Any]> {
        return map { response in
            return try response.mapDataJson(decoder: decoder)
        }
    }
}

public extension ObservableType where Element == Response {
    func mapObject<T: Codable>(type: T.Type, using decoder: JSONDecoder = JSONDecoder()) -> Observable<T?> {
        return map { response in
            return try response.mapObject(type: type, using: decoder)
        }
    }

    func mapDataJson(decoder: JSONDecoder = JSONDecoder()) -> Observable<[String: Any]> {
        return map { response in
            return try response.mapDataJson(decoder: decoder)
        }
    }
}

public extension Moya.Response {
    func mapObject<T: Codable>(type _: T.Type, using decoder: JSONDecoder = JSONDecoder()) throws -> T? {
        do {
            let rootModel = try map(NetBaseData<T>.self, using: decoder)
            if rootModel.status != kAqServerStatusSuccessCode {
                throw AQApiError.serverError(statusCode: rootModel.status, msg: rootModel.message)
            }
            return rootModel.data
        } catch {
            throw error
        }
    }

    func mapDataJson(decoder: JSONDecoder = JSONDecoder()) throws -> [String: Any] {
        do {
            let rootModel = try map(NetBaseData<[String: AnyCodable]>.self, using: decoder)
            if rootModel.status != kAqServerStatusSuccessCode {
                throw AQApiError.serverError(statusCode: rootModel.status, msg: rootModel.message)
            }
            return rootModel.data ?? [:]
        } catch {
            throw error
        }
    }
}
