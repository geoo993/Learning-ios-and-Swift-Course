//: [Previous](@previous)
import Foundation
import RxSwift

extension Observable {
    func delay(time: Double, scheduler: SchedulerType) -> Observable<E> {
        return self.asObservable().flatMap { value -> Observable<E> in
            return Observable.just(value)
                .delaySubscription(time, scheduler: scheduler)
        }
    }
}

import XCPlayground
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

let a = Variable(0)

a.value = 1

let b = 
    a.asObservable()
    .doOnNext { _ in print("b before delay") }
    .delay(3.0, scheduler: MainScheduler.instance)
    .doOnNext { _ in print("b after delay") }
    .delay(3.0, scheduler: MainScheduler.instance)

a.asObservable()
.take(1)
.subscribe { evt in 
    print("a:", evt, NSDate())
}

b.asObservable()
.take(1)
.subscribe { evt in 
    print("b:", evt, NSDate())
}

//: [Next](@next)
