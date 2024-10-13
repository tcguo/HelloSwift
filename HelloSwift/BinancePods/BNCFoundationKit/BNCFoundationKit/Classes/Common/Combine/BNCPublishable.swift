//
//  BNCPublishable.swift
//  BNCFoundationKit
//
//  Created by danis on 2021/9/22.
//

import Combine

public protocol BNCPublishable {}

#if !os(watchOS)
extension UIControl: BNCPublishable {}

extension BNCPublishable where Self: UIControl {
    @available(iOS 13.0, *)
    public func publisher(for event: UIControl.Event) -> UIControlEventPublisher<Self> {
        UIControlEventPublisher(control: self, event: event)
    }
}
#endif
