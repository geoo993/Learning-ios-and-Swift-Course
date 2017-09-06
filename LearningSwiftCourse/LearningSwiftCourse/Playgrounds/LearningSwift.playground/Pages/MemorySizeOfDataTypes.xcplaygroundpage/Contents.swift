import Foundation

//http://stackoverflow.com/questions/24662864/swift-how-to-use-sizeof
//The memory layout of a type, describing its size, stride, and alignment.
//You can use MemoryLayout as a source of information about a type when allocating or binding memory using unsafe pointers.

struct Point {
    let x: Double
    let y: Double
    let isFilled: Bool
}
//The size, stride, and alignment of the Point type are accessible as static properties of MemoryLayout<Point>.
MemoryLayout<Point>.size //== 17
MemoryLayout<Point>.stride //== 24
MemoryLayout<Point>.alignment //== 8

//size(ofValue:) Returns the contiguous memory footprint of the given instance.
//the return value is the size, in bytes, of the given value’s type.

let x: Int = 100

// Finding the size of a value's type
let s = MemoryLayout.size(ofValue: x)
// s == 8

// Finding the size of a type directly
let t = MemoryLayout<Int>.size
// t == 8


func sizeof <T> (_ : T.Type) -> Int
{
    return (MemoryLayout<T>.size)
}

func sizeof <T> (_ : T) -> Int
{
    return (MemoryLayout<T>.size)
}

func sizeof <T> (_ value : [T]) -> Int
{
    return (MemoryLayout<T>.size * value.count)
}


sizeof(UInt8.self)   // 1
sizeof(Bool.self)    // 1
sizeof(Double.self)  // 8
sizeof(Int32.self) // 4
sizeof(UInt.self)     // 8 //On this 64-bit system, UInt is the same size as UInt64.
sizeof(Int.self)     // 8 //On this 64-bit system, Int is the same size as Int64.
sizeof(CGFloat.self) // 8

var testArray: [Int32] = [2000,400,5000,400]
var arrayLength = sizeof(testArray)  // 4, 4, 4, 4 = 16

/*
//The following table shows the variable type, how much memory it takes to store the value in memory, and what is the maximum and minimum value which can be stored in such type of variables.

Type	Typical Bit Width	   Typical Range
Int8	1byte	               -127 to 127
UInt8	1byte	               0 to 255
Bool    1byte                  
Int32	4bytes	               -2147483648 to 2147483647
UInt32	4bytes	               0 to 4294967295
Int64	8bytes	               -9223372036854775808 to 9223372036854775807
UInt64	8bytes	               0 to 18446744073709551615
Float	4bytes	               1.2E-38 to 3.4E+38 (~6 digits)
Double	8bytes	               2.3E-308 to 1.7E+308 (~15 digits)
 
*/



