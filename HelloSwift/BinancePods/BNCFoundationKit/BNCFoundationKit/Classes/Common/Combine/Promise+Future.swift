//
//  Promise+Future.swift
//  BNCFoundationKit
//
//  Created by danis on 2021/9/3.
//

import Combine
import PromiseKit

@available(iOS 13.0, *)
extension Promise {
    public func asFuture(on queue: DispatchQueue = .main) -> Future<T, Error> {
        Future { promise in
            self.done(on: queue) {
                promise(.success($0))
            }.catch {
                promise(.failure($0))
            }
        }
    }
}
