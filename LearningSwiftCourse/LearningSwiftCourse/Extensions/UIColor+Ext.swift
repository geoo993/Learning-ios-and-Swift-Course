
// https://gist.github.com/nbasham/3b2de0566d5f716894fc
// https://stackoverflow.com/questions/24263007/how-to-use-hex-colour-values-in-swift-ios

import UIKit

public struct ColorComponents {
    var r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat
}

public extension UIColor {
 
    public convenience init(hex: String?) {
        let normalizedHexString: String = UIColor.normalize(hex)
        var c: CUnsignedInt = 0
        Scanner(string: normalizedHexString).scanHexInt32(&c)
        self.init(red:UIColorMasks.redValue(c), green:UIColorMasks.greenValue(c), blue:UIColorMasks.blueValue(c), alpha:UIColorMasks.alphaValue(c))
    }
    
    public convenience init(colorArray array: NSArray) {
        let r = array[0] as! CGFloat
        let g = array[1] as! CGFloat
        let b = array[2] as! CGFloat
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha:1.0)
    }
    
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = hexString.substring(from: start.encodedOffset)
            
            if hexColor.count == 8 {
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
    
    public convenience init(rgba: String) {
        // https://raw.githubusercontent.com/yeahdongcn/UIColor-Hex-Swift/master/UIColorExtension.swift
        var red: Double   = 0.0
        var green: Double = 0.0
        var blue: Double  = 0.0
        var alpha: Double = 1.0
        
        if rgba.hasPrefix("#") {
            let start = rgba.index(rgba.startIndex, offsetBy: 1)
            let hex = rgba.substring(from: start.encodedOffset)
            let scanner = Scanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexInt64(&hexValue) {
                let numElements = hex.count
                if numElements == 6 {
                    red   = Double((hexValue & 0xFF0000) >> 16) / 255.0
                    green = Double((hexValue & 0x00FF00) >> 8)  / 255.0
                    blue  = Double(hexValue & 0x0000FF) / 255.0
                } else if numElements == 8 {
                    red   = Double((hexValue & 0xFF000000) >> 24) / 255.0
                    green = Double((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = Double((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = Double(hexValue & 0x000000FF)         / 255.0
                } else {
                    print("invalid rgb string, length should be 7 or 9", terminator: "")
                }
            } else {
                print("scan hex error")
            }
        } else {
            print("invalid rgb string, missing '#' as prefix", terminator: "")
        }
        self.init(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
    }
    
    public convenience init(rgb: Int, a: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            a: a
        )
    }
    
    convenience private init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }   
    
    public static var aliceBlue : UIColor { return  UIColor(hex: 0xF0F8FF)}
    public static var amber : UIColor { return  UIColor(hex: 0xFFC107)}
    public static var antiqueWhite : UIColor { return  UIColor(hex: 0xFAEBD7)}
    public static var aqua : UIColor { return  UIColor(hex: 0x00FFFF)}
    public static var aquamarine : UIColor { return  UIColor(hex: 0x7FFFD4)}
    public static var azure : UIColor { return  UIColor(hex: 0xF0FFFF)}
    public static var bisque : UIColor { return  UIColor(hex: 0xFFE4C4)}
    public static var blanchedAlmond : UIColor { return  UIColor(hex: 0xFFEBCD)}
    public static var beige : UIColor { return  UIColor(hex: 0xF5F5DC)}
    public static var blueGrey : UIColor { return  UIColor(hex: 0x607D8B)}
    public static var blueViolet : UIColor { return  UIColor(hex: 0x8A2BE2)}
    public static var burlyWood : UIColor { return  UIColor(hex: 0xDEB887)}
    public static var cadetBlue : UIColor { return  UIColor(hex: 0x5F9EA0)}
    public static var coral : UIColor { return  UIColor(hex: 0xFF7F50)}
    public static var cornsilk : UIColor { return  UIColor(hex: 0xFFF8DC)}
    public static var cornflowerBlue : UIColor { return  UIColor(hex: 0x6495ED)}
    public static var chartreuse : UIColor { return  UIColor(hex: 0x7FFF00)}
    public static var chocolate : UIColor { return  UIColor(hex: 0xD2691E)}
    public static var crimson : UIColor { return  UIColor(hex: 0xDC143C)}
    public static var darkSlateBlue : UIColor { return  UIColor(hex: 0x483D8B)}
    public static var darkSlateGray : UIColor { return  UIColor(hex: 0x2F4F4F)}
    public static var darkYellow : UIColor { return  UIColor(hex: 0xFFEB3B)}
    public static var darkPink : UIColor { return  UIColor(hex: 0xE91E63)}
    public static var darkSalmon : UIColor { return  UIColor(hex: 0xE9967A)}
    public static var darkRed : UIColor { return  UIColor(hex: 0x8B0000)}
    public static var darkKhaki : UIColor { return  UIColor(hex: 0xBDB76B)}
    public static var deepPink : UIColor { return  UIColor(hex: 0xFF1493)}
    public static var deepOrange : UIColor { return  UIColor(hex: 0xFF5722)}
    public static var darkOrange : UIColor { return  UIColor(hex: 0xFF8C00)}
    public static var darkOliveGreen : UIColor { return  UIColor(hex: 0x556B2F)}
    public static var darkGoldenrod : UIColor { return  UIColor(hex: 0xB8860B)}
    public static var darkSeaGreen : UIColor { return  UIColor(hex: 0x8FBC8F)}
    public static var darkGreen : UIColor { return  UIColor(hex: 0x006400)}
    public static var darkTurquoise : UIColor { return  UIColor(hex: 0x00CED1)}
    public static var darkCyan : UIColor { return  UIColor(hex: 0x008B8B)}
    public static var darkBlue: UIColor { return  UIColor(hex: 0x00008B)}
    public static var darkViolet : UIColor { return  UIColor(hex: 0x9400D3)}
    public static var darkOrchid : UIColor { return  UIColor(hex: 0x9932CC)}
    public static var darkMagenta : UIColor { return  UIColor(hex: 0x8B008B)}
    public static var deepSkyBlue : UIColor { return  UIColor(hex: 0x00BFFF)}
    public static var dimGray : UIColor { return  UIColor(hex: 0xA9A9A9)}
    public static var dodgerBlue : UIColor { return  UIColor(hex: 0x1E90FF)}
    public static var forestGreen : UIColor { return  UIColor(hex: 0x228B22)}
    public static var fireBrick : UIColor { return  UIColor(hex: 0xB22222)}
    public static var floralWhite : UIColor { return UIColor(hex: 0xFFFAF0)}
    public static var fuchsia : UIColor { return  UIColor(hex: 0xFF00FF)}
    public static var gainsboro : UIColor { return  UIColor(hex: 0xDCDCDC)}
    public static var greenYellow : UIColor { return  UIColor(hex: 0xADFF2F)}
    public static var gold : UIColor { return  UIColor(hex: 0xFFD700)}
    public static var goldenrod : UIColor { return  UIColor(hex: 0xDAA520)}
    public static var ghostWhite : UIColor { return  UIColor(hex: 0xF8F8FF)}
    public static var honeydew : UIColor { return  UIColor(hex: 0xF0FFF0)}
    public static var hotPink : UIColor { return  UIColor(hex: 0xFF69B4)}
    public static var indianRed : UIColor { return  UIColor(hex: 0xCD5C5C)}
    public static var indigo : UIColor { return  UIColor(hex: 0x4B0082)}
    public static var ivory : UIColor { return  UIColor(hex: 0xFFFFF0)}
    public static var khaki : UIColor { return  UIColor(hex: 0xF0E68C)}
    public static var lavender : UIColor { return  UIColor(hex: 0xE6E6FA)}
    public static var lawnGreen: UIColor { return UIColor(hex: 0x7CFC00)}
    public static var lavenderBlush : UIColor { return  UIColor(hex: 0xFFF0F5)}
    public static var lemonChiffon : UIColor { return  UIColor(hex: 0xFFFACD)}
    public static var lightGrey : UIColor { return  UIColor(hex: 0xD3D3D3)}
    public static var lightSlateGray : UIColor { return  UIColor(hex: 0x778899)}
    public static var lightCyan : UIColor { return  UIColor(hex: 0xE0FFFF)}
    public static var lightSeaGreen : UIColor { return  UIColor(hex: 0x20B2AA)}
    public static var lightSteelBlue : UIColor { return  UIColor(hex: 0xB0C4DE)}
    public static var lightBlue : UIColor { return  UIColor(hex: 0xADD8E6)}
    public static var lightSkyBlue: UIColor { return UIColor(hex: 0x87CEFA)}
    public static var lightGreen : UIColor { return  UIColor(hex: 0x90EE90)}
    public static var lightPink : UIColor { return  UIColor(hex: 0xFFB6C1) }
    public static var lightSalmon : UIColor { return  UIColor(hex: 0xFFA07A)}
    public static var lightCoral : UIColor { return  UIColor(hex: 0xF08080)}
    public static var lightYellow : UIColor { return  UIColor(hex: 0xFFFFE0)}
    public static var lightGoldenrodYellow : UIColor { return  UIColor(hex: 0xFAFAD2)}
    public static var limeGreen : UIColor { return  UIColor(hex: 0x32CD32)}
    public static var lime : UIColor { return  UIColor(hex: 0x00FF00)}
    public static var linen : UIColor { return  UIColor(hex: 0xFAF0E6)}
    public static var maroon : UIColor { return  UIColor(hex: 0x800000)}
    public static var mediumVioletRed : UIColor { return UIColor(hex: 0xC71585)}
    public static var mediumSpringGreen : UIColor { return  UIColor(hex: 0x00FA9A)}
    public static var mediumSeaGreen : UIColor { return  UIColor(hex: 0x3CB371)}
    public static var mediumAquamarine : UIColor { return  UIColor(hex: 0x66CDAA)}
    public static var mediumTurquoise : UIColor { return  UIColor(hex: 0x48D1CC)}
    public static var mediumBlue : UIColor { return  UIColor(hex: 0x0000CD)}
    public static var mediumOrchid : UIColor { return  UIColor(hex: 0xBA55D3)}
    public static var mediumPurple : UIColor { return  UIColor(hex: 0x9370DB)}
    public static var mediumSlateBlue: UIColor { return UIColor(hex: 0x7B68EE)}
    public static var midnightBlue : UIColor { return  UIColor(hex: 0x191970)}
    public static var mintCream : UIColor { return  UIColor(hex: 0xF5FFFA)}
    public static var mistyRose : UIColor { return  UIColor(hex: 0xFFE4E1)}
    public static var moccasin : UIColor { return  UIColor(hex: 0xFFE4B5)}
    public static var navy : UIColor { return UIColor(hex: 0x000080)}
    public static var navajoWhite : UIColor { return  UIColor(hex: 0xFFDEAD)}
    public static var paleVioletRed : UIColor { return  UIColor(hex: 0xDB7093)}
    public static var paleGoldenrod : UIColor { return  UIColor(hex: 0xEEE8AA)}
    public static var papayaWhip : UIColor { return UIColor(hex: 0xFFEFD5)}
    public static var paleGreen : UIColor { return  UIColor(hex: 0x98FB98)}
    public static var paleTurquoise : UIColor { return  UIColor(hex: 0xAFEEEE)}
    public static var peachPuff : UIColor { return  UIColor(hex: 0xFFDAB9)}
    public static var peru : UIColor { return  UIColor(hex: 0xCD853F)}
    public static var pink : UIColor { return UIColor(hex: 0xFFC0CB) }
    public static var plum : UIColor { return UIColor(hex: 0xDDA0DD)}
    public static var powderBlue : UIColor { return  UIColor(hex: 0xB0E0E6)}
    public static var oldLace: UIColor { return UIColor(hex: 0xFDF5E6)}
    public static var olive : UIColor { return  UIColor(hex: 0x808000)}
    public static var oliveDrab : UIColor { return  UIColor(hex: 0x6B8E23)}
    public static var orangeRed : UIColor { return  UIColor(hex: 0xFF4500)}
    public static var orchid : UIColor { return  UIColor(hex: 0xDA70D6)}
    public static var rebeccaPurple : UIColor { return  UIColor(hex: 0x663399)}
    public static var rosyBrown : UIColor { return  UIColor(hex: 0xBC8F8F)}
    public static var royalBlue : UIColor { return  UIColor(hex: 0x4169E1)}
    public static var salmon : UIColor { return  UIColor(hex: 0xFA8072)}
    public static var sandyBrown : UIColor { return  UIColor(hex: 0xF4A460)}
    public static var saddleBrown : UIColor { return UIColor(hex: 0x8B4513)}
    public static var seaGreen : UIColor { return  UIColor(hex: 0x2E8B57)}
    public static var seashell : UIColor { return  UIColor(hex: 0xFFF5EE)}
    public static var silver : UIColor { return  UIColor(hex: 0xC0C0C0)}
    public static var sienna : UIColor { return UIColor(hex: 0xA0522D)}
    public static var slateBlue : UIColor { return  UIColor(hex: 0x6A5ACD)}
    public static var slateGray : UIColor { return  UIColor(hex: 0x708090)}
    public static var springGreen : UIColor { return  UIColor(hex: 0x00FF7F)}
    public static var snow : UIColor { return  UIColor(hex: 0xFFFAFA)}
    public static var steelBlue : UIColor { return  UIColor(hex: 0x4682B4)}
    public static var skyBlue : UIColor { return  UIColor(hex: 0x87CEEB)}
    public static var tan : UIColor { return  UIColor(hex: 0xD2B48C)}
    public static var teal : UIColor { return  UIColor(hex: 0x008080)}
    public static var thistle : UIColor { return  UIColor(hex: 0xD8BFD8)}
    public static var tomato : UIColor { return  UIColor(hex: 0xFF6347)}
    public static var turquoise : UIColor { return  UIColor(hex: 0x40E0D0)}
    public static var violet : UIColor { return UIColor(hex: 0xEE82EE)}
    public static var wheat : UIColor { return  UIColor(hex: 0xF5DEB3)}
    public static var whiteSmoke : UIColor { return  UIColor(hex: 0xF5F5F5)}
    public static var yellowGreen : UIColor { return  UIColor(hex: 0x9ACD32)}
    
    //public static var red : UIColor { return  UIColor(hex: 0xFF0000)}
    //public static var orange : UIColor { return  UIColor(hex: 0xFFA500)}
    //public static var yellow : UIColor { return  UIColor(hex: 0xFFFF00)}
    //public static var brown : UIColor { return  UIColor(hex: 0xA52A2A)}
    //public static var green : UIColor { return  UIColor(hex: 0x008000)}
    //public static var blue : UIColor { return  UIColor(hex: 0x0000FF)}
    //public static var cyan : UIColor { return  UIColor(hex: 0x00FFFF)}
    //public static var magenta : UIColor { return UIColor(hex: 0xFF00FF)}
    //public static var white : UIColor { return  UIColor(hex: 0xFFFFFF)}
    //public static var purple : UIColor { return  UIColor(hex: 0x800080)}
    //public static var gray : UIColor { return  UIColor(hex: 0x808080)}
    //public static var darkGray : UIColor { return  UIColor(hex: 0x696969)}
    
    
    public static var amazonOrange : UIColor { return .rgb(red: 250, green: 153, blue: 47) }
    public static var bbciplayerDark : UIColor { return .rgb(red: 24, green: 27, blue: 34) }
    public static var bbciplayerWhiteGray : UIColor { return .init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0) }
    public static var bbciplayerPink : UIColor { return .init(red: 254, green: 70, blue: 150) }
    public static var facebookBlue : UIColor { return .rgb(red: 64, green: 90, blue: 150) }
    public static var linkedinBlue : UIColor { return .rgb(red: 17, green: 120, blue: 179) }
    public static var pinterestRed : UIColor { return .rgb(red: 187, green: 15, blue: 34) }
    public static var searchBarColor : UIColor { return .rgb(red: 197, green: 187, blue: 187) }
    public static var systemsBlueColor : UIColor { return .init(red: 0.0, green: 0.4784, blue: 1.0, alpha: 1.0) }
    public static var twitterBlue : UIColor { return .rgb(red: 42, green: 163, blue: 239) }
    public static var veryPink : UIColor { return .rgb(red: 220, green: 19, blue: 123) }
    public static var vimeoBlue : UIColor { return .rgb(red: 29, green: 174, blue: 236) }
    public static var yahooPurple : UIColor { return .rgb(red: 71, green: 21, blue: 172) }
    public static var youtubeRed : UIColor { return .rgb(red: 252, green: 13, blue: 28) }
    public static var shadowGray: UIColor { return .rgb(red: 230, green: 230, blue: 230) }
    
    
    public static var topMenuRedColor: UIColor {
        return UIColor.rgb(red: 230, green: 32, blue: 31)
    }
    
    public static var nonSelectedColor: UIColor {
        return UIColor.rgb(red: 91, green: 14, blue: 13)
    }
    
    public var getTextColor: UIColor {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        _ = self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r<0.8 && g<0.8 && b<0.8) ? UIColor.white : UIColor.black
    }
    
    public var recommendedTextColor : UIColor {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        _ = self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r<0.8 && g<0.8 && b<0.8) ? UIColor.white : UIColor.black
    }
    
    public static var random : UIColor {
        return UIColor(red:   .rand(),
                       green: .rand(),
                       blue:  .rand(),
                       alpha: 1.0)
    }
    
    public var inverse: UIColor {
        return UIColor(red: 1.0 - self.redValue,
                       green: 1.0 - self.greenValue,
                       blue: 1.0 - self.blueValue,
                       alpha: self.alphaValue)
    }
    
    public  var redValue: CGFloat {
        return cgColor.components! [0]
    }
    
    public  var greenValue: CGFloat {
        return cgColor.components! [1]
    }
    
    public var blueValue: CGFloat {
        return cgColor.components! [2]
    }
    
    public var alphaValue: CGFloat {
        return cgColor.components! [3]
    }
    
    public var rgbValues : (r:CGFloat, g:CGFloat,b:CGFloat, a:CGFloat){
        return (r:redValue, g:greenValue, b: blueValue, a:alphaValue)
    }
    
    public var components : ColorComponents {
        if (self.cgColor.numberOfComponents == 2) {
            let cc = self.cgColor.components;
            return ColorComponents(r:cc![0], g:cc![0], b:cc![0], a:cc![1])
        }
        else {
            let cc = self.cgColor.components;
            return ColorComponents(r:cc![0], g:cc![1], b:cc![2], a:cc![3])
        }
    }
    
    /// The RGBA components associated with a `UIColor` instance.
    public var colorComponents: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        let components = self.cgColor.components!
        
        switch components.count == 2 {
        case true : return (r: components[0], g: components[0], b: components[0], a: components[1])
        case false: return (r: components[0], g: components[1], b: components[2], a: components[3])
        }
    }
    
    public static func interpolateRGBColorWithWhite(start:UIColor,end:UIColor, fraction:CGFloat) -> UIColor
    {
        var f = max(0, fraction)
        f = min(1, fraction)
        
        let c1 = start.components
        let c2 = end.components
        
        let r: CGFloat = CGFloat(c1.r + (c2.r - c1.r) * f)
        let g: CGFloat = CGFloat(c1.g + (c2.g - c1.g) * f)
        let b: CGFloat = CGFloat(c1.b + (c2.b - c1.b) * f)
        let a: CGFloat = CGFloat(c1.a + (c2.a - c1.a) * f)
        
        return UIColor.init(red: r, green: g, blue: b, alpha: a)
    }
    
    public static func interpolate(from fromColor: UIColor, to toColor: UIColor, with progress: CGFloat) -> UIColor {
        let fromComponents = fromColor.colorComponents
        let toComponents = toColor.colorComponents
        
        let r = (1 - progress) * fromComponents.r + progress * toComponents.r
        let g = (1 - progress) * fromComponents.g + progress * toComponents.g
        let b = (1 - progress) * fromComponents.b + progress * toComponents.b
        let a = (1 - progress) * fromComponents.a + progress * toComponents.a
        
        return UIColor.init(red: r, green: g, blue: b, alpha: a)
    }
   
    public static func segmentColor(speed: Double,
                                    midSpeed: Double,
                                    slowestSpeed: Double,
                                    fastestSpeed: Double) -> UIColor {
        enum BaseColors {
            static let r_red: CGFloat = 1
            static let r_green: CGFloat = 20 / 255
            static let r_blue: CGFloat = 44 / 255
            
            static let y_red: CGFloat = 1
            static let y_green: CGFloat = 215 / 255
            static let y_blue: CGFloat = 0
            
            static let g_red: CGFloat = 0
            static let g_green: CGFloat = 146 / 255
            static let g_blue: CGFloat = 78 / 255
        }
        
        let red, green, blue: CGFloat
        
        if speed < midSpeed {
            let ratio = CGFloat((speed - slowestSpeed) / (midSpeed - slowestSpeed))
            red = BaseColors.r_red + ratio * (BaseColors.y_red - BaseColors.r_red)
            green = BaseColors.r_green + ratio * (BaseColors.y_green - BaseColors.r_green)
            blue = BaseColors.r_blue + ratio * (BaseColors.y_blue - BaseColors.r_blue)
        } else {
            let ratio = CGFloat((speed - midSpeed) / (fastestSpeed - midSpeed))
            red = BaseColors.y_red + ratio * (BaseColors.g_red - BaseColors.y_red)
            green = BaseColors.y_green + ratio * (BaseColors.g_green - BaseColors.y_green)
            blue = BaseColors.y_blue + ratio * (BaseColors.g_blue - BaseColors.y_blue)
        }
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    /**
     Returns a hex equivalent of this UIColor.
     
     - Parameter includeAlpha:   Optional parameter to include the alpha hex.
     
     color.hexDescription() -> "ff0000"
     
     color.hexDescription(true) -> "ff0000aa"
     
     - Returns: A new string with `String` with the color's hexidecimal value.
     */
    private func hexDescription( _ withAlpha: Bool = false) -> String {
        guard self.cgColor.numberOfComponents == 4 else {
            return "Color not RGB."
        }
        let a = self.cgColor.components!.map { Int($0 * CGFloat(255)) }
        let color = String.init(format: "%02x%02x%02x", a[0], a[1], a[2])
        if withAlpha {
            let alpha = String.init(format: "%02x", a[3])
            return "\(color)\(alpha)"
        }
        return color
    }
    
    public func hexDescription(withHash : Bool, includingAlpha: Bool = false) -> String {
        let hexDescription = self.hexDescription(includingAlpha)
        return withHash ? "#" + hexDescription : hexDescription
    }
    
    public var toHexString : String {
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
    
    fileprivate enum UIColorMasks: CUnsignedInt {
        case redMask    = 0xff000000
        case greenMask  = 0x00ff0000
        case blueMask   = 0x0000ff00
        case alphaMask  = 0x000000ff
        
        static func redValue(_ value: CUnsignedInt) -> CGFloat {
            return CGFloat((value & redMask.rawValue) >> 24) / 255.0
        }
        
        static func greenValue(_ value: CUnsignedInt) -> CGFloat {
            return CGFloat((value & greenMask.rawValue) >> 16) / 255.0
        }
        
        static func blueValue(_ value: CUnsignedInt) -> CGFloat {
            return CGFloat((value & blueMask.rawValue) >> 8) / 255.0
        }
        
        static func alphaValue(_ value: CUnsignedInt) -> CGFloat {
            return CGFloat(value & alphaMask.rawValue) / 255.0
        }
    }
    
    fileprivate static func normalize(_ hex: String?) -> String {
        guard var hexString = hex else {
            return "00000000"
        }
        if let cssColor = ColorsCSS.cssToHexDictionairy[hexString.uppercased()] {
            return cssColor.count == 8 ? cssColor : cssColor + "ff"
        }
        if hexString.hasPrefix("#") {
            hexString = String(hexString.dropFirst())
        }
        if hexString.count == 3 || hexString.count == 4 {
            hexString = hexString.map { "\($0)\($0)" }.joined()
        }
        let hasAlpha = hexString.count > 7
        if !hasAlpha {
            hexString += "ff"
        }
        return hexString
    }
    
    /**
     All modern browsers support the following 140 color names (see http://www.w3schools.com/cssref/css_colornames.asp)
     */
    fileprivate static func hexFromCssName(_ cssName: String) -> String {
        let key = cssName.uppercased()
        if let hex = ColorsCSS.cssToHexDictionairy[key] {
            return hex
        }
        return cssName
    }
    
    public static func cssNameFromHex(_ hexValue: String?) -> String {
        guard var hexString = hexValue else {
            return "00000000"
        }
        if hexString.hasPrefix("#") {
            hexString = String(hexString.dropFirst())
        }
        return ColorsCSS.cssToHexDictionairy.firstKeyForValue(forValue: hexString.uppercased()) ?? "1"
    }
    
    public static var colorNamesFromCSSLibrary: [String] {
        return ColorsCSS.cssToHexDictionairy.map { $0.key }.sorted()
    }
    
}
