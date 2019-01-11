//
//  CollectionType+Ext.swift
//  StorySmartiesCore
//
//  Created by Daniel Asher on 09/08/2016.
//  Copyright © 2016 LEXI LABS. All rights reserved.
//

public extension Collection {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    public subscript(safe index: Index) -> Iterator.Element? {
        return index >= startIndex && index < endIndex ? self[index] : nil
    }
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    public func get(index: Index,
                    functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line)
        -> Iterator.Element {
            // TODO: Replace this with log.fatal
            precondition(index >= startIndex && index < endIndex,
                         "Index out of bounds in func \(functionName) in \(fileName):\(lineNumber)")
            return self[index]
    }
    public func toArray() -> [Iterator.Element] {
        return Array(self)
    }
}

public extension Collection where Iterator.Element == CGRect {
    public func intersecting(frame: CGRect) -> Bool {
        guard let rects = self as? [CGRect] else { return false }
        var isIntersecting = false
        for rect in rects {
            if frame.intersects(rect) {
                isIntersecting = true
                break
            }
        }
        return isIntersecting
    }
}


// Protocol that adds pairing to CollectionType classes
public protocol Pairs {}
// We need to make sure SubSequence.Generator.Element == Generator.Element
// https://airspeedvelocity.net/2016/01/03/generic-collections-subsequences-and-overloading/
public extension Pairs where Self: Collection {
    /// Create a tuple array of adjacent pairs. The resulting array is length count-1
    /// - Parameter withWrap: if true pairs the last element with the first.
    public func pairs(withWrap: Bool = false) -> [(Self.Iterator.Element, Self.Iterator.Element)] {
        guard count >= 1 else { return [] }
        if withWrap == true {
            var tail = Array(dropFirst())
            tail.append(first!)
            return Array(zip(self, tail))
        } else {
            let tail = dropFirst()
            return Array(zip(self, tail))
        }
    }

    public func maybePairs() -> [(first: Self.Iterator.Element, second: Self.Iterator.Element?)] {
        guard count >= 1 else { return [] }
        let second = dropFirst()
            .map { (elm: Self.Iterator.Element) -> Self.Iterator.Element? in return elm } + [nil]
        return zip(self, second).map { $0 }
    }
}

public extension Collection {
    public func split(after index: Self.Index) -> ([Self.Iterator.Element], [Self.Iterator.Element]) {
        guard index >= startIndex else { return ([], map { $0 }) }
        guard index < endIndex else { return (map { $0 }, []) }
        return (prefix(upTo: index).map { $0 }, suffix(from: index).map { $0 })
    }

    public func split(before index: Self.Index) -> ([Self.Iterator.Element], [Self.Iterator.Element]) {
        return split(after: self.index(index, offsetBy: -1))
    }
}

public extension Collection {
    public func cons() -> (head: Self.Iterator.Element?, tail: [Self.Iterator.Element]) {
        guard let head = self.first else { return (head: nil, tail: []) }
        let tail = dropFirst().compactMap { $0 }
        return (head: head, tail: tail)
    }

    public func bodyTip() -> (body: [Self.Iterator.Element], tip: Self.Iterator.Element?) {
        let last = suffix(1).map { $0 }.first
        guard let tip = last else { return (body: [], tip: nil) }
        let body = dropLast().compactMap { $0 }
        return (body: body, tip: tip)
    }

    public func recReduce(_ combine: @escaping (Self.Iterator.Element, Self.Iterator.Element)
        -> Self.Iterator.Element) -> Self.Iterator.Element? {
        return first.map { head in
            self.dropFirst().compactMap { $0 }
                .recReduce(combine)
                .map { combine(head, $0) }
                ?? head
        }
    }
}

extension Array: Pairs {}
extension Set: Pairs {}
