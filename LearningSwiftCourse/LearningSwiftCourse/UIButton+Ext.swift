//
//  UIButton+Ext.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 03/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation
import UIKit


extension UIButton {
    
   
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.clear : UIColor.clear
        }
    }
    
    /*
    override open var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? UIColor.lightGray : UIColor.white
        }
    }
    */
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x:0.0,y:0.0,width: 1.0,height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    func setBackgroundColor(color: UIColor, for state: UIControlState) {
        self.setBackgroundImage(imageWithColor(color: color), for: state)
    }
    
}
