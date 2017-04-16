//: [Previous](@previous)

import Foundation

// Protocol demo

import UIKit

//a method that we might need in several types, 
//protocols are like abstract classes from c++
//declared in a protocol:
protocol Scalable {
    func scaleBy(value:Double) -> Any
}

//types that adopt the protocol must define
//all required methods:

struct Scalar : Scalable {
    var value:Double
    
    init(value:Double) {
        self.value = value
    }
    
    func scaleBy(value: Double) -> Any {
        return self.value * value
    }
}

struct Matrix1D : Scalable {
    var matrix:[Double]
    var matrix3x3:[Double]
    
    init(matrix:[Double], matrix3x3:[Double]) {
        self.matrix = matrix
        self.matrix3x3 = matrix3x3
    }
    
    //define a subscript of self, which is Matrix1D:
    subscript (index:Int) -> Double {
        //read only, get not required:
        return matrix[index]
    }
    
//    subscript (idx:Int) -> Double {
//        //read only, get not required:
//        return matrix3x3[idx]
//    }
  
    func scaleBy(value: Double) -> Any {
        var product:[Double] = Array()
        for i in 0 ..< matrix.count {
            product.append(matrix[i] * value)
        }
        return product
    }
 
}

let myScalar = Scalar(value: 4)
let myMatrix = Matrix1D(matrix: [1.0, 2.0, 3.0, 4.0],matrix3x3: [6.0, 7.0])

myScalar.scaleBy(value: 3)
myMatrix.scaleBy(value: 4)

myMatrix[3]//subscript in action, this is 4.0 from myMatrix
myMatrix[1]//subscript in action, this is 2.0 from myMatrix


protocol MyProtocol{
    /*
     A get - set protperty that may be
     implemented either as a stored or
     computed property:
     */
    var getSetProperty: Int { get set }
    
    /* A get - only property that must be computed: */
    var getOnlyProperty:Float { get }
    
    //there is no such thing as a set only property
    //but we can have get set, or get
    
}




//EXTENSIONS
//An extension adds functionality to any existing class.
//we can extend both our own classes, and classes for which we do not have the source code
//extensions may add:
//1-computed and static compted properties
//2-instnace and type methods
//3-new initializers
//4-subscripts
//5-new nsted types
//6-protocol conformance for an existing type
/*
    //Extensions do not have names, they refer to types only:
    extension MyType {
        //...an extension to the MyType type
    }
    //Extensions may not add stored properties or property observers to a type
 */


//SUBSCRIPTS
//Subscripts allow intance types to be quired by using s square bracket syntax
//Subscripts syntax is similar to both instance method and computed property syntax:
/*
subscript(pName:Type) -> Type {
    get{ //return a value }
    set{ //set a value  }
}
 */
//if a subscript or calculated property is read-only, the get can be dropped
//Example of subscript
struct Vector {
    var direction:Double
    var magnitude:Double
    
    //initializer, etc...
    subscript(index:String) -> Double {
        
        switch index {
            case "r" : return magnitude
            case "θ" : return direction
            default : return 0.0
        }
    }
    
    
}

let pi = 3.142
let v = Vector(direction: 3.2, magnitude: pi / 3)
print("\(v["r"]), \(v["θ"])")


