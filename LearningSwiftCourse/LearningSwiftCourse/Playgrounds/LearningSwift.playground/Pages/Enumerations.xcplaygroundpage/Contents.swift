//: [Previous](@previous)

import Foundation

//enumerations, structures and classes in swift, share some very important concepts
//in Swift, an enum relates a type to a group of values, maintaning type safety
//Swift enums don't have to have a value for every member./* code */
//If they do, the value can be of type String, Character, any Int type, or any Double type
//values provided to members of an enum are known as "raw" values
//in Swift, enums (and structs) are value types and not classes. Classes in Swift are reference types
//when a value type is assigned or passed to a function, its value is copied
//enumerations (like classes and structures) can have instance methods
//in the case of enumerations, one use of instance methods is to change (or mutate) 
//the currently selected member of the enumeration.
//A mutating method is one that changes the value of self in the enumeration (in this particular case)


/*
 define an enum that models a stop light:
 */

enum StopLight {
    case Red, Green, Amber
    
    mutating func change() {// mutating allows us to modify self
        switch self {//self is referring to stoplight 
        case .Red: self = .Green
        case .Green: self = .Amber
        case .Amber: self = .Red
        }
    }
    
    func member() -> String {
        switch self {
        case .Red: return "Red"
        case .Green: return "Green"
        case .Amber: return "Amber"
        }
    }
    
}

//make a stop light, change and inspect its state:
var intersection = StopLight.Red
intersection.member()

intersection.change()
intersection.member()

intersection.change()
intersection.member()

intersection.change()
intersection.member()

/*
 define an enum that models And and Or gates:
 */

enum Gate {
    case And, Or
    
    func evaluateForA(inA:Bool, B:Bool) -> Bool {
        var retVal = false
        switch self {
        case .And:
            if inA && B {retVal = true}
        case .Or:
            if inA || B {retVal = true}
        }
        return retVal
    }
}

var andGate = Gate.And
var orGate = Gate.Or

/*
 By default, in Swift methods, all parameters after the 
 first have an "Implied" external parameter name by default:
 */
andGate.evaluateForA(inA: false, B:true)
orGate.evaluateForA(inA: false, B:false)

/*
 An example with associated values:
 */

enum Shape {
    //this is called a computed property. Enums cannot
    //have stored properties, but structs and classes can.
    var pi:Double {
        get {
            return 3.14159
        }
        set {
            newValue
        }
       
    }
    
    case Circle((Double, Double), Double) // (x, y), radius
    case Rectangle(Double, Double)        // length, width
}

func area(shape:Shape) -> Double {
    var tempShape = shape
    switch tempShape {
    case let .Circle((x, y), radius):
        //tempShape.pi = 5.0
        print("x:\(x), y:\(y) and radius:\(radius) with pi \(tempShape.pi)")
        return tempShape.pi * radius * radius
    case let .Rectangle(width, height):
        print("width:\(width) and height:\(height)")
        return width * height
    }
}

var myShape = Shape.Circle((2, 5), 3)
area(shape: myShape)

myShape = Shape.Rectangle(4, 9)
area(shape: myShape)

/*
 example with raw values. Enums with raw values must
 be typed as the raw value type:
 */

enum Days:Int {
    //we set sunday to 1 making the enum start from 1 and so on. this is because sunday is the first value and it changes the rest of the values. if we dont set sunday to one it will by default start with 0 and the rest continues incrimenting
    case Sunday = 1, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
}

var weekDay = Days.Thursday.rawValue //get raw value
var mightBeAValidDay = Days.init(rawValue: 5)  //get element with raw value, mightBeADay is an Optional
