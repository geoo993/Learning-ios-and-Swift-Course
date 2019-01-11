//
//  Comparable+Ext.swift
//  StoryView
//
//  Created by Daniel Asher on 21/01/2018.
//  Copyright © 2018 LEXI LABS. All rights reserved.
//

extension Comparable {
    public func max(with value: Self) -> Self {
        if value > self {
            return value
        }
        return self
    }

    public func min(with value: Self) -> Self {
        if value < self {
            return value
        }
        return self
    }

    public func clamped(to range: ClosedRange<Self>) -> Self {
        return Swift.max(range.lowerBound, Swift.min(self, range.upperBound))
    }
}
