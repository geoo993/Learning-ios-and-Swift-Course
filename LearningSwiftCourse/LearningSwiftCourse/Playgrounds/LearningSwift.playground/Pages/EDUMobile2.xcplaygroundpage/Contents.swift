// EDUMobile2
/*
 if, for, for-each, while, do-while
 */

import UIKit

//declare an array of grades as Doubles:
/*
 Swift arrays (and dictionaries) 
 are collections of values or objects,
 all of a single type.
 */

var grades: [Double]

//all elements in an array need to be of the same type
grades = [89.2, 90, 76.3, 94.8, 57.3, 100]

//an NSARRAY is an immutable type
//If you create an array, a set, or a dictionary, and assign it to a variable, the collection that is created will be mutable. This means that you can change (or mutate) the collection after it is created by adding, removing, or changing items in the collection. 
//If you assign an array, a set, or a dictionary to a constant, that collection is immutable, and its size and contents cannot be changed.

let names = ["Thomas", "Percy", "Rosie", "Daisy"] // immutable! [Thomas, Percy, Rosie, Daisy] 
//names[0] = "Edward"     // immutable, adj., unable to be changed to [Edward, Percy, Rosie, Daisy] // the let makes it immutable

//Create immutable array, they cannot be changed or appended to
//First way:
let array1 = NSArray(array: ["First","Second","Third"])
//Second way:
let array2 = ["First","Second","Third"]

//Create mutable array
var array3 = ["First","Second","Third"]

//Append object to array
array3.append("Forth")


//Dictionaries
//Create immutable dictionary
let dictionary1 = ["Item 1": "description", "Item 2": "description"]

//Create mutable dictionary
var dictionary2 = ["Item 1": "description", "Item 2": "description"]

//Append new pair to dictionary
dictionary2["Item 3"] = "description"



//if statement
var gradeAlert: String
if grades.count < 6 {
    gradeAlert = "not enough grades"
} else if grades.count == 6 {
    gradeAlert = "all grades in"
} else {
    gradeAlert = "too many grades"
}

//counted for loop:
for i in 0 ..< grades.count {
    grades[i]
}

//for-each loop
var sum = 0.0
for grade in grades {
    sum += grade
}

var average = sum / Double(grades.count)

//while loop: executes only if condition is true
var loopCounter = 0
var highGrade = 0.0
while loopCounter < grades.count {
    if grades[loopCounter] > highGrade {
        highGrade = grades[loopCounter]
    }
    loopCounter += 1
}

highGrade

//do-while: always executes at least once
loopCounter = 0
var lowGrade = 100.0
repeat {
    if grades[loopCounter] < lowGrade {
        lowGrade = grades[loopCounter]
    }
    loopCounter += 1
} while loopCounter < grades.count

lowGrade

