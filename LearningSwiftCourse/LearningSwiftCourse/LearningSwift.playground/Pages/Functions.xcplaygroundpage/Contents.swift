//: [Previous](@previous)

import Foundation
import UIKit

//function with no parameters and no return value:
func sayHi() {
    print("Hello, Swift!")
}

sayHi()

//a func that returns no value:
func printInt(a:Int) {
    print("the value of \(#function)'s parameter is \(a)")
}

//a func that returns no value:
func printInteger(_ a:Int) {
    print("the value of \(#function)'s parameter is \(a)")
}

//a func that returns an Int:
func neg(a:Int) -> Int {
    return -a
}

//adds two Ints, returns an Int:
func add(a:Int, b:Int) -> Int {
    return a + b
}

//uses its parameter as a counter:
func countDown(count:Int) -> Int {
    var tempCount = count
    repeat {
        tempCount -= 1
        print("counting down: \(tempCount)")
    } while tempCount > 0
    
    return tempCount
}

//swaps two Ints passed by reference:
func swap(a:inout Int, b: inout Int) {
    let temp = a
    a = b
    b = temp
}

//returns a function. () -> Int is the type
//of the returned function:
func abs(a:Int) -> () -> Int {
    
    func positive() -> Int {
        return a
    }
    
    func negative() -> Int {
        return -a
    }
    
    if a >= 0 {
        return positive
    } else {
        return negative
    }
}


//test the above functions
var num1 = 3
var num2 = 5

print("num1 is \(num1), num2 is \(num2)")

printInt(a:num1)

printInteger(neg(a:num1))

printInteger(add(a:num1, b:4))

countDown(count: num1)

print("num1 is \(num1), num2 is \(num2)")

swap(&num1, &num2)

print("after swap, num1 is \(num1), num2 is \(num2)")

print("the absolute value of \(num1) is \(abs(num1))")
print("the absolute value of \(-num2) is \(abs(-num2))")

print("stop here")

//shows the use of function type to "copy" a function:

/*  f's type is "a function that takes two Ints as parameters and
 returns an Int."
 */
var f:(Int, Int) -> Int

//  assign f to the add function
f = add

//  now we can use f in the place of add:
print("3 + 5 = \(f(3, 5))")

//default parameter. Default parameter names are 
//external!:
func raise(a:Int, toThePower:Int = 2) -> Int {
    var i:Int
    var power:Int = 1
    for i in 0 ..< toThePower {
        
        power = a * power
    }
    return power
}

var result = raise(a:5)
print(result)

//we must use the parameter name here:
result = raise(a:5, toThePower: 3)
print(result)


//variadic parameter:
func findMaxOf(integers:UInt16...) -> UInt16 {
    var max:UInt16 = 0
    for integer in integers {
        if integer > max {
            max = integer
        }
    }
    return max
}

var maximum = findMaxOf(integers: 2, 5, 4, 3, 9, 1, 0, 8)

print(maximum)