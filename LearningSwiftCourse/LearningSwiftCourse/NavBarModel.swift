//
//  NavBarModel.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 17/04/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation
import UIKit

class NavBarModel {

    var enteredString:String!
    
    init(){
        enteredString = ""
    }

    func numLetters() -> Int {
        var i = 0
        //count all the letters:
        for _ in enteredString.characters {
            i += 1
        }
        
        return i
        
    }
    
    func numWords() -> Int {
        var i = 1
        //count all the spaces:
        for letter in enteredString.characters {
            if letter == " " { 
                i += 1 
            }
        }
        return i
    }
    
    func index() -> [String:Int] {
        var indexDictionary = Dictionary<String, Int>()
        let punctuation = NSCharacterSet.punctuationCharacters
        let space = NSCharacterSet.whitespaces
        let wordArray:[String] = enteredString.components(separatedBy:space)
        for i in 0 ..< wordArray.count {
            let word = wordArray[i].trimmingCharacters(in: punctuation)
            if !word.isEmpty {
                if let value = indexDictionary[word] {
                    indexDictionary.updateValue(value + 1, forKey: word)
                } else {
                    indexDictionary.updateValue(1, forKey: word)
                }
            }
        }
        print("\(indexDictionary)")
        return indexDictionary
    }
    
    deinit {
        print("Exiting Nav Bar Model \(#function)")
    }
}
