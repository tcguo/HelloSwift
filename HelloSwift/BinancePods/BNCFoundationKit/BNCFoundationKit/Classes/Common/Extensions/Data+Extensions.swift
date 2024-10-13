//
//  Data+Extensions.swift
//  Binance
//
//  Created by Binance on 10/12/18.
//

import Foundation

extension Data {
    public enum EncodingError: Error {
        case string(String, using: String.Encoding)
    }

    public init(string: String, using encoding: String.Encoding) throws {
        guard let data = string.data(using: encoding) else {
            throw EncodingError.string(string, using: encoding)
        }

        self = data
    }
}
