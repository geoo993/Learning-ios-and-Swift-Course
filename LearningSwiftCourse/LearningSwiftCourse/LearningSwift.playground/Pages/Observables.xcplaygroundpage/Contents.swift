//: [Previous](@previous)

import Foundation
import UIKit
import RxCocoa
import RxSwift

//creating sequences and subscribe
//subscribenext takes next element but subscibe takes next, complete, and error
//observable type: ticker, map, flatmap, combine, filter, distinct until change  throttle ........
//subcribe always come last after all the tranformation given to a subscription
//observable sequences can be created using arrays, dictionairies, list , sets etc... 
//you can create observable sequences by simply adding -toObservable() - next to any sequence i.e array, set , dictionary etc...
//filter always takes a closure i.e {}, its argumenet is based on the element of the sequence (i.e. string, int). the filter takes the element of the sequence and retuns a bool based on the argument of the filter
//map mainly transforms elements
//flatmap does the tranformation of observables sequences
// DoOn, DoOnNext and SubscribeNext are side effect function, were to want to pass on instructions
//https://blog.autsoft.hu/rxswift-on-ios-where-to-start-the-adventure/
//https://libraries.io/carthage/ReactiveX%2FRxSwift/3.0.1@swift-3
//use rx marbels http://rxmarbles.com/
var disposeBag = DisposeBag()

//part intro

Observable.from([1,2,3,4,5,6])
    .subscribe(
        onNext: { (intValue) -> Void in
            print("Pumped out the next Int")
    },
        onError: { (error) -> Void in
            print("Error occured")
    },
        onCompleted: { () -> Void in
            print("The sequence is finished")
    }
    ) { () -> Void in
        print("We disposed this subscription")
}

Observable.from([1,2,3,4,5,6])
    .map { $0 * 2 }
    .subscribe(onNext: { print($0) })
// Prints 2, 4, 6, 8, 10 and then 12

Observable.from([1,2,3,4,5,6])
    .take(2)
    .subscribe( onNext: { print($0) })
// Prints only 1 and 2

Observable.combineLatest(Observable.from([1,3]), Observable.from([2,4])) { "\($0)\($1)" }  
    .subscribe(onNext: { print($0) })
// Prints 32, and 34
// as the first observable emmits 1 and 3
// and only then the second observable emmits 2 and 4



//part 1
let a = [0,1,2,3,4,5]
print(a)

let b = [1, 2, 3, 4, 5, 6]
    .filter{ $0 % 2 == 0 }
print(b)

let c = [1, 2, 3, 4, 5, 6]
    .map{ $0 * 5 }
print(c)
print("today")

let d = [1, 2, 3, 4, 5, 6]
    .reduce(_:0, _: +)
print(d)

let optionalInts: [Int?] = [1, 2, nil, 4, nil, 5]
let e = optionalInts.flatMap { $0 }
print(e)

let nestedArrayInts = [[1,2,3], [4,5,6]]
let f = nestedArrayInts
    .flatMap { array in
        array.map { element in
            element * 2 
        }
}
print(f) 


//part 2
let setOfInts = Set([1,2,3,4,5,4,3,2,1,0,6])
let aa = Observable.from( setOfInts )
    .takeLast(4)
    .do( onCompleted: { idx in
        print("completed aa")
    })
    .subscribe( onNext: { num in
        print(num)
    })

let bb = Observable.from( [1, 2, 3, 4, 5, 6] )
    .filter{ $0 % 2 == 0 }
    .do( onCompleted: { element in
        print("completed bb")
    })
    .subscribe(onNext: { print($0) })

let cc = Observable.of(0, 1, 2, 3, 4, 5)
    .map { $0 + 3 }
    .do(onCompleted:{ 
        print("completed cc")
    })
    .subscribe(onNext: { print($0) })


let dd = Observable.from([0, 1, 2, 3, 4, 5, 6, 8, 7, 8, 9])
    .reduce(0, accumulator: +)
    .do(onCompleted:{ print("completed dd")})
    .subscribe(onNext: { print($0) })

let ddd = Observable.from([[0, 1, 2, 3, 4, 5], [6, 8, 7, 8, 9]])
    .flatMap { res -> Observable<Int> in
        return Observable.from(res)
            .reduce(0, accumulator: +)
    }
    .do( onCompleted: { print("completed ddd")})
    .subscribe(onNext: { print($0) })

let dds = Observable.from([0, 1, 2, 3, 4, 5, 6, 8, 7, 8, 9])
    .scan(0, accumulator: { acum, elem in acum + elem})
    .do(onCompleted: { print("completed dds") })
    .subscribe( onNext: { print($0) })


let ee = Observable.from([[1, 2, 3, 4, 5],[0,2,3,4,5]])
    .flatMap { res -> Observable<Int> in
        return Observable.from(res)
    }
    .do(onCompleted: { print("completed ee") })
    .subscribe(onNext: { print($0) })

let ff = Observable.from([[1, 2, 3, 4, 5],[0,2,3,4,5]])
    .flatMap { res -> Observable<Int> in
        return Observable.from(res)
            .map { element in
                element * 2 
        }
    }
    .do(onCompleted:{ print("completed ff") })
    .subscribe( onNext: { print($0) })





let sequenceInt = Observable.of(1, 2, 3)
let sequenceString = Observable.from(["A", "B", "C", "D", "E", "F"])
//let sequenceString = Observable.of("A", "B", "C", "D", "E", "F", "--")
sequenceInt
    .flatMap { (x:Int) -> Observable<String> in
        print("Int from sequenceInt \(x)")
        return sequenceString
    }
    .subscribe(onNext: { str in print(str) })

let arr = Observable.from([1,2,3,4,5,6])
    .subscribe(onNext: { (intValue) -> Void in
        // Pumped out an int
        print(intValue)
    }, onError: { (error) -> Void in
        // ERROR!
        print(error)
    }, onCompleted: { () -> Void in
        // There are no more signals
    }) { () -> Void in
        // We disposed this subscription
}
