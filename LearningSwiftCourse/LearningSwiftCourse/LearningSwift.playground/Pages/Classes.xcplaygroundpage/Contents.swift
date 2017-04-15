//: [Previous](@previous)

import Foundation

//CLASSES

// computed properties define a getter and setter:

class Clock {
    
    //hours, minutes, and seconds are stored properties, 
    //private to the SOURCE FILE (not the class)
    private var hours:Int, minutes:Int, seconds:Int
    
    let description:String
    
    //provide an initializer:
    init(hours:Int, minutes:Int, seconds:Int) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
        
        self.description = "A Clock"
    }
    
    private func reset() {
        hours = 0 ; minutes = 0 ; seconds = 0
    }
    
    func tick() {
        seconds += 1
        if seconds > 59 { seconds = 0 ; minutes += 1
            if minutes > 59 { minutes = 0 ; hours += 1
                if hours > 23 { reset() }
            }
        }
    }
    
    func strTime() -> String {
        //our old friend, the formatted string:
        return String(format: "%.2d:%.2d:%.2d", hours, minutes, seconds)
    }
    
    deinit {
        print("structure deinit \(#function)")
    }

}

let myClock = Clock(hours: 3, minutes: 59, seconds: 57)
myClock.strTime()

myClock.tick()
myClock.strTime()

myClock.tick()
myClock.strTime()

myClock.tick()
myClock.strTime()

myClock.tick()
myClock.strTime()

myClock.tick()
myClock.strTime()

//try to set seconds outside the class:
/*
 We can, because the keyword private means
 "only accessable within the source file"
 
 In a playground, this makes little sense, 
 but in an app context, where a single class
 or group of related classes is defined in a 
 single source file, this makes perfect sense.
 */
//cant do this because it is private
//myClock.seconds = 35

class Verbose {
    var number:Int = 0 {
        willSet {
            "Hi! I was \(number),"
            "but now I’m \(newValue)"
        }
        didSet {
            "Hi! It’s so much nicer"
            "to be \(number) than"
            "it was to be \(oldValue)"
        }
    }
}

var annoying = Verbose()
//annoying.number = 9
annoying.number = 15

