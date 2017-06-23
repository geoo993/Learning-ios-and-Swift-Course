//
//  UIKit+Ext.swift
//  AlienPhonicsSpriteKit
//
//  Created by GEORGE QUENTIN on 26/02/2016.
//  Copyright © 2016 GEORGE QUENTIN. All rights reserved.
//
///colors from
///https://stackoverflow.com/questions/24263007/how-to-use-hex-colour-values-in-swift-ios


import Foundation
import UIKit

public struct ColorComponents {
    var r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat
}


public extension UIColor {
    
    public static func systemsBlueColor () -> UIColor
    {
        return UIColor.init(red: 0.0, green: 0.4784, blue: 1.0, alpha: 1.0) 
    }
    public static func bbciplayerDark() -> UIColor
    {
        return UIColor.init(red: 27/255, green: 30/255, blue: 42/255, alpha: 1.0)
    }
    public static func bbciplayerWhiteGray() -> UIColor
    {
        return UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
    }
    public static func bbciplayerPink() -> UIColor
    {
        return UIColor.init(red: 1.0, green: 51/255, blue: 153/255, alpha: 1.0)
    }
    
    public func getTextColor () -> UIColor {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        _ = self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r<0.8 && g<0.8 && b<0.8) ? UIColor.white : UIColor.black
    }
    public static func randomColor() -> UIColor {
        
        return UIColor.init(red: CGFloat.randomF(min: 0.0, max: 1.0), green: CGFloat.randomF(min: 0.0,max: 1.0), blue: CGFloat.randomF(min:0.0,max: 1.0), alpha: 1)
    }

    public func getComponents() -> ColorComponents {
        if (self.cgColor.numberOfComponents == 2) {
            let cc = self.cgColor.components;
            return ColorComponents(r:cc![0], g:cc![0], b:cc![0], a:cc![1])
        }
        else {
            let cc = self.cgColor.components;
            return ColorComponents(r:cc![0], g:cc![1], b:cc![2], a:cc![3])
        }
    }
    
    public  var redValue: CGFloat{
        return cgColor.components! [0]
    }
    
    public  var greenValue: CGFloat{
        return cgColor.components! [1]
    }
    
    public var blueValue: CGFloat{
        return cgColor.components! [2]
    }
    
    public var alphaValue: CGFloat{
        return cgColor.components! [3]
    }
    
    public func getRBGValues() -> (r:CGFloat, g:CGFloat,b:CGFloat, a:CGFloat){
        return (r:redValue, g:greenValue, b: blueValue, a:alphaValue)
    }
    
    public static func interpolateRGBColorWithWhite(start:UIColor,end:UIColor, fraction:CGFloat) -> UIColor
    {
        var f = max(0, fraction)
        f = min(1, fraction)
        
        let c1 = start.getComponents()
        let c2 = end.getComponents()
        
        let r: CGFloat = CGFloat(c1.r + (c2.r - c1.r) * f)
        let g: CGFloat = CGFloat(c1.g + (c2.g - c1.g) * f)
        let b: CGFloat = CGFloat(c1.b + (c2.b - c1.b) * f)
        let a: CGFloat = CGFloat(c1.a + (c2.a - c1.a) * f)
        
        return UIColor.init(red: r, green: g, blue: b, alpha: a)
    }
    
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = hexString.substring(from: start)
            
            if hexColor.characters.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
    
    public convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    public convenience init(rgb: Int, a: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            a: a
        )
    }

    public func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        //let rgb:Int = (Int)(r * 255)<<16 | (Int)(g * 255)<<8 | (Int)(b * 255)<<0
        //return NSString(format:"#%06x", rgb) as String
        return String(
            format: "%02X%02X%02X",
            Int(r * 0xff),
            Int(g * 0xff),
            Int(b * 0xff)
        )
    }
    
   
    
    public static let cssString : [String] = [
        "CLEAR" ,
        "TRANSPARENT",
        "" ,
        "ALICEBLUE" ,
        "ANTIQUEWHITE" ,
        "AQUA" ,
        "AQUAMARINE" ,
        "AZURE" ,
        "BEIGE" ,
        "BISQUE",
        "BLACK" ,
        "BLANCHEDALMOND",
        "BLUE",
        "BLUEVIOLET" ,
        "BROWN" ,
        "BURLYWOOD" ,
        "CADETBLUE" ,
        "CHARTREUSE",
        "CHOCOLATE" ,
        "CORAL",
        "CORNFLOWERBLUE",
        "CORNSILK" ,
        "CRIMSON",
        "CYAN" ,
        "DARKBLUE",
        "DARKCYAN" ,
        "DARKGOLDENROD" ,
        "DARKGRAY" ,
        "DARKGREY" ,
        "DARKGREEN",
        "DARKKHAKI",
        "DARKMAGENTA" ,
        "DARKOLIVEGREEN" ,
        "DARKORANGE" ,
        "DARKORCHID" ,
        "DARKRED",
        "DARKSALMON",
        "DARKSEAGREEN" ,
        "DARKSLATEBLUE",
        "DARKSLATEGRAY",
        "DARKSLATEGREY",
        "DARKTURQUOISE",
        "DARKVIOLET" ,
        "DEEPPINK",
        "DEEPSKYBLUE" ,
        "DIMGRAY" ,
        "DIMGREY" ,
        "DODGERBLUE" ,
        "FIREBRICK" ,
        "FLORALWHITE" ,
        "FORESTGREEN" ,
        "FUCHSIA" ,
        "GAINSBORO",
        "GHOSTWHITE" ,
        "GOLD" ,
        "GOLDENROD" ,
        "GRAY" ,
        "GREY" ,
        "GREEN" ,
        "GREENYELLOW" ,
        "HONEYDEW",
        "HOTPINK" ,
        "INDIANRED",
        "INDIGO",
        "IVORY" ,
        "KHAKI" ,
        "LAVENDER" ,
        "LAVENDERBLUSH" ,
        "LAWNGREEN" ,
        "LEMONCHIFFON" ,
        "LIGHTBLUE" ,
        "LIGHTCORAL" ,
        "LIGHTCYAN" ,
        "LIGHTGOLDENRODYELLOW" ,
        "LIGHTGRAY" ,
        "LIGHTGREY" ,
        "LIGHTGREEN" ,
        "LIGHTPINK" ,
        "LIGHTSALMON" ,
        "LIGHTSEAGREEN",
        "LIGHTSKYBLUE" ,
        "LIGHTSLATEGRAY" ,
        "LIGHTSLATEGREY" ,
        "LIGHTSTEELBLUE" ,
        "LIGHTYELLOW" ,
        "LIME" ,
        "LIMEGREEN" ,
        "LINEN" ,
        "MAGENTA",
        "MAROON" ,
        "MEDIUMAQUAMARINE",
        "MEDIUMBLUE" ,
        "MEDIUMORCHID" ,
        "MEDIUMPURPLE" ,
        "MEDIUMSEAGREEN" ,
        "MEDIUMSLATEBLUE" ,
        "MEDIUMSPRINGGREEN",
        "MEDIUMTURQUOISE" ,
        "MEDIUMVIOLETRED" ,
        "MIDNIGHTBLUE" ,
        "MINTCREAM",
        "MISTYROSE",
        "MOCCASIN" ,
        "NAVAJOWHITE" ,
        "NAVY" ,
        "OLDLACE" ,
        "OLIVE" ,
        "OLIVEDRAB" ,
        "ORANGE" ,
        "ORANGERED" ,
        "ORCHID" ,
        "PALEGOLDENROD",
        "PALEGREEN" ,
        "PALETURQUOISE" ,
        "PALEVIOLETRED" ,
        "PAPAYAWHIP" ,
        "PEACHPUFF" ,
        "PERU" ,
        "PINK" ,
        "PLUM" ,
        "POWDERBLUE" ,
        "PURPLE" ,
        "RED" ,
        "ROSYBROWN" ,
        "ROYALBLUE" ,
        "SADDLEBROWN",
        "SALMON",
        "SANDYBROWN" ,
        "SEAGREEN" ,
        "SEASHELL" ,
        "SIENNA" ,
        "SILVER" ,
        "SKYBLUE",
        "SLATEBLUE" ,
        "SLATEGRAY" ,
        "SLATEGREY" ,
        "SNOW" ,
        "SPRINGGREEN" ,
        "STEELBLUE" ,
        "TAN" ,
        "TEAL",
        "THISTLE",
        "TOMATO" ,
        "TURQUOISE" ,
        "VIOLET",
        "WHEAT" ,
        "WHITE" ,
        "WHITESMOKE" ,
        "YELLOW",
        "YELLOWGREEN" 
    ]

    
}
