//: [Previous](@previous)

import Foundation
import UIKit
import RxSwift
import RxCocoa
import PlaygroundSupport

let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
containerView.backgroundColor = UIColor.red

var disposeBag = DisposeBag()

let frame = CGRect(x: 50, y: 50, width: 200, height: 200)
let button = UIButton(frame: frame)
button.backgroundColor = UIColor.blue
button.setTitle("Press me!", for: UIControlState.normal)
button.setTitleColor(UIColor.white, for: UIControlState.normal)
button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
containerView.addSubview(button)

button.rx.tap
.subscribe(onNext: { tap in
    
    print("Tap")
}).addDisposableTo(disposeBag)

PlaygroundPage.current.liveView = containerView
PlaygroundPage.current.needsIndefiniteExecution = true


var tickOffset = 1

let timingArray = [0.1, 0.3, 0.5, 1.8, 1.0, 4.8, 0.6, 2.4, 0.2]

let scanning = Observable.from(timingArray)
    .scan(0, accumulator: { acum, elem in
        acum + elem})
    .flatMap { delay in 
        Observable<Int64>
            .timer(delay, scheduler: MainScheduler.instance)
            .map { _ in delay }
    }
    .subscribe(onNext: { tick in print(tick) })



var state = false
let subscription =
    button
    .rx
    .tap
    .subscribe( onNext: {
        state = !state
        button.backgroundColor = state ? UIColor.red : UIColor.green 
        print(state)
    })

Observable<Int64>.interval(5.0, scheduler: MainScheduler.instance)
    .take(1)
    .subscribe(onNext:{ tick in subscription.dispose() })



Observable<Int64>.interval(0.5, scheduler: MainScheduler.instance)
    .subscribe(onNext:{  tick in state = (tick % 2 == 0) })


let mySwitcher = 
    button
    .rx
    .tap
    .scan(false) { acc, x in return !acc }
    .do( onNext: { button.backgroundColor = $0 ? UIColor.red : UIColor.green  })
    .map { $0 ? "on" : "off" }
    .subscribe( onNext: { print($0) })






