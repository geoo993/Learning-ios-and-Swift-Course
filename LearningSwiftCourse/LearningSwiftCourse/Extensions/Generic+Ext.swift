//
//  Generic+Ext.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 03/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation
import UIKit

public func urlToDocumentFile(filename: String) -> NSURL! {
    var path = [String]()
    for p in NSSearchPathForDirectoriesInDomains(
        FileManager.SearchPathDirectory.documentDirectory,
        FileManager.SearchPathDomainMask.userDomainMask, true) {
            path.append(p)
    }
    
    path.append(filename)
    
    return NSURL.fileURL(withPathComponents: path) as NSURL!
}

public func pathToDocumentFile(filename: String) -> String? {
    let url = urlToDocumentFile(filename: filename)
    return url?.path
}

public extension NSRange {
    public var toRange : Range<Int> {
        return location ..< (location + length)
    }
}


//public extension Sequence where Iterator.Element: Hashable {
//    var uniqueElements: [Iterator.Element] {
//        return Array( Set(self) )
//    }
//}
//public extension Sequence where Iterator.Element: Equatable {
//    var uniqueElements: [Iterator.Element] {
//        return self.reduce([]){
//            uniqueElements, element in
//            
//            uniqueElements.contains(element)
//                ? uniqueElements
//                : uniqueElements + [element]
//        }
//    }
//}

public protocol GameSequenceExtensions : RangeReplaceableCollection {}

extension Array : GameSequenceExtensions { }

public extension GameSequenceExtensions where Self.Iterator.Element: Hashable {
    public typealias Element = Self.Iterator.Element
    
    public func uniqueElements() -> [Element] {
        guard let list = (self as? [Element]) else { return [] }
        
        // Convert array into a set to get unique values.
        let uniques = Set<Element>(list)
        // Convert set back into an Array of Ints.
        let result = Array<Element>(uniques)
        return result
    }

    public func skipDuplicates() -> [Element] {
        
        guard var list = (self as? [Self.Iterator.Element]) else { return [] }
        
        //do not take duplicated words
        var tempList : [Self.Iterator.Element] = []
        var elementsRemoved : [Self.Iterator.Element] = []
        
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
    
    public func frequentElements() -> [Element: Int] {
        return reduce([:]) { (accu: [Element: Int], element) in
            var accu = accu
            accu[element] = accu[element]?.advanced(by: 1) ?? 1
            return accu
        }
    }
    
    public func chooseOne () -> Element {
        
        let list: [Element] = self as! [Element]
        let len = UInt32(list.count)
        let random = Int(arc4random_uniform(len))
        return list[random]
    }
    
    public func take(_ amount: Int) -> [Element] {
        guard var list = (self as? [Self.Iterator.Element]), list.count > 1, amount <= list.count else { return [] }
        
        var temp : [Self.Iterator.Element] = []
        var count = amount
        
        while count > 0 {
            let index = Int(arc4random_uniform(UInt32(list.count - 1)))
            temp.append(list[index])
            list.remove(at: index)
            
            count -= 1
        }
        
        return temp
    }
    
    public func randomise() -> [Element] {
        
        guard var list = (self as? [Self.Iterator.Element]), list.count > 0 else { return [] }
        
        var temp : [Self.Iterator.Element] = []
        
        while list.count > 0 {
            let index = Int(arc4random_uniform(UInt32(list.count - 1)))
            temp.append(list[index])
            list.remove(at: index)
        }
        
        return temp
    }
    
    public func makePairs () -> [Element] { 
        guard let list = (self as? [Self.Iterator.Element]) else { return [] }
        let temp = list + list
        return temp.randomise()
    }
    
    public func removeAllAfter(index: Int) -> [Element]{
        
        guard let list = (self as? [Self.Iterator.Element]), list.count > index else { return [] }
        
        var temp : [Self.Iterator.Element] = []
        for (ind,element) in list.enumerated(){
            if (ind <= index) {
               temp.append(element) 
            } 
        }
        return temp
    }
       
}



