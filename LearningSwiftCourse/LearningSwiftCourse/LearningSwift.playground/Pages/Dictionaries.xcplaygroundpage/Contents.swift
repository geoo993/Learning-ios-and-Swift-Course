//: [Previous](@previous)

import Foundation

//A dictionary is an unordered collection of key-value pairs, in which
//All of the keys are the same type, and 
//All the values are the same type.
//The type of the keys must be "hashable", hashable means that there is a way for each key to be uniquely represented.
//the good news is, all swift primitive types are hashable, such as String, Int, Double, Float and Bool (allong with all of their subtypes like Uint16, Uint, Int32 etc...) 


//doing some stuff with dictionaries:

var elements = ["H":1, "He":2, "Li":3]

for (symbol, number) in elements {
    print("The element \(symbol) has \(number) protons")
}

print("There are \(elements.count) elements in the dictionary.")

//make an empty dictionary
var intNames = Dictionary<Int, String>()

//add a couple of ints:
intNames[42] = "forty two"
intNames[6] = "six"
intNames[7] = "seven"

//these values are added as optionals:
print("\(intNames[42]) divided by \(intNames[6]) equals \(intNames[42/6])")

//use explicit unwrapping:
print("\(intNames[42]!) divided by \(intNames[6]!) equals \(intNames[42/6]!)")

//remove all elements:
intNames = [:]

//add another element with key -5, as this is not index you can do negative
intNames[-5] = "negative five"
intNames.removeValue(forKey: -5)

print(intNames.isEmpty)

//using an array for a dictionary's values:
//the type of counting is Dictionary<String, [String]>
var counting = [
    "English":["one", "two", "three", "four", "five"],
    "Spanish":["uno", "dos", "tres", "cuatro", "cinco"],
    "French":["un", "deux", "trois", "quatre", "cinq"]
]

print()
for (language, numbers) in counting {   //is a key, value pair
    print("The next language is \(language):")
    for number in numbers {             //is an array element
        print(number)
    }
    print()
}

/*
 the value of a dictionary can be of any type. A tuple, for example:
 */

var animals = [
    "Elephant":(legs:4, type:"mammal"),
    "Chicken":(legs:2, type:"bird"),
    "Snake":(legs:0, type:"reptile")
]

for (animal, data) in animals {
    print("Name:\(animal), type:\(data.type), legs:\(data.legs)")
}