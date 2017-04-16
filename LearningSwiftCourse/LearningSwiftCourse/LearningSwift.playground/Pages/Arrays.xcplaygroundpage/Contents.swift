//: [Previous](@previous)

import Foundation

let arr = [0..<10].flatMap{ $0 }

let arr2 = [1,2,3,4,5]

var pair = [(Int, Int)]()
for (ind,i) in arr.enumerated(){
    
    if ind < arr.count - 1 {
        pair.append( ( i, arr[ind + 1] ) )
    }
}

let tail = arr.dropFirst()

let pairs = 
    zip(arr, arr.dropFirst()).map{$0}

print(pair)
let target = [(1,2), (2,3), (3,4), (4,5)]


let random = [1,5,-3,5,7,2,10]
let drops = 
    zip(random, random.dropFirst()).enumerated().filter { $1.1 < $1.0 }.map { $0.offset }
print(drops)
var str = "Hello, playground"


for i in 0..<40 {
    //print( CGFloat(i) / CGFloat(40)  )
    print( i % 2 )
}
