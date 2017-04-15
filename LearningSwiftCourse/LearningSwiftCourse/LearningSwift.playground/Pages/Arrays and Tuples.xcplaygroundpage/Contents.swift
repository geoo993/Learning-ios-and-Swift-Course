//: [Previous](@previous)

import Foundation

//in swift we have two basic collection types, these are Arrays and Dictionaries

//demonstrates arrays by returning one from a function:
var fibonacci:[Int]

func generateFibs(count:Int) -> [Int] {
    
    var output = [1, 1]
    if count == 0 {return [0]}
    if count == 1 {return [1]}
    
    var i = 2
    while i < count {
        output.append(output[i-1] + output[i-2])
        i += 1
    }
    return output
}

fibonacci = generateFibs(count: 8)

print(fibonacci)
//shows for-in:
for fib in fibonacci {
    print(fib)
}

print(fibonacci[5])

//using a range
print(fibonacci[3...5])

var sum:Int = 0

for fib in fibonacci[3...5] {
    sum += fib
}
print(sum)

//the swap function with tuples:
func swap1(_ tuple:(a:Int, b:Int)) -> (Int, Int) {
    return (tuple.b, tuple.a)
}

var someTuple = (1, 2)
print("\(someTuple.0), \(someTuple.1)")
someTuple = swap1(someTuple)
print("\(someTuple.0), \(someTuple.1)")

//using names in the tuple return type:
func swap2(_ tuple:(a:Int, b:Int)) -> (first:Int, second:Int) {
    return (first:tuple.b, second:tuple.a)
}

var anotherTuple = (2, 3)
print("\(anotherTuple.0), \(anotherTuple.1)")
var aTuple = swap2(anotherTuple)
print("\(aTuple.first), \(aTuple.second)")

//using names in the tuple to return time:
func time(_ date: Date, _ calendar: Calendar ) -> (hour:Int, minute:Int, second: Int) {
    
    let hr = calendar.component(.hour, from: date)
    let min = calendar.component(.minute, from: date)
    let sec = calendar.component(.second, from: date)
    return (hour:hr, minute:min, second:sec)
}
let date = Date()
let calendar = Calendar.current
let currentTime = time(date, calendar)
print("Time is \(currentTime.hour):\(currentTime.minute):\(currentTime.second)")


//array with flat map
let arr = [0..<20].flatMap{$0}
print(arr)



