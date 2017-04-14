//EDUMobile4 - Functions

import UIKit

// a function with no arguments or parameters, returns nothing:
func sayHi() {
    "Hello, Swift!"
}

//call the function:
sayHi()

//parameters naming
func title1(titlename:String) {//the parameter name when called will be 'titlename' and will also be referred to in the function as \(titlename) which is the both the local and external parameter name
    "title name is \(titlename)"
}
title1(titlename: "Hobbit part 1")

func title2(name titlename:String) {//the external parameter name when called will be 'name', and the 'titlename is the local parameter name which is used within the function'
    "title name is \(titlename)"
}
title2(name: "Hobbit part 2")//the parameter name is not titlename but 'name'

//parameters naming
func title3(_ titlename:String) {// the _ make allows to not specify the external parameter name when called, here the local parameter name is still titlename which must be specified
    "title name is \(titlename)"
}
title3("Hobbit part3")//without external parameter name

//use the arrow (->) operator to declare the return type:
func mult(a:Int, b:Int) -> Int {
    return a * b
}

var c = mult(a: 5, b: 3)


//funtion parameters are constants by default, and are passed by value:

func sub(a:Int = 5, b:Int = 2 ) -> Int {//we can specify default value a = 0, b = 2
    //to modify a parameter inside a function, passed
    //create a temporary copy
    var ta = a
    
    //b here is a constant because it is a constant let by default
    ta = ta - b;
    
    return ta
}

var aa = 5, bb = 7
sub()//the default values are working without us passing in any value
sub(a:aa,b:bb)
aa

//to pass a parameter by reference, use the "inout"
func swap(a:inout Int,b: inout Int) {
    let temp:Int = a
    a = b
    b = temp
}

//use the & operator to pass inout parameters:
var x = 7, y = 4
"x = \(x). y = \(y)"
swap(&x, &y)
"x = \(x). y = \(y)"

/*
    Swift allows us to return multiple values from a 
    function, in the form of a tuple. For example:
 */

func squareAndCube(_ a:Int) -> (square:Int, cube:Int)
{
    return (a*a, a*a*a)
}
 
let value = squareAndCube(3)
value.square
value.cube

/*
    what is the type of a function.
    well it is not just the return type.
    it is the entire declaration of the function,
    minus any names that we have, so the type
    of a function consists of both its parameter
    list and its return value with the arrow
 */

/*
    The type of a function consists of its parameter list
    and return value. For example, the type of both the multiply
    and divide functions below is (Double, Double) -> Double.
    A function type can be used anywhere any type can be used:
 */

func multiply(a:Double, b:Double) -> Double {
    return a * b
}

func divide(a:Double, b:Double) -> Double {
    return a / b
}

//someFunction is a type (Double, Double) -> Double:
var someFunction:(Double, Double) -> Double

someFunction = multiply //assigning multiply to someFunction
var product = someFunction(4, 12)// using the muliply function
someFunction = divide //assigning divide to someFunction
var quotient = someFunction(4, 12) // using the divide function

//function can return a function and define functions, by returning its type
//we can define functions inside their own scope
//this is a function that returns a function type which takes no parameters and returns a boolean
func zeroIfNotEven (a:Int) -> () -> Bool
{
    
    func odd() -> Bool {
        return false
    }
    
    func even() -> Bool {
        return true
    }
    
    if a % 2 == 0 {
        return even
    }else{
        return odd
    }
}

//result is a function of type no parameters and return an Int () -> Int
let result = zeroIfNotEven(a: 5)
if result(){
    "It must have been even"
}else{
    "It must have been odd"
}

/*
    When calling a function. parameter names
    must be explicitely specified by defualt in function call:
 */

multiply(a:5,b:6)

// if we want to force a parameter to be named
// in the call, we can include an external
// parameter name before the local parameter name

func increased(a:inout Int, by b:Int){// by is the external parameter name and b is the local parameter name
    a = a + b
}

var foo = 5
increased(a: &foo, by: 2)


//we can also make a parameter have a default value.
//Swift automatically provides a required external parameter name for these

func max(_ values: [Int], label:String = "Maximum = ") -> String
{
    var maxValue = 0
    for value in values {
        if value > maxValue { maxValue = value }
    }
    return "\(label) \(maxValue)"
}

let m = max([45, 23, 78, 62])// here we are not giving this a new label, because we already set the defualt value in the max function
let m2 = max([45, 23, 78, 62], label: "Amazing = ")// here we are setting the label and overriding the defualt value

