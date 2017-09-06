//: [Previous](@previous)
import RxSwift
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

var state = Int64(0)


let resetDisposable : () -> AnonymousDisposable = { () in
    let initial = state 
    return AnonymousDisposable { 
        state = initial
        print("Reset state to \(state)")
        }
    }
         
let tickerWithStateReset = 
    Observable.using(resetDisposable) { sub in
        return Observable<Int64>.interval(1.0, scheduler: MainScheduler.instance)
    }
        
let tickerSubscription = 
    tickerWithStateReset
    .do(onNext: { state = $0 })
    .subscribe { _ in print(state) }

Observable<Int64>
.interval(4.0, scheduler: MainScheduler.instance)
.take(1)
.subscribeNext { _ in tickerSubscription.dispose() }

//: [Next](@next)

//let tickWithStateReset2 = Observable<Int64>.using({ _ in 
//        AnonymousDisposable { state = 0 } 
//    }) { reset in
//    
//        return Observable<Int64>.create { observer in 
//            let ticker = Observable<Int64>.interval(1.0, scheduler: MainScheduler.instance)
//            let tickerSub = ticker.subscribe { observer.on($0) }
//            return CompositeDisposable(tickerSub, reset)
//            }
//        }
//tickWithStateReset2.subscribe{ evt in print(evt) }
//: [Next](@next)
