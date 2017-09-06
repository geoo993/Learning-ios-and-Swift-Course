//: [Previous](@previous)
import Foundation
import UIKit
import RxSwift
import XCGLogger

func color(r: Int, _ g: Int, _ b: Int) -> String {
    return XCGLogger.XcodeColor(fg: (r, g, b)).format()
} 
func color(fg: UIColor) -> String {
    return XCGLogger.XcodeColor(fg: fg).format()
} 

let colors = (
    darkRed: color(177, 0, 31), 
    magenta: color(UIColor.magentaColor()),
    green:  color(0, 127, 0),
    blue:   color(0, 0, 127),
    orange: color(0, 127, 127),
    tan:    color(187, 127, 0),
    red:    color(255, 0, 0),
    gray:   color(UIColor.darkGrayColor()),
    reset:  XCGLogger.XcodeColor.reset 
    )

let colorArray = TupleCollectionView(colors) 

func createTimer(time: Double, timerId: Int) -> Observable<(Int64, Int)> {
    return Observable<Int64>
        .interval(time, scheduler: MainScheduler.instance)
        .map { (tick:$0, timerId: timerId) }
}

let a = createTimer(1.0, timerId: 0)
    .take(5)
    .flatMapLatest { (tick, timerId) -> Observable<(Int64, Int)> in
        let color = colorArray[tick] as? String ?? colors.gray
        return createTimer(Double(tick), timerId: Int(tick))
        .debug(color + "tickId: \(tick)" + colors.reset)
        .take(5)
    }
    .doOnCompleted { print("Completed 😀") }
    .subscribeNext { tick, id in 
        let tabs = Array(0 ..< id).map { _ in "\t\t\t" }.joinWithSeparator("")
        print(colors.red, tabs, "id:", id, ";" ,tick, colors.reset)
    }

import XCPlayground
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//: [Next](@next)
