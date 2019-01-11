//
//  UIButton+Ext.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 03/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation
import UIKit


public extension UIButton {
    
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
    
    public func setBackgroundColor(color: UIColor, for state: UIControl.State) {
        self.setBackgroundImage(imageWithColor(color: color), for: state)
    }
    
    public func alignContentVerticallyByCenter(offset:CGFloat = 10) {
        let buttonSize = frame.size
        
        if let titleLabel = titleLabel,
            let imageView = imageView {
            
            if let buttonTitle = titleLabel.text,
                let image = imageView.image {
                let titleString:NSString = NSString(string: buttonTitle)
                let titleSize = titleString.size(withAttributes: [
                    NSAttributedString.Key.font : titleLabel.font
                    ])
                let buttonImageSize = image.size
                
                let topImageOffset = (buttonSize.height - (titleSize.height + buttonImageSize.height + offset)) / 2
                let leftImageOffset = (buttonSize.width - buttonImageSize.width) / 2
                imageEdgeInsets = UIEdgeInsets(top: topImageOffset,
                                               left: leftImageOffset,
                                               bottom: 0,right: 0)
                
                let titleTopOffset = topImageOffset + offset + buttonImageSize.height
                let leftTitleOffset = (buttonSize.width - titleSize.width) / 2 - image.size.width
                
                titleEdgeInsets = UIEdgeInsets(top: titleTopOffset,
                                               left: leftTitleOffset,
                                               bottom: 0,right: 0)
            }
        }
    }
  
}
