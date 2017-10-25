//
//  CGPath+Ext.swift
//  StorySmartiesView
//
//  Created by GEORGE QUENTIN on 25/10/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation
import UIKit


public extension CGPath {
    
    public func forEach( body: @convention(block) (CGPathElement) -> Void) {
        typealias Body = @convention(block) (CGPathElement) -> Void
        let callback: @convention(c) (UnsafeMutableRawPointer, UnsafePointer<CGPathElement>) -> Void = { (info, element) in
            let body = unsafeBitCast(info, to: Body.self)
            body(element.pointee)
        }
        print("path element memory: ", MemoryLayout.size(ofValue: body))
        let unsafeBody = unsafeBitCast(body, to: UnsafeMutableRawPointer.self)
        self.apply(info: unsafeBody, function: unsafeBitCast(callback, to: CGPathApplierFunction.self))
    }
    
    public func getPathElementsPoints() -> [CGPoint] {
        var arrayPoints : [CGPoint]! = [CGPoint]()
        self.forEach { element in
            switch (element.type) {
            case CGPathElementType.moveToPoint:
                arrayPoints.append(element.points[0])
            case .addLineToPoint:
                arrayPoints.append(element.points[0])
            case .addQuadCurveToPoint:
                arrayPoints.append(element.points[0])
                arrayPoints.append(element.points[1])
            case .addCurveToPoint:
                arrayPoints.append(element.points[0])
                arrayPoints.append(element.points[1])
                arrayPoints.append(element.points[2])
            default: break
            }
        }
        return arrayPoints
    }
    
    func getPathElementsPointsAndTypes() -> ([CGPoint],[CGPathElementType]) {
        var arrayPoints : [CGPoint]! = [CGPoint]()
        var arrayTypes : [CGPathElementType]! = [CGPathElementType]()
        self.forEach { element in
            switch (element.type) {
            case CGPathElementType.moveToPoint:
                arrayPoints.append(element.points[0])
                arrayTypes.append(element.type)
            case .addLineToPoint:
                arrayPoints.append(element.points[0])
                arrayTypes.append(element.type)
            case .addQuadCurveToPoint:
                arrayPoints.append(element.points[0])
                arrayPoints.append(element.points[1])
                arrayTypes.append(element.type)
                arrayTypes.append(element.type)
            case .addCurveToPoint:
                arrayPoints.append(element.points[0])
                arrayPoints.append(element.points[1])
                arrayPoints.append(element.points[2])
                arrayTypes.append(element.type)
                arrayTypes.append(element.type)
                arrayTypes.append(element.type)
            default: break
            }
        }
        return (arrayPoints,arrayTypes)
    }
}

public extension CGPathElement{
    
    public var point: CGPoint{
        switch type {
        case .moveToPoint, .addLineToPoint:
            return self.points[0]
        case .addQuadCurveToPoint:
            return self.points[1]
        case .addCurveToPoint:
            return self.points[2]
        case .closeSubpath:
            return CGRect.null.origin
        }
    }
    
    public func distance(to point: CGPoint, startPoint: CGPoint ) -> CGFloat{
        switch type {
        case .moveToPoint:
            return 0.0
        case .closeSubpath:
            return point.distance(to:startPoint)
        case .addLineToPoint:
            return point.distance(to:self.points[0])
        case .addCurveToPoint:
            return UIBezierPath.BezierCurveLength(p0: point, c1: self.points[0], c2: self.points[1], p1: self.points[2])
        case .addQuadCurveToPoint:
            return UIBezierPath.BezierCurveLength(p0: point, c1: self.points[0], p1: self.points[1])
        }
    }
}

