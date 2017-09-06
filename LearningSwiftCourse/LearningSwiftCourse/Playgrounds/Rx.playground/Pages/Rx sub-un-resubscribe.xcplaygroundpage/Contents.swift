//: [Previous](@previous)

import Foundation
import XCPlayground
import RxSwift

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

let disposeBag = DisposeBag()
let viewWillAppear = PublishSubject<Void>()
let viewWillDisappear = PublishSubject<Void>()
let ticker = Observable<Int64>.interval(0.2, scheduler: MainScheduler.instance)

viewWillAppear.map { 
    ticker.subscribeNext { 
        tick in print(tick) 
        } 
    }
    .subscribeNext { subscription in
       viewWillDisappear.subscribeNext {
           subscription.dispose() 
       }.addDisposableTo(disposeBag)
    }.addDisposableTo(disposeBag)
        
let viewLifecycle = 
    Observable<Int64>.timer(0.0, period: 2.0, scheduler: MainScheduler.instance)
    .take(2)
    .subscribeNext { tick in
        switch tick {
        case 0: viewWillAppear.onNext()
        case 1: viewWillDisappear.onNext()
        default: break 
        }
    }

//: [Next](@next)
