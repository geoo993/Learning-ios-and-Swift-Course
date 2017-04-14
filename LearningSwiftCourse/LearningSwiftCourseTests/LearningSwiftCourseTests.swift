//
//  LearningSwiftCourseTests.swift
//  LearningSwiftCourseTests
//
//  Created by GEORGE QUENTIN on 12/04/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import XCTest
import UIKit

@testable import LearningSwiftCourse

class LearningSwiftCourseTests: XCTestCase {
    
    //http://stackoverflow.com/questions/24232799/why-choose-struct-over-class
    //Since struct instances are allocated on stack, and class instances are allocated on heap, structs can sometimes be drastically faster, but it really depends on how many values you're storing and the size / structure of them.
    
    //However, you should always measure it yourself and decide based on your unique use case.
    //Consider the following example, which demonstrates 2 strategies of wrapping Int data type (e.g. as part of a mathematics library)
    class IntClass {
        var value: Int
        init(_ val: Int) { self.value = val }
    }
    
    struct IntStruct {
        var value: Int
        init(_ val: Int) { self.value = val }
    }
    
    static func addclass(x: IntClass, y: IntClass) -> IntClass {
        return IntClass(x.value + y.value)
    }
    
    static func addstruct(x: IntStruct, y: IntStruct) -> IntStruct {
        return IntStruct(x.value + y.value)
    }
   
    func testClassPerformance() {
        // This is an example of a performance test case.
        
        // Test 1: IntClass
        self.measure {
            print("class (1 field)")
            var x = IntClass(0)
            for _ in 1...10000000 {
                x = LearningSwiftCourseTests.addclass(x:x,y: IntClass(1))
            }
        }
        
    }
    
    func testStructPerformance() {
        // Test 2: IntStruct
        self.measure {
            print("struct (1 field)")
            var y = IntStruct(0)
            for _ in 1...10000000 {
                y = LearningSwiftCourseTests.addstruct(x:y,y: IntStruct(1))
            }
        }
    
    }
    
   
    
    //The class version took 2.693s
    //The struct version took 0.110s
    //the struct is 2,600 times faster, almost 3 seconds.
    
    //Note #1: the difference is much less dramatic without whole module optimization. I'd be glad if someone can point out what the flag actually does.
    
    //Note #2: as someone mentioned that in real-world scenarios, there will be likely more than 1 field in a struct, I have added tests for structs/classes with 10 fields instead of 1. Surprisingly, results don't vary much.
    
    
    
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            
            
        }
    }
    
    func testPerformanceExample2() {
        
    }
}
