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

public extension Dictionary where Value: Any {
    
    public func isEqual(to otherDict: [Key: Any], 
                        allPossibleValueTypesAreKnown: Bool = false) -> Bool? {
        guard allPossibleValueTypesAreKnown else { return nil }
        guard self.count == otherDict.count else { return false }
        for (k1,v1) in self {
            guard let v2 = otherDict[k1] else { return false }
            switch (v1, v2) {
            case (let v1 as Double, let v2 as Double) : if !(v1.isEqual(to: v2)) { return false }
            case (let v1 as Int, let v2 as Int) : if !(v1==v2) { return false }
            case (let v1 as String, let v2 as String): if !(v1==v2) { return false }
            // ... 
            case (_ as Double, let v2): if !(v2 is Double) { return false }
            case (_, _ as Double): return false
            case (_ as Int, let v2): if !(v2 is Int) { return false }
            case (_, _ as Int): return false
            case (_ as String, let v2): if !(v2 is String) { return false }
            case (_, _ as String): return false
            default: return nil
            }
        }
        return true
    }
}
