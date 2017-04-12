// EDUMobile1
/*
 variables, constants, implicit and explicit
 typing, strings
 */

import UIKit

//variables and constants

var version = 7     //use variables for values that will be changed
let os = "iOS"      //use constants for everything else!

version = 8

var fullVersion = os + " " + String(version)

//explicit typing

var amount:Double = 3.5
var newAmount = amount + 7
Int(amount)

var tomorrow : CGFloat = 0.6

//strings

for character in fullVersion.characters {
    var c = character
}

//string interpolation

fullVersion = "\(os) \(version)"