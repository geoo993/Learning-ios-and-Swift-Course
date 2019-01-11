
import Foundation


public extension Array {
    
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
    
    /// Takes one element randomly from the array
    public func chooseOneRandomly() -> Element? {
        let list: [Element] = self
        guard list.count > 1 else { return nil }
        
        let len = UInt32(list.count)
        let random = Int(arc4random_uniform(len))
        return list[random]
    }
    
    /// Take a certain amount of from the array, provided that the amount elements in the array
    // is less than the amount needed. This retrun a random amount of element from the array
    public func takeRandom(_ amount: Int) -> [Element] {
        var list = self
        guard list.count > 1, amount <= list.count else { return self }
        
        var temp: [Array.Iterator.Element] = []
        var count = amount
        
        while count > 0 {
            let index = Int(arc4random_uniform(UInt32(list.count - 1)))
            temp.append(list[index])
            list.remove(at: index)
            count -= 1
        }
        return temp
    }
    
    /// Shuffles the elements within the array
    public func shuffle() -> [Element] {
        var list = self
        guard list.isEmpty == false else { return self }
        
        var results: [Array.Iterator.Element] = []
        var indexes = (0 ..< count).map { $0 }
        while indexes.isEmpty == false {
            let indexOfIndexes = Int(arc4random_uniform(UInt32(indexes.count)))
            let index = indexes[indexOfIndexes]
            results.append(list[index])
            indexes.remove(at: indexOfIndexes)
        }
        return results
    }
    
    /// Randomises the elements within the array
    public func randomise() -> [Element] {
        var list = self
        guard list.isEmpty == false else { return self }
        
        var temp: [Array.Iterator.Element] = []
        
        while list.isEmpty == false {
            let index = Int(arc4random_uniform(UInt32(list.count - 1)))
            temp.append(list[index])
            list.remove(at: index)
        }
        return temp
    }
   
    func splitBy(_ subSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: subSize).map {
            Array(self[$0..<Swift.min($0 + subSize, self.count)])
        }
    }
    
    /// Chooses a element randomly then removes it from the array.
    ///
    /// - Returns: a randomly chosen element from the array or nil if the array is empty.
    mutating func chooseAndRemove() -> Element? {
        guard count > 0 else { return nil }
        let index = arc4random_uniform(UInt32(count))
        return self.remove(at: Int(index))
    }
    /// Generates an array of elements picked at random with non-repeating behavior.
    ///
    /// - Parameters:
    ///   - n: the length of the required output array
    ///   - order: the minimum number of contiguous non-repeating elements allow in the list.
    /// - Returns: An array of length N with random elements chosen from the the input array.
    func createRandomSelection(ofLength n: Int, ofRepetitionOrder order: Int) -> [Element] {
        guard count > 1 else { return [] }
        let order = Swift.max(order, count - 1)
        var currentChoices = self
        var oldChoices: [Element] = []
        var resultChoices: [Element] = []
        for _ in 1...n {
            guard let result = currentChoices.chooseAndRemove() else { break }
            oldChoices.insert(result, at: 0)
            if oldChoices.count > order {
                let oldChoice = oldChoices.remove(at: order)
                currentChoices.append(oldChoice)
            }
            resultChoices.append(result)
        }
        return resultChoices
    }
}

public extension Array where Element: Equatable {
    public func containsSubsetElements(subset: [Element]) -> Bool {
        return subset.reduce(true) { (result, item) in
            return result && contains(item)
        }
    }
    
    public func allEqual() -> Bool {
        if let firstElem = first {
            return !dropFirst().contains { $0 != firstElem }
        }
        return true
    }
    
    public func next(item: Element) -> Element? {
        if let index = self.index(of: item), index + 1 <= self.count {
            return index + 1 == self.count ? self[0] : self[index + 1]
        }
        return nil
    }
    
    public func prev(item: Element) -> Element? {
        if let index = self.index(of: item), index >= 0 {
            return index == 0 ? self.last : self[index - 1]
        }
        return nil
    }
}

public extension Array where Element: Hashable {
    
    /// Converts the array into a unique set of elements, basically removes duplicated elements
    public func uniqueElements() -> [Element] {
        let list = self
        if list.isEmpty { return self }
        
        // Convert array into a set to get unique values.
        let uniques = Set<Element>(list)
        // Convert set back into an Array of Ints.
        let result = Array(uniques)
        return result
    }
    
    /// Skip duplicated elements
    public func skipDuplicates() -> [Element] {
        
        var list = self
        
        if list.isEmpty { return [] }
        
        //do not take duplicated words
        var tempList : [Array.Iterator.Element] = []
        var elementsRemoved : [Array.Iterator.Element] = []
        
        for word in list{
            if (tempList.contains(word)){
                //found the next of the duplicated word
                if let index = tempList.index(of: word){
                    tempList.remove(at: index)
                    list.remove(at: index)
                }
                elementsRemoved.append(word)
            }else{
                
                if elementsRemoved.contains(word){
                    //do not add any word that is been removed
                }else{
                    tempList.append(word)
                }
            }
        }
        return tempList
    }
    
    /// Swaps first and last element in array
    public func swap(first: Element, last: Element) -> [Element] {
        var list: [Element] = self
        if let index1 = list.index(of: first),
            let index2 = list.index(of: last) {
            list.swapAt(index1, index2)
        }
        return list
    }
    
    /// Returns the number of times an element appears in an array
    public func elementOccurencesCount() -> [Element: Int] {
        return reduce(into: [:]) { (acc: inout [Element: Int], element) in
            acc[element] = acc[element]?.advanced(by: 1) ?? 1
        }
    }
    
    public func removeAllAfter(index: Int) -> [Element]{
        let list = self 
        if list.isEmpty { return [] }
        guard list.count > index else { return self }
        
        var temp : [Array.Iterator.Element] = []
        for (ind,element) in list.enumerated(){
            if (ind > index) {
                break
            }
            temp.append(element)
        }
        return temp
    }
    
}

public extension Array where Element: Comparable {
    public func containsSameElements(as other: [Element]) -> Bool {
        return count == other.count && sorted() == other.sorted()
    }
}
