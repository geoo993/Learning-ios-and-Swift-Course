//
//  MathOperations.swift
//  AlienPhonicsSpriteKit
//
//  Created by GEORGE QUENTIN on 26/02/2016.
//  Copyright © 2016 GEORGE QUENTIN. All rights reserved.
//

import Foundation
import UIKit


extension Int {
    
    public static func random(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
}
extension Double {
    
    public static func random(min: Double, max: Double) -> Double {
        
        let rand = Double(arc4random()) / Double(UINT32_MAX)
        let minimum = min < max ? min : max 
        return  rand * abs(_:min - max) + minimum
    }
}

extension CGFloat {
    
  
    
    public static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        
        let rand = CGFloat(arc4random()) / CGFloat(UINT32_MAX)
        let minimum = min < max ? min : max 
        return  rand * abs(min - max) + minimum
    }

    public static func clampf(value: CGFloat, minimum:CGFloat, maximum:CGFloat) -> CGFloat {
        
        if value < minimum { return minimum }
        if value > maximum { return maximum }
        return value
    }
    

}
