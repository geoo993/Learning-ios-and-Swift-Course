// EDUMobile5 - Classes

import UIKit

//classes are dynamically allocated, therefore they are allocated on the heap
//Since struct instances are allocated on stack, and class instances are allocated on heap, structs can sometimes be drastically faster, but it really depends on how many values you're storing and the size / structure of them.

//because classes are allocated on the hep, therefore they are reference types rather than stack types, or value types.
//so when we declare a class, we are declaring a class reference type or a reference to that class type


/*
 Point1: simple class with properties only:
 */
class Point1 {
    //all stored properties MUST be initialized (somehow...):
    var x:Double = 0
    var y:Double = 0
}

//make a point
let point1 = Point1()// we use the paremthesis to say that we are going to use the default initialiser

point1.x = 3// can set the value of the property
point1.y = 4
let myX = point1.x // can get the value of the property

/*
 Point2: adds a method:
 */
class Point2 {
    var x:Double = 0
    var y:Double = 0
    
    //a method in a class uses the same syntax as a function outside of a class
    func asXY(coordinates:(Double, Double))
    {
        x = coordinates.0
        y = coordinates.1
    }
}

let point2 = Point2()
point2.asXY(coordinates: (5, 4))

class PointVector2 {
    var x:Double = 0
    var y:Double = 0
    var z:Double = 0
    
    //a method in a class uses the same syntax as a function outside of a class
    func asXYZ(coordinates:(x:Double, y:Double,z:Double))
    {
        x = coordinates.x
        y = coordinates.y
        z = coordinates.z
    }
}

let pointVector = PointVector2()
pointVector.asXYZ(coordinates: (x:5, y:4, z:3))

/*
 Point3: use initializers instead:
 */

class Point3 {
    var x:Double
    var y:Double
    
    //a default initializer can provide
    //values for stored properties. If a 
    //stored property will always have the
    //same initial value, it is better to
    //assign it in the declaration.
    init() {//default initiazer
        print("Making a point")
        x = 0
        y = 0
    }
    
    init(x:Double, y:Double) {//custom initiazer with parameters
        self.x = x
        self.y = y
    }
    
}
let point3a = Point3()
let point3b = Point3(x: 4, y: 3)


/*
 Line1: defined by two points:
 */

class Line1 {
    var start:Point3  // using the point class
    var end:Point3
    
    init(start:(Double, Double), end:(Double, Double)) {
        self.start = Point3(x: start.0, y: start.1)
        self.end = Point3(x: end.0, y: end.1)
    }
    //equation of a length between two points 
    func length() -> Double {
        var length:Double
        let deltaX = end.x - start.x
        let deltaY = end.y - start.y
        length = sqrt(deltaX * deltaX + deltaY * deltaY)
        
        return length
    }
    
    func lengthWithStartPoint
        (startPoint:(Double, Double),
         andEndPoint:(Double, Double))
        -> Double {
            var length:Double
            let deltaX = andEndPoint.0 - startPoint.0
            let deltaY = andEndPoint.1 - startPoint.1
            length = sqrt(deltaX * deltaX + deltaY * deltaY)
            
            return length
    }
}

let aLine = Line1(start: (3,5), end: (2, -4))
aLine.length()
/*
 In methods, the first parameter does not have a required
 external parameter name, but all other parameters do. 
 Method names should name their first parameter, so that 
 the form is more or less like the equivalent Obj-C 
 method name:
 lengthWithStartPoint: andEndPoint:
 */
aLine.lengthWithStartPoint(startPoint: (0, 0), andEndPoint: (4, 3))

/*
 Line2: uses a type-level method for the second length... method:
 */

class Line2 {
    var start:Point3
    var end:Point3
    
    init(start:(Double, Double), end:(Double, Double)) {
        self.start = Point3(x: start.0, y: start.1)
        self.end = Point3(x: end.0, y: end.1)
    }
    
    func length() -> Double {
        var length:Double
        let deltaX = end.x - start.x
        let deltaY = end.y - start.y
        length = sqrt(deltaX * deltaX + deltaY * deltaY)
        
        return length
    }
    
    //this is a class method
    class func lengthWithStartPoint
        (startPoint:(Double, Double),
         andEndPoint:(Double, Double))
        -> Double {
            var length:Double
            let deltaX = andEndPoint.0 - startPoint.0
            let deltaY = andEndPoint.1 - startPoint.1
            length = sqrt(deltaX * deltaX + deltaY * deltaY)
            
            return length
    }
}

let aLine2 = Line2(start: (3,5), end: (2, -4))
aLine2.length()
//we call instance methods using the instance name (Line2)
Line2.lengthWithStartPoint(startPoint: (0, 0), andEndPoint: (4, 3))

