import Foundation

public extension Double {
    
    // https://nssdc.gsfc.nasa.gov/planetary/factsheet/earthfact.html
    // https://astronomy.stackexchange.com/questions/18838/is-it-same-distance-equator-prime-meridian/18841#18841
    // https://www.space.com/17638-how-big-is-earth.html
    
    public static var earthsEquatorialRadius: Measurement<UnitLength> {
        return Measurement(value: 6378.137, unit: UnitLength.kilometers)
    }
    
    public static var earthsEquatorialRadiusKiloMeters: Double {
        return earthsEquatorialRadius.value
    }
    
    public static var earthsEquatorialRadiusMeters: Double {
        return earthsEquatorialRadius.converted(to: .meters).value
    }
    
    private static var earthsPolarRadius: Measurement<UnitLength> {
        return Measurement(value: 6356.752, unit: UnitLength.kilometers)
    }
    public static var earthsPolarRadiusKiloMeters : Double {
        return earthsPolarRadius.value
    }
    public static var earthsPolarRadiusMeters : Double {
        return earthsPolarRadius.converted(to: .meters).value
    }
    
    public var metersToLatitude : Double {
        return self / (Double.earthsEquatorialRadiusMeters) // (6360500.0) Dividing EARTH EQUATORIAL RADIUS
    }
    
    public var metersToLongitude : Double {
        return self / (Double.earthsPolarRadiusMeters)     // (5602900.0) Dividing EARTH POLAR RADIUS
    }
    
    public static var degToRad : Double { return 0.017453292519943295769236907684886 }

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

    /// Convert a Double to Int
    public var toInt: Int {
        return Int(self)
    }

    public var toCGFloat: CGFloat {
        return CGFloat(self)
    }
    
    public func percentageValueBetween(maxValue: Double, minValue: Double = 0) -> Double {
        let difference: Double = (minValue < 0) ? maxValue : maxValue - minValue
        return (Double(100) * ((self - minValue) / difference))
    }
}
