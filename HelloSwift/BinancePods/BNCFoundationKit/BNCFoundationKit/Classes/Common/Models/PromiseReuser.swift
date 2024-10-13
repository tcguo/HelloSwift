//
//  Promise+Reuse.swift
//  BNCFuturesModule
//
//  Created by XiaoFeng Chen on 2021/5/12.
//

import Foundation
import PromiseKit

open class PromiseReuser<T> {
    public enum ReuseMode {
        case always
        case timeout(TimeInterval)
    }

    public typealias PromiseCreater = () -> Promise<T>

    private let mode: ReuseMode
    private let promiseCreater: PromiseCreater
    public init(
        creater: @escaping PromiseCreater,
        mode: ReuseMode
    ) {
        self.mode = mode
        promiseCreater = creater
    }

    private var tempPromise: Promise<T>?
    open func get() -> Promise<T> {
        switch mode {
        case .always:
            guard let promise = tempPromise, !promise.isRejected else {
                let new = promiseCreater()
                tempPromise = new
                return new
            }
            return promise
        case let .timeout(interval):
            guard let promise = tempPromise, !promise.isRejected else {
                let new = promiseCreater()
                tempPromise = new
                DispatchQueue.main.asyncAfter(deadline: .now() + interval) { [weak self] in
                    if self?.tempPromise?.isPending ?? false {
                        _ = self?.tempPromise?.tap { _ in
                            self?.tempPromise = nil
                        }
                    } else {
                        self?.tempPromise = nil
                    }
                }
                return new
            }
            return promise
        }
    }
}
