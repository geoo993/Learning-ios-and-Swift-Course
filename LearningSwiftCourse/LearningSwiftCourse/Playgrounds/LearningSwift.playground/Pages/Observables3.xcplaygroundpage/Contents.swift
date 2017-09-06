//: [Previous](@previous)

import Foundation
import RxCocoa
import RxSwift


let startTime = Date()

Observable<Int>
    .interval(1.0, scheduler: MainScheduler.instance)
    .completeAfter({ $0 == 3})
    .subscribe{ print($0) }


let totalCount = 1000
let arr = (0 ... totalCount).map { $0 }
let obs = Observable.from(arr) //
Observable.of(
    obs.takeWhile { $0 != 3 }, 
    obs.skipWhile { $0 != 3 }.take(1))
    .merge()
    .subscribe(onNext: { x in 
        print(x) //, x == totalCount)
    })



let startTime = Date()

let ticker = Observable<Int>
    .interval(1.0, scheduler: MainScheduler.instance)
    .take(2)

ticker
    .flatMap { tick in 
        return Observable<Int>.interval(0.25, scheduler: MainScheduler.instance)
            .take(2) }
    .subscribe(
        onNext: { tick in
            let currentTime = Date()
            let interval = currentTime.timeIntervalSince(startTime)
            print(interval)
    },  onCompleted: {
        print("Completed")
    })
