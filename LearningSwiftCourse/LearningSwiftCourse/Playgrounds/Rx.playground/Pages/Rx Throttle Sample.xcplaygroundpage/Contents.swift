//: [Previous](@previous)

import Foundation
import RxSwift
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

let sampler = Observable<Int64>
    .interval(0.4, scheduler: MainScheduler.instance)
    .debug("sampler")
let timer = 
    Observable<Int64>
    .interval(0.2, scheduler: MainScheduler.instance)
    .debug("timer")
    .throttle(0.1, scheduler: MainScheduler.instance)
//    .sample(sampler)
    .take(5)
    .subscribeNext { x in 
        print("result:", x)
    }

//: [Next](@next)
