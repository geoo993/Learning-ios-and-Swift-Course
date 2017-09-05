//
//  MathOperations.swift
//  AlienPhonicsSpriteKit
//
//  Created by GEORGE QUENTIN on 26/02/2016.
//  Copyright © 2016 GEORGE QUENTIN. All rights reserved.
//

import Foundation
import UIKit



struct Number {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "," // or possibly "." / "," / " "
        formatter.numberStyle = .decimal
        return formatter
    }()
}

public extension Int {
    
    public var degreesToRadians: Double { return Double(self) * .pi / 180 }
    
    public var stringWithSepator: String {
        return Number.withSeparator.string(from: NSNumber(value: hashValue)) ?? ""
    }
    
    public static func random(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
}
public extension Double {
    
    public func format(f: String) -> String {
        return NSString(format: "%\(f)f" as NSString, self) as String
    }
    
    public static func random(min: Double, max: Double) -> Double {
        
        let rand = Double(arc4random()) / Double(UINT32_MAX)
        let minimum = min < max ? min : max 
        return  rand * Swift.abs(Double( min - max)) + minimum
    }
    
    /// Rounds the double to decimal places value
    public func round(to places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
        
    }
    
}

public extension FloatingPoint {
    public var degreesToRadians: Self { return self * .pi / 180 }
    public var radiansToDegrees: Self { return self * 180 / .pi }
}


public extension Float {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * CGFloat(Double.pi) / 180.0
    }
}

public extension CGFloat {
    
    public static func overrideHeightSizeF(size:CGFloat) -> CGFloat {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        switch height {
        case 480.0: //Iphone 3,4 => 3.5 inch
            return size * 0.55
        case 568.0: //iphone 5, 5s, SE => 4 inch
            return size * 0.64
        case 667.0: //iphone 7, 6, 6s => 4.7 inch
            return size * 0.72
        case 736.0: //iphone 7s, 6s+ 6+ => 5.5 inch
            return size * 0.80
        case 1024.0: //iPad Retina, iPad Air, iPad Mini
            return size * 0.90
        case 1112.0: //iPad Pro 10.5
            return size * 0.94
        case 1366.0: //iPad Pro 12.9
            return size
        default:
            return 0
        }
    }
    
    public static func overrideWidthSizeF(size:CGFloat) -> CGFloat {
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width
        switch width {
        case 320.0: //Iphone 3,4 5, 5s, SE => 4 inch
            return size * 0.60
        case 375.0: //iphone 7, 6, 6s => 4.7 inch
            return size * 0.66
        case 414.0: //iphone 7s, 6s+ 6+ => 5.5 inch
            return size * 0.72
        case 768.0: //ipad Retina, ipad Air, iPad Mini
            return size * 0.84
        case 834.0: //iPad Pro 10.5
            return size * 92
        case 1024.0: //iPad Pro 12.9
            return size
        default:
            return 0
        }
    }
    
    public func round(to places:Int) -> CGFloat {
        let divisor = pow(10.0, CGFloat(places))
        return Darwin.round(self * divisor) / divisor
    }
    
    public static func randF() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
    public static func randomF(min: CGFloat, max: CGFloat) -> CGFloat {
        
        let rand = CGFloat(arc4random()) / CGFloat(UINT32_MAX)
        let minimum = min < max ? min : max 
        return  rand * Swift.abs(CGFloat( min - max)) + minimum
    }
   
    public static func distanceBetweenF(p1 : CGPoint, p2 : CGPoint) -> CGFloat {
        let dx : CGFloat = p1.x - p2.x
        let dy : CGFloat = p1.y - p2.y
        return sqrt(dx * dx + dy * dy)
    }
    
    public static func clampF(value: CGFloat, minimum:CGFloat, maximum:CGFloat) -> CGFloat {
        
        if value < minimum { return minimum }
        if value > maximum { return maximum }
        return value
    }
    
    public func percentageWithF(maxValue:CGFloat, minValue: CGFloat) -> CGFloat 
    {
        let difference: CGFloat = (minValue < 0) ? maxValue : maxValue - minValue;
        return (CGFloat(100) * ((self - minValue) / difference));
    }
    
    public func getPercentangeValueF(_ percent : CGFloat, _ minValue : CGFloat) -> CGFloat{
        let max = (self > minValue) ? self : minValue
        let min = (self > minValue) ? minValue : self
        
        return ( ((max - min) * percent) / CGFloat(100) ) + min
    }
    
}

