//
//  CGPoint+Ext.swift
//  StorySmartiesView
//
//  Created by GEORGE QUENTIN on 25/10/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation
import UIKit

public extension CGPoint{
    
    public func distance(to point:CGPoint) -> CGFloat{
        let dx = pow(point.x - self.x, 2)
        let dy = pow(point.y - self.y, 2)
        return sqrt(dx+dy)
    }
    /// Calculates distance between two points.
    public func distanceTo(_ point: CGPoint) -> CGFloat {
        let xDist = Float(self.x - point.x)
        let yDist = Float(self.y - point.y)
        return CGFloat(hypotf(xDist, yDist))
    }
    
    /// Finds the closest `t` value on path for a given point.
    ///
    /// - Parameter fromPoint: A given point
    /// - Returns: The closest point on the path within the lookup table.
    public func findClosestPointOnPath(within points: [CGPoint]) -> CGPoint {
        
        let lookupTable = points
        let fromPoint = self
        if (lookupTable.count <= 0){ return fromPoint }
        let end = lookupTable.count
        var dd = fromPoint.distanceTo( lookupTable.first!)
        var d: CGFloat = 0
        var f = 0
        for i in 1..<end {
            d = fromPoint.distanceTo( lookupTable[i])
            if d < dd {
                f = i
                dd = d
            }
        }
        return lookupTable[f]
    }
    
    /// Calculates a point at given t value, where t in 0.0...1.0
    public func calculateLinear(t: CGFloat, p1: CGPoint, p2: CGPoint) -> CGPoint {
        let mt : CGFloat = 1.0 - t
        let x = mt * p1.x + t * p2.x
        let y = mt * p1.y + t * p2.y
        return CGPoint(x: x, y: y)
    }
    
    /// Calculates a point at given t value, where t in 0.0...1.0
    public func calculateCube(t: CGFloat, p1: CGPoint, p2: CGPoint, p3: CGPoint, p4: CGPoint) -> CGPoint {
        let mt : CGFloat = 1.0 - t
        let mt2 = mt * mt
        let t2 = t * t
        
        let a = mt2 * mt
        let b = mt2 * t * 3
        let c = mt * t2 * 3
        let d = t * t2
        
        let x = a * p1.x + b * p2.x + c * p3.x + d * p4.x
        let y = a * p1.y + b * p2.y + c * p3.y + d * p4.y
        return CGPoint(x: x, y: y)
    }
    
    /// Calculates a point at given t value, where t in 0.0...1.0
    public func calculateQuad(t: CGFloat, p1: CGPoint, p2: CGPoint, p3: CGPoint) -> CGPoint {
        let mt : CGFloat = 1.0 - t
        let mt2 = mt * mt
        let t2 = t * t
        
        let a = mt2
        let b = mt * t * 2.0
        let c = t2
        
        let x = a * p1.x + b * p2.x + c * p3.x
        let y = a * p1.y + b * p2.y + c * p3.y
        return CGPoint(x: x, y: y)
    }
    
}
