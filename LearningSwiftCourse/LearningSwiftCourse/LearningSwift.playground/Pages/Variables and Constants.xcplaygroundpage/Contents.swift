//: [Previous](@previous)


import Foundation

//count is a variable, max is a constant:
var count = 0           //inferred to be Int
let max:UInt8 = 10      //annotated as an unsigned 8 bit Integer

repeat {
    count += 1
    print("count: \(count)")
} while count < Int(max)

/*
 There is no implicit type casting in Swift. The above 
 while clause will not work without converting max to an
 Int or count to a UInt8. 
 
 To convert a type to another type, use the new type's 
 constructor, for example UInt8(count) or Int(max).
 
 This points out that "primitive" types in Swift are
 implemented as class types.
 */

var waterTemp = -50.0        //inferred as Double
let freezing:Float = 0      //annotated as Float
let boiling:Float = 100     //    "     "   "

var state = ""              //inferred as String
if Float(waterTemp) <= freezing { state = "Solid" }
else if Float(waterTemp) >= boiling { state = "Gas" }
else { state = "Liquid" }

print("\nWater at \(waterTemp)° C is a \(state).")

let firstCharOfState = state[state.startIndex]
print("\nFirst character of state is \(firstCharOfState)")
