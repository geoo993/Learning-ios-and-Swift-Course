//: [Previous](@previous)

import Foundation


//there are three access control specifiers for properties and methods in swift
//1 - private: properties that are private are available only in the source file of where the entity is declared
//2 - internal: properties that are internal are available within the entire scope of the app in which the entity is declared
//3 - public:  properties that are public are available to anyone that imports the module where the entity is declared (for example, you write a framework for use by others)
//All porperties not declared public or private are internal properties. meaning that all properties by default are internal.
//properties are constants or variables that are stored along with the instance in which they are defined. 
//a default value can be given to a stored property when it is defined e.g. let/var myPro = 15



//LAZY properties
//if a stored property's value does not need to be calculated
//until the first time its used, it can be marked @lazy
//@lazy properties are always vars! A let can't be lazy.
//lazy is often used to avoid instantiating a reference type unless and until
//it is needed (such as when a controller instantiates a model)
//Instantiation of a @lazy var is deferred until that var's getter is called

class DataViewer{
    //some hideously big class that
    //formats and displays data
}

class Data {
    lazy var dViewer = DataViewer()
    //a class that encapsulates a bunch of data...
    func viewData() { /* uses the DataViewer (dViewer) here, so when this function is called the dViewer will be instantiated */ }
    
    deinit {
        print("\(#function)")
    }
}

let myData = Data()
myData.viewData() //<-- this causes myData's dViewer to be instantiated.


//PROPERTY Observers
//two observers  can be defined on stored properties: willSet and didSet
//if defined, they will be called every time a stored property's value is set,
//even if the value isn't changed.
//@lazy stored properties can't have property observers.
//willSet is passed a constant parameter containing the new value. 
//It is named newValue by default.
//didSet is passed a constant parameter containing the old value.
//It is named oldValue by default

struct TalkativeNumber {
    
    var theNumber:Int = 0 {
        willSet{
            print("Hi! I was \(theNumber),")
            print("but now I'm \(newValue)")
        }
        didSet{
            print("Hi! It's so much nicer")
            print("to be \(theNumber) than")
            print("it was to be \(oldValue)")
        }
    }
}

var talkativeNumber = TalkativeNumber()
talkativeNumber.theNumber = 5
print()
talkativeNumber.theNumber = 21



//METHODS
//Methods are functions belonging to the entity 
//(enumeration, structure, or class) in which they are defined
//there are two fundermentally different kinds of method:
//-INSTANCE methods operate on an instance of a type, and have access
//to that instance's properties
//-TYPE methods operate on the type itself, and only have access
//to static properties of the type

//https://oleb.net/blog/2014/07/swift-instance-methods-curried-functions/
//Consider this simple example of a class that represents a bank account:
class BankAccount {
    var balance: Double = 0.0
    
    func deposit(amount: Double) {
        balance += amount
    }
    func printBalance() {
        print("balance: \(balance)")
    }
}

//As mentioned earlier, a type refers to a class, structure, enumeration, protocol, and compound types. 
//If I want to construct an individual object of the BankAccount class then I would be creating an instance. 
//We can obviously create an instance of this class and call the deposit() method on that instance:
let account = BankAccount()//instance of a class
//The above are objects or instances of BankAccount. Now I can call instance methods directly. The instance method defined in the class is deposit.
account.deposit(amount:100) // balance is now 100. this is an instance method 

// But we can also do this:
let depositor = BankAccount.deposit//we are not calling the method here but just referencing it
depositor(account)(100) // This second step is then to call the function stored in the depositor variable. 
//Its type is as follows:  let depositor: BankAccount -> (Double) -> ()
//In other words, this function has a single argument, a BankAccount instance, and returns another function.
//Of course, we can also do this in one line, which makes the relationship between type methods and instance methods even clearer:
BankAccount.deposit(account)(amount:100) // balance is now 300
//we are passing the instance to BankAccount.deposit() directly without creating an instance. 
//So, a type method is a method that can be called directly on the type without creating an instance of that type.
//For example:
BankAccount.printBalance(account)() //or
account.printBalance()
