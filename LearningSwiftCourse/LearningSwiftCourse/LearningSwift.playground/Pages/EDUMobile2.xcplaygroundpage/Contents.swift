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

grades = [89.2, 90, 76.3, 94.8, 57.3, 100]

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

