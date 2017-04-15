//: [Previous](@previous)

import Foundation


class Country {
    var country:String
    init() { 
        self.country = "UK"
        print("person is from \(country)") 
    }
    init(country: String) { 
        self.country = country
        print("person is from \(country)") 
    }
}

class Person: Country {
    var name: String
    var age:Int
    override init() { 
        self.name = ""
        self.age = 0
        super.init()
        print("\(self.age) year old \(self.name) is a person, from \(self.country)") 
    }
    init(name:String, age:Int, country:String) { 
        self.name = ""
        self.age = age
        super.init(country:country)
        print("\(self.age) year old \(self.name) is a person, from \(self.country)") 
    }
   
}

class Gender: Person {
    var gender:String
    override init() { 
        self.gender = ""
        super.init()
        print("\(self.age) year old \(self.name) is a \(self.gender), from \(self.country)") 
    }
    init(name:String, age:Int, country:String, gender:String) { 
        self.gender = gender
        super.init(name:name, age:age, country:country)
        print("\(self.age) year old \(self.name) is a \(self.gender), from \(self.country)") 
    }
}

var country = Country()
var personOne = Person(name: "Alex", age: 21, country: "Venezuela")
var genderOne = Gender(name: "Toby", age: 12, country: "Congo", gender: "Male")

var personTwo = Person(name: "Mia", age: 26, country: "Germany")
var genderTwo = Gender(name: "Elia", age: 17, country: "China", gender: "Female")
print()

//upcasting to a known superclass will always work
var upcast = personOne as Country

//downcasting 
//in downcasting there might be a problem, which is why it is an optional.
//so downcasting to a known subclass, when sure of success we can use (as)
//but when we are not sure that this is going to succeed we use the optional form as question mark (?), this will return an optional and then we need to unwrap it
var downcast1 = personOne as! Gender
var downcast2 = personOne as? Gender
downcast2 = Gender(name: "Lucas", age: 14, country: "Brazil", gender: "Male")
