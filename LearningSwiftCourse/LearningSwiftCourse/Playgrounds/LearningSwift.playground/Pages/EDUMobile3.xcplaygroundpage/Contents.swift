// EDUMobile3 - Optionals

import UIKit

var pi: CGFloat?
pi = 3.142

var number: Int? ////in swift, nil has the meaning of nothing
number = 7

/*
 variables and constants must be initialized
 before they are used. Here, number is "nil,"
 but we can't check for that in an if statement
 as below:
 */

if (number != nil) {
    "number has a value: \(number)"
} else {
    "number is not initialized: \(number)"
}

/*
 Optionals are a way of defining a type that may either
 have a value (of that type) or no value at all.
 
 Optionals may be of any scalar (Int, Double, CGFloat, String, Bool) or class type.
*/

/*
 once you are sure an optional has a value, use the !
 operator to show the value. This is called "unwrapping"
 the optional:
 */
var amount:Double? = 2.54

if (amount != nil)
{
    amount
} else {
    amount = 3.53
}

amount!//! the bang operator to unwrap the nil

/*
 toInt() returns an Int? type.
 */

var str:String = "One Hundred"

let intValue = Int(str)
if (intValue != nil) {
    intValue!   //unwrapping with bang operator
} else {
    "Cannot convert \"\(str)\" to an integer"
}

/*
 let can be used with if to determine if an optional 
 has a value (this is equivalent to the last example), 
 but note that we don't have to unwrap the optional:
 */

if let intValue = Int(str) {//if let is still a boolean expresion, we get automatic unwrapping of the value
    intValue    //no need to unwrap with the "to let..." syntax
} else {
    "Cannot convert \"\(str)\" to an integer"
}


/*
 If you know that an optional will contain a value
 before it is used, you can declare it as an implicitly
 unwrapped optional with !
 */

var myFloat:Float!
var myOtherFloat:Float?

myFloat = 53
myOtherFloat = 35
myOtherFloat!
