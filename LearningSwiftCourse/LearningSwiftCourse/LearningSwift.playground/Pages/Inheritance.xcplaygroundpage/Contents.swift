// Inheritance and copy behavior of reference types:

import Foundation

class Point {
    var x:Double
    var y:Double
    
    init(x:Double, y:Double) {
        self.x = x
        self.y = y
    }
}

class Line {
    var start:Point
    var end:Point
    
    //from: is a tuple, to: is a tuple
    init(from:(Double, Double), to:(Double, Double)) {
        start = Point(x:from.0, y:from.1)
        end = Point(x:to.0, y:to.1)
    }
}

class MathLine : Line {
    var length:Double {
        get {
            return sqrt(pow((start.x-end.x), 2) + pow((start.y - end.y), 2))
        }
    }
    
    var slope:Double {
        get {
            return (start.y - end.y) / (start.x - end.x)
        }
    }
    
    //provide a method that returns a new instance (shallow copy)
    func copy() -> MathLine {
        let newLine = MathLine(from: (start.x, start.y), to: (end.x, end.y))
        return newLine
    }
}

let myLine = MathLine(from: (2, 5), to: (6, 8))

myLine.length
myLine.slope
myLine.start
myLine.end

// as here is performing an upcast,
var noMathLine = myLine as Line

noMathLine.start
noMathLine.end

//is noMathLine a shallow copy?
noMathLine.start = Point(x: 5, y: 3)
noMathLine.start
myLine.start

//no! noMathLine is a reference to myLine.

//get a shallow copy:
var someOtherLine = myLine.copy() as Line
myLine.start
someOtherLine.start
someOtherLine.start = Point(x: 9, y: -7)
myLine.start
someOtherLine.start



//SIMPLE INHERITANCE
class Simple {
    
    init() { print("init method called in base") }
    
    class func one() {print("class - one()")}
    
    class func two() {print("class - two()")}
    
    static func staticOne() { print("staticOne()") }
    
    static func staticTwo() { print("staticTwo()") }
    
    final func yesFinal() { print("yesFinal()") }
    
    static var myStaticVar = "static var in base"
    
    //Class stored properties not yet supported in classes; did you mean 'static'?
    //class var myClassVar1 = "class var1"
    
    //This works fine
    class var myClassVar: String {
        return "class var in base"
    }
}

class SubSimple: Simple {
    //Function Overriding is when function/method have same prototype in base class as well as derived class.
    
    //Successful override
    override class func one() {
        print("subClass - one()")
    }
    //Successful override
    override class func two () {
        print("subClass - two()")
    }
    
//    //error: Class method overrides a 'final' class method
//    override static func staticOne() {
//        
//    }
//    
//    //error: Instance method overrides a 'final' instance method
//    override final func yesFinal() {
//        
//    }
    
    //Works fine
    override class var myClassVar: String {
        return "class var in subclass"
    }
}

Simple.one()//class one()
Simple.two()//class two()
Simple.staticOne()//staticOne()
Simple.staticTwo()//staticTwo()
Simple.yesFinal(Simple())//init method called in base (Function)
SubSimple.one()//subClass - one()
Simple.myStaticVar//static var in base
Simple.myClassVar//class var in base
SubSimple.myClassVar//class var in subclass
