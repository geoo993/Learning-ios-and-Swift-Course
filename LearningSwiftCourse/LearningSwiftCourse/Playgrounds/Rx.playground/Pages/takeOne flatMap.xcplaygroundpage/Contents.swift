//: [Previous](@previous)

import Foundation
import RxSwift
import XCPlayground
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

var str = "Hello, playground"

let events = Observable<Int64>.interval(1.0, scheduler: MainScheduler.instance)
let eventAcc = events
.scan( (state: true, tick: Int64(-1)) ) { acc, tick in 
    guard tick % 5 == 0 else { return (acc.state, tick) }
    return (!acc.state, tick) 
}
eventAcc
.skipUntil(events.filter { $0.0 == true })
.subscribe { print($0) }

//: [Next](@next)
