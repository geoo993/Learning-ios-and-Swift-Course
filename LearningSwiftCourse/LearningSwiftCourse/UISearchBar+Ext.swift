//
//  UISearchBar+Ext.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 25/05/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation
import UIKit

extension UISearchBar {
    
    var textColor:UIColor? {
        get {
            if let textField = self.value(forKey: "searchField") as? 
                UITextField  {
                return textField.textColor
            } else {
                return nil
            }
        }
        
        set (newValue) {
            if let textField = self.value(forKey: "searchField") as? 
                UITextField  {
                textField.textColor = newValue
            }
        }
    }
    
    var textFont:UIFont? {
        get {
            if let textField = self.value(forKey: "searchField") as? 
                UITextField  {
                return textField.font
            } else {
                return nil
            }
        }
        
        set (newValue) {
            if let textField = self.value(forKey: "searchField") as? 
                UITextField  {
                textField.font = newValue
            }
        }
    }
}
