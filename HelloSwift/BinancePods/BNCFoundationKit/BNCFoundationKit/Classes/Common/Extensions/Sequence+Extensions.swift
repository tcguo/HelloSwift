//
//  Sequence+Extensions.swift
//  Binance
//
//  Created by Daniel Clelland on 14/01/19.
//  Copyright © 2019 Binance. All rights reserved.
//

import Foundation

public func zipOptional<Sequence1: Sequence, Sequence2: Sequence>(
    _ sequence1: Sequence1,
    _ sequence2: Sequence2
) -> Zip2OptionalSequence<Sequence1, Sequence2> {
    Zip2OptionalSequence(sequence1, sequence2)
}

public struct Zip2OptionalSequence<Sequence1: Sequence, Sequence2: Sequence>: Sequence {
    private let sequence1: Sequence1
    private let sequence2: Sequence2

    public init(_ sequence1: Sequence1, _ sequence2: Sequence2) {
        self.sequence1 = sequence1
        self.sequence2 = sequence2
    }

    public func makeIterator() -> Zip2OptionalSequence<Sequence1, Sequence2>.Iterator {
        Iterator(sequence1.makeIterator(), sequence2.makeIterator())
    }

    public struct Iterator: IteratorProtocol {
        public typealias Element = (Sequence1.Iterator.Element?, Sequence2.Iterator.Element?)

        private var iterator1: Sequence1.Iterator
        private var iterator2: Sequence2.Iterator

        private var reachedEnd = false

        public init(_ iterator1: Sequence1.Iterator, _ iterator2: Sequence2.Iterator) {
            self.iterator1 = iterator1
            self.iterator2 = iterator2
        }

        public mutating func next() -> Element? {
            if reachedEnd {
                return nil
            }

            let element1 = iterator1.next()
            let element2 = iterator2.next()

            if element1 == nil && element2 == nil {
                reachedEnd.toggle()
                return nil
            }

            return (element1, element2)
        }
    }
}
