//
//  Bool+Ext.swift
//  StoryCore
//
//  Created by GEORGE QUENTIN on 09/08/2018.
//  Copyright © 2018 LEXI LABS. All rights reserved.
//

import Foundation

public extension Bool {
    /// Convenience method to map the value of a Boolean to a specific Type.
    ///
    /// - Parameters:
    ///   - ifTrue: The result when the Boolean is true
    ///   - ifFalse: The result when the Boolean is false
    /// - Returns: Returns the result of a specific Type
    public func mapTo<T>( ifTrue:T, ifFalse:T ) -> T {

        if self {
            return ifTrue
        } else {
            return ifFalse
        }

    }
}
