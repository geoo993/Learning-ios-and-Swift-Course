//
//  UINavigationBar+Ext.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 22/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation


extension UINavigationBar {
    
    func clearNavigationBarBackground(){
        self.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
        self.backgroundColor = UIColor.clear
        
    }
}
