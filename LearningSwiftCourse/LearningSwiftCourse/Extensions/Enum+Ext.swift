//
//  Enum+Ext.swift
//  StoryCore
//
//  Created by GEORGE QUENTIN on 18/04/2018.
//  Copyright © 2018 LEXI LABS. All rights reserved.
//
// https://theswiftdev.com/2017/10/12/swift-enum-all-values/

public protocol EnumCollection: Hashable {
    static func cases() -> AnySequence<Self>
    static var toArray: [Self] { get }
    static var names: [String] { get }
}

public extension EnumCollection {

    public static func cases() -> AnySequence<Self> {
        return AnySequence { () -> AnyIterator<Self> in
            var raw = 0
            return AnyIterator {
                let current: Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else {
                    return nil
                }
                raw += 1
                return current
            }
        }
    }

    public static var toArray: [Self] {
        return Array(self.cases())
    }

    public static var names: [String] {
        return self.toArray.map({ String(describing: $0) })
    }

    public static var random: Self {
        return toArray.chooseOneRandomly()!
    }

    public static func collect(by name: String) -> Self? {
        return toArray.first(where: { (String(describing: $0) == name) })
    }
}
