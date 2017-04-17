//
//  Model.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 17/04/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation
import UIKit

class TabBarModel {
    
    var inches:Double
    
    var feet:Double { return inches / 12 }
    var miles:Double { return feet / 5200 }
    var centimeters:Double {
        
        get {
            return inches * 2.53
        }
        set{
            inches = newValue / 2.54
        }
        
    }
    var meters:Double { return centimeters / 100 }
    var kilometers:Double { return meters / 1000 }
    
    init(){
        inches = 0
    }
    
    deinit {
        print("Exiting Tab Bar Model \(#function)")
    }
}
