import Foundation

//STRUCTURES
struct Complex {
    
    var realPart:Double
    var imaginaryPart:Double
    
    //At least one inititalizer is required, 
    //the stored properties realPart and imaginaryPart
    //are not initialized in their declarations, above.
    
    //no-arg initializer
    init() {
        realPart = 0.0
        imaginaryPart = 0.0
    }
    
    //initializer that sets realPart and imaginaryPart
    init(real:Double, imaginary:Double) {
        realPart = real
        imaginaryPart = imaginary
    }
    
    //prints the number as a + bi
    func prettyPrint() -> String {
        if imaginaryPart < 0.0 {
            return "\(realPart) - \(-imaginaryPart)i"
        } else {
            return "\(realPart) + \(imaginaryPart)i"
        }
    }
    
    //type method that returns the sum of two complex numbers
    // ( a + bi) + (c + di) = ( (a + c) + (b + di) )
    static func add(a:Complex, to:Complex) -> Complex {
        var c = Complex()
        c.realPart = a.realPart + to.realPart
        c.imaginaryPart = a.imaginaryPart + to.imaginaryPart
        return c
    }
    
    //type method that returns the product of two complex numbers
    // (a + bi)(c + di) = ac + adi + cbi + bdi^2
    static func multiply(a:Complex, with:Complex) -> Complex {
        var c = Complex()
        c.realPart = a.realPart * with.realPart +
            a.imaginaryPart * with.imaginaryPart * -1
        c.imaginaryPart = a.realPart * with.imaginaryPart +
            a.imaginaryPart * with.realPart
        return c
    }
    
}

//two instances of Complex:
let test1 = Complex(real: 3.3, imaginary: -2.4)
let test2 = Complex(real: 2.4, imaginary: 3.4)

//print them out:
test1.prettyPrint()
test2.prettyPrint()

//add them
let sum = Complex.add(a: test1, to: test2)
sum.prettyPrint()

//multiply them
let product = Complex.multiply(a: test1, with: test2)
product.prettyPrint()

//let structures are immutable
//test1.realPart = 5.2

//notice the copy behavior. test3 is a mutable shallow copy of test1:
var test3 = test1
test3.prettyPrint()

//changing a value in test3 doesn't alter test1. Structures are value types.
test3.realPart = 4.26
test1.prettyPrint()
