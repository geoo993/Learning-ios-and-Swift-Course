//
//  Dictionary+Ext.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 03/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation

public extension Dictionary where Value: Equatable {
    public func firstKeyForValue(forValue val: Value) -> Key? {
        return first(where: { $0.1 == val })?.0
    }
    public func allKeysForValue(val : Value) -> [Key] {
        return self.filter { $0.1 == val }.map { $0.0 }
    }
    
    public func getKeyString(index : Int) -> String{
        return Array(self)[index].key as? String ?? ""
    }
    
    public func getKeyInt(index : Int) -> Int{
       return Array(self)[index].key as? Int ?? 0
    }
    
    public func getValueString(index : Int) -> String{
        return Array(self)[index].value as? String ?? ""
    }
    
    public func getValueInt(index : Int) -> Int {
        return Array(self)[index].value as? Int ?? 0
    }
}
