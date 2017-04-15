//: [Previous](@previous)

import Foundation

class Length {
    
    //properties only run when we set them with getters and setters
    //and not when we set them from initialisers
    
    //a stored property with a set property observer
    var inches:Double {
        willSet {
            "setting inches to \(newValue)"
        }
    }
    
    //a calculated property that also sets the value of a 
    //stored property
    var centimeters:Double {
        get {
            return inches * 2.54
        }
        set {
            //newValue is the parameter of set if we do not supply one
            inches = newValue / 2.54
        }
//        set (incomingValue) {
//            //here new newValue is changed by incomingValue, which is what we are supplying as paramenter name for it
//            inches = incomingValue / 2.54
//        }
    }
    
    //the feet and meters getters takes other properties
    //so calculated properteis can be very powerful and they can save you from
    //from actually storing properties in your classes and structures
    
    var feet:Double {
        get {
            return inches / 12
        }
    }
    
    var meters:Double {
        get {
            return centimeters / 100
        }
    }
    
    init() {
        inches = 0.0
    }
    
    init(inches:Double) {
        self.inches = inches
    }
}

var distance = Length(inches: 54)
distance.centimeters = 57
distance.inches
distance.meters
distance.feet

