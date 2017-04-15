//: [Previous](@previous)

import Foundation

var age:Int?

age = 25

if let myAge = age {
    print("\(myAge)")
}else{
    age = 30
    print("\(age)")
}



var raining:Bool?

if raining == nil {
    raining = true
}

print("it is \(raining) that it is raining")
print("it is \(raining!) that it is raining")

 if let isRaining = raining {
 
 } else {
    raining = false
 }
 print("it is \(raining) that it is raining")



var tag:Int!


if tag == nil {
    tag = 30
    print("this is my \(tag)")
}else{
    print("\(tag)")
}
 
