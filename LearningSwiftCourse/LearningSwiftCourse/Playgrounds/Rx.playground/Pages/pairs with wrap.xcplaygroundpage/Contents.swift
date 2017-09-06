//: [Previous](@previous)

import Foundation

import Foundation
import RxSwift

let a = Observable.of(1,2,3,4,5,6,7,8)
let wrap = true
let b = a.skip(1).concat(a.take(wrap ? 1 : 0))
let c = Observable.zip(a, b) { ($0, $1) }
c.doOnCompleted {  print("Completed") }
.subscribeNext { 
    print( ($0, $1) )
    //print($0)
}

extension Observable {
    func pairs(wrap: Bool = false) -> Observable<(E, E)> {
        let skippedObservable : Observable<E> = {
            if wrap {
                return self.skip(1).concat(self.take(1)) 
            } else {
                return self.skip(1)
            }
        }()
        return Observable<(E, E)>.zip(
                self, 
                skippedObservable
            ) { ($0, $1) }
    }
}

print("Finished 😀")
//: [Next](@next)
