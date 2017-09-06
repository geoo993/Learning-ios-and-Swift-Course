
import Foundation


//closure syntax. 

/*
 we use the array method .map, which executes
 a given closure over all values in the array.
 The signature is map(<#transform: (T) -> U##(T) -> U#>)
 */

var ints = [1, 2, 3, 4]

let timesTwo = ints.map( { (a:Int) -> Int in return a * 2 } )

print("ints: \(ints), times 2:\(timesTwo)")

//since the types are inferred from the context, 
//we can omit the type from the closure's param list:
let timesThree = ints.map( { (a) -> Int in return a * 3 } )

print("ints: \(ints), times 3:\(timesThree)")

//the same is true for the return type:
let timesFour = ints.map( { (a) in a * 4 } )

print("ints: \(ints), times 4:\(timesFour)")

//we can also use positionally named parameters:
let timesFive = ints.map( { $0 * 5 } )

print("ints: \(ints), times 5:\(timesFive)")

/*
 declare a function that takes a closure as a parameter:
 */

func smallestInt(_ intArray:[Int], _ smallest:(Int, Int) -> Bool) -> Int {
    var retVal = intArray[0]
    var smallestOfTwo = 0 
    for i in 0 ..< intArray.count - 1 {
        if smallest(intArray[i], intArray[i+1]) {
            smallestOfTwo = intArray[i]
        } else {
            smallestOfTwo = intArray[i+1]
        }
        
        if smallestOfTwo < retVal {
            retVal = smallestOfTwo
        }
    }
    return retVal
}
//////////////-3, -3,-3 -11 -11, -11
let myInts1 = [2, -3, 9, 81, -11, 4]
let least1 = smallestInt(myInts1, {(a:Int, b:Int) -> Bool in
    if a<b { return true}
    else {return false}
})
print("least with detailed closure \(least1)")

///////////////-4, -4, -4 -4 -4, -4
let myInts2 = [22, -4, 19, 1, 11, 4]
let least2 = smallestInt(myInts2, { (a, b) in a < b })
print("least with less detailed closure \(least2)")

///////////////12, 1, -21 -21 -21, -21
let myInts3 = [12, 32, 1, -21, -2, 92]
let least3 = smallestInt(myInts3, { $0 < $1 })
print("least with positional parameters in closure \(least3)")

///////////////12, 1, -21 -21 -21, -21
let myInts4 = [31, 2, -6, -39, -1, -12]
let least4 = smallestInt(myInts4, <)
print("least with with < as the closure \(least4)")

func biggestInt(_ intArray:[Int], _ biggest:(Int, Int) -> Bool) -> Int {
    var retVal = 0
    var biggerOfTwo:Int!
    for i in 0 ..< intArray.count - 1 {
        if biggest(intArray[i], intArray[i+1]) {
            biggerOfTwo = intArray[i]
        } else {
            biggerOfTwo = intArray[i+1]
        }
        if retVal < biggerOfTwo {
            retVal = biggerOfTwo
        }
    }
    return retVal
}

let aBunchOfInts = [45, 23, 264, 3, -9, 57]

//use the function to find the biggest int in an array:
//full syntax
let h = biggestInt(aBunchOfInts, { (a:Int, b:Int) -> Bool in
    if a>b {return true} else {return false}
})

//the parameter types are known, as is the return type
let i = biggestInt(aBunchOfInts, { (a, b) in return a > b} )

//even shorter with positionally named parameters
let j = biggestInt(aBunchOfInts, { $0 > $1 } )

//with the > operator function, we can get even shorter:
//Classes and structures can define functions to overload operators. 
//we'll talk about that in the next unit.
let k = biggestInt(aBunchOfInts, >)

print("The biggest Int in aBunchOfInts is \(k)")

