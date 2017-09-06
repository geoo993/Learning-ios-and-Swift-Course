//: [Previous](@previous)

import Foundation
import RxSwift
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

let timings = [0.1, 0.2, 0.3, 0.4, 0.3, 0.2, 0.1]

func reduceConcat() { 
    [0.1, 0.2, 0.3, 0.4, 0.3, 0.2, 0.1]
    .reduce(Observable.just(0.0)) { acc, delay in
        let timer = Observable.timer(delay, scheduler: MainScheduler.instance).map { (tick: Int64) in delay }
        return acc.concat(timer)
    }
    .subscribeNext {
        print(#function, $0)
    }
}

func reduceConcatTuple() { 
    let start = (delay: 0.0, date: NSDate())
    
    [0.1, 0.2, 0.3, 0.4, 0.3, 0.2, 0.1]
    .reduce(Observable.just(start)) { chain, delay in
        let timer = 
            Observable<Int64>
            .timer(delay, scheduler: MainScheduler.instance)
            .map { _ in (delay, NSDate()) }
        return chain.concat(timer)
    }
    .subscribeNext {
        print(#function, $0.delay, formatter.stringFromDate($0.date)) 
    }
}

func reduceFlatmap() { 
    timings
    .reduce(Observable<Double>.just(0.0)) { chain, delay in
        let timer = 
            Observable<Int64>
            .timer(delay, scheduler: MainScheduler.instance)
            .map { _ in delay }
            .doOnNext { print(#function, $0) }
        return chain.flatMap { _ in timer }
    }
    .subscribeCompleted {
        print(#function, "Completed")
    }
}

func scanFlatmapFlatmap() {
    let start = (delay: 0.0, date: NSDate())
    let timings = [0.1, 0.2, 0.3, 0.4, 0.3, 0.2, 0.1]
    let _ = timings
    .toObservable()
    .scan(Observable.just(start)) { acc, delay in
        let timer = Observable<Int64>
            .timer(delay, scheduler: MainScheduler.instance)
            //.timer(delay, scheduler: SerialDispatchQueueScheduler(internalSerialQueueName: "DISPATCH_QUEUE_PRIORITY_DEFAULT"))
            .map { _ in (delay, NSDate()) }
        return acc.flatMap { x in timer }
            
    }
    .flatMap { $0 }
    .subscribe {
        switch $0 {
        case .Next(let elm):
            print(#function, elm.delay, formatter.stringFromDate(elm.date))
        case .Completed:
            let totalRequested = timings.reduce(0.0, combine: +)
            let completedDate = NSDate()
            let timeInterval = completedDate.timeIntervalSinceDate(start.date)
            print(#function, "Requested delay of \(totalRequested) completed at", formatter.stringFromDate(completedDate))
            print(#function, "Execution realtime delay of \(timeInterval)")
        default: break
        }
    }
}
//reduceConcatFlatmap()
//reduceConcat()
//reduceConcatTuple()
reduceFlatmap()
//scanFlatmapFlatmap()

//: [Next](@next)
