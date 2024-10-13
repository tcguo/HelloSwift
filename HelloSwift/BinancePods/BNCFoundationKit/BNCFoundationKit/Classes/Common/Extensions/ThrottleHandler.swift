//
//  Throttler.swift
//  Binance
//
//  Created by Kevin Ma on 2020/1/15.
//  Copyright © 2020 Binance. All rights reserved.
//

import UIKit

public class ThrottleHandler: NSObject {
    private let queue: DispatchQueue

    private var workItem = DispatchWorkItem(block: {})
    private var previousDate = Date.distantPast

    private var constantLimit: TimeInterval

    public init(queue: DispatchQueue = DispatchQueue.global(qos: .background), constantLimit: TimeInterval = 1) {
        self.queue = queue
        self.constantLimit = constantLimit
    }

    public func throttle(secondsLimit: Double = 1, block: @escaping () -> Void) {
        workItem.cancel()
        workItem = DispatchWorkItem { [weak self] in
            self?.previousDate = Date()
            block()
        }
        let delay = Date().timeIntervalSince(previousDate) > secondsLimit ? 0 : secondsLimit
        queue.asyncAfter(deadline: .now() + delay, execute: workItem)
    }

    public func throttleUsingConstantLimit(block: @escaping (() -> Void)) {
        workItem.cancel()
        workItem = DispatchWorkItem { [weak self] in
            self?.previousDate = Date()
            block()
        }
        let delay = Date().timeIntervalSince(previousDate) > constantLimit ? 0 : constantLimit
        queue.asyncAfter(deadline: .now() + delay, execute: workItem)
    }

    public func cancel() {
        workItem.cancel()
        workItem = DispatchWorkItem(block: {})
    }
}
