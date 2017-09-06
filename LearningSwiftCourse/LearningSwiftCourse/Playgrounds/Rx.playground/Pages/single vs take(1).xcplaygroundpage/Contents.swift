//: [Previous](@previous)

import RxSwift

enum State { case Inactive, Listening }
let state = PublishSubject<State>()

let switchLatest = PublishSubject<Observable<State>>()
let cancel = switchLatest.asObservable()
    .switchLatest()
    .debug("switchLatest")
    .subscribeNext {
        print("switchLatest: ob \($0)")
    }
let listenWithSingle = 
    state.asObservable()
    .single()
    .debug("single")
    .doOnNext { 
        state.onNext(.Listening)
        print("single: do \($0)") 
        }

let listenWithTake1 = 
    state.asObservable()
    .take(1)
    .debug("take(1)")
    .doOnNext { 
        state.onNext(.Listening)
        print("take(1): do \($0)") }

//switchLatest.onNext(listenWithTake1) // `listenWithTake1` works as expected
switchLatest.onNext(listenWithSingle)  // `listenWithSingle` causes hundred of .Next(.Listening) events 
state.onNext(.Inactive)

