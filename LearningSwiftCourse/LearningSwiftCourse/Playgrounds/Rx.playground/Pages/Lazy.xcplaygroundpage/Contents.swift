//: [Previous](@previous)
let foundTarget = 10
let mockExpensiveOperation : Int -> Bool = { return $0 >= foundTarget }
var count = 0
lazy var lazySeq = (1...100)
    .filter {
        count++
        return mockExpensiveOperation($0) 
    }
    .generate().prefix(1).flatMap { x -> Int in x }.first
 
//let found1 = lazySeq.first
print("lazySeq.first runs mockExpensiveOperation", count, "times. This is twice \(foundTarget).")
// Reset count to zero.
count = 0
//var generatedLazySeq = lazySeq.generate()
//let found2 = generatedLazySeq.next()
//assert(found1 == found2)
print("generatedLazySeq.next() runs mockExpensiveOperation", count, "times. This is correct.")

count = 0
lazy let seq = (1...100)
    .filter { x in
        count++
        return x == 6 }
    .generate().prefix(1).flatMap { (x: Int) in x }.first // A working lazy first


extension LazyCollection {
    var lazyFirst : Base.Iterator? {
       var seq = self.makeIterator()
       return seq.next() as! Base.Iterator
    }
}

extension LazyFilterCollection {
    var lazyFirst : Base.Iterator? {
       var seq = self.makeIterator()
       return seq.next() as! Base.Iterator
    }
}

extension LazyMapCollection {
    var lazyFirst : Base.Iterator? {
       var seq = self.makeIterator()
       return seq.next() as! Base.Iterator
    }
}

let seq2 = (1...100)
    .lazy
    
let seq3 = (1...100)
    .lazy
    .filter { x in
        count++
        return x == 6 }
    .map { $0 * 2 }
    .lazyFirst

let seq4 = (1...100)
    .lazy
    .flatMap { x -> Int in x }

count = 0
let seq5 = (1...100)
    .lazy
    .filter { x in
        count++
        return x == 6 }
    .generate().prefix(1).flatMap { (x: Int) in x }.first // A working lazy first
//let found = seq.next()
 
print(count)

// Prints to console:
// lazySeq.first runs mockExpensiveOperation 20 times. This is twice 10.
// generatedLazySeq.next() runs mockExpensiveOperation 10 times. This is correct.
    
//var found : Int!
//for (i, x) in lazySeq.enumerate() {
//    if i == 0 {
//        found = x
//        break 
//    }
//}
//print("found", found)
// prints to console:
//1
//2
//3
//4
//found 4
//: [Next](@next)
