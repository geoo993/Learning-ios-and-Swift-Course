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
    
    /// Return text field inside a search bar
    var textField: UITextField? {
        let subViews = subviews.flatMap { $0.subviews }
            guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else { return nil
        }
        return textField
    }
    
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
