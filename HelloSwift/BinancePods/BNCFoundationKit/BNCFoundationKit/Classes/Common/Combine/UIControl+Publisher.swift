//
//  UIControl+Publisher.swift
//  BNCFoundationKit
//
//  Created by danis on 2021/9/3.
//

import Combine
import UIKit

#if !os(watchOS)
@available(iOS 13.0, *)
public class UIControlEventSubscription<SubscriberType: Subscriber, Control: UIControl>: Subscription
    where SubscriberType.Input == Control {
    private var subscriber: SubscriberType?
    private let control: Control

    init(subscriber: SubscriberType, control: Control, event: Control.Event) {
        self.subscriber = subscriber
        self.control = control

        control.addTarget(self, action: #selector(onActionEvent), for: event)
    }

    @objc private func onActionEvent() {
        _ = subscriber?.receive(control)
    }

    public func request(_ demand: Subscribers.Demand) {}

    public func cancel() {
        subscriber = nil
    }
}

@available(iOS 13.0, *)
public struct UIControlEventPublisher<Control: UIControl>: Publisher {
    public typealias Output = Control
    public typealias Failure = Never

    let control: Control
    let event: Control.Event

    init(control: Control, event: Control.Event) {
        self.control = control
        self.event = event
    }

    public func receive<S>(subscriber: S) where S: Subscriber, Never == S.Failure, Control == S.Input {
        let subscription = UIControlEventSubscription(subscriber: subscriber, control: control, event: event)

        subscriber.receive(subscription: subscription)
    }
}
#endif
