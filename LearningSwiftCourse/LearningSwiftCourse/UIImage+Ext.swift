//
//  String+Ext.swift
//  UITableViewApp
//
//  Created by GEORGE QUENTIN on 15/10/2016.
//  Copyright © 2016 GEORGE QUENTIN. All rights reserved.
//

import Foundation
import UIKit

public  extension UIImage {
    
    /// Resizes an image to the specified size.
    ///
    /// - Parameters:
    ///     - size: the size we desire to resize the image to.
    ///
    /// - Returns: the resized image.
    ///
    public  func imageWithSize(size: CGSize) -> UIImage {
        
        if UIScreen.main.responds(to: #selector(NSDecimalNumberBehaviors.scale)){
            UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale);
        }
        else
        {
            UIGraphicsBeginImageContext(size);
        }
        
        let rect = CGRect(x:0.0, y:0.0,width: size.width, height:size.height);
        draw(in: rect)
        guard let resultingImage = UIGraphicsGetImageFromCurrentImageContext() else { print("UIGraphicsGetImageFromCurrentImageContext is Nil "); return UIImage() };
        UIGraphicsEndImageContext();
        
        return resultingImage
    }
    
    /// Resizes an image to the specified size and adds an extra transparent margin at all sides of
    /// the image.
    ///
    /// - Parameters:
    ///     - size: the size we desire to resize the image to.
    ///     - extraMargin: the extra transparent margin to add to all sides of the image.
    ///
    /// - Returns: the resized image.  The extra margin is added to the input image size.  So that
    ///         the final image's size will be equal to:
    ///         `CGSize(width: size.width + extraMargin * 2, height: size.height + extraMargin * 2)`
    ///
    public func imageWithSize(size: CGSize, extraMargin: CGFloat) -> UIImage {
        
        let imageSize = CGSize(width: size.width + extraMargin * 1.5, height: size.height + extraMargin * 1.5)
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale);
        let rect = CGRect(x: extraMargin, y: extraMargin, width: size.width, height: size.height)
        draw(in: rect)
        
        guard let resultingImage = UIGraphicsGetImageFromCurrentImageContext() else { print("UIGraphicsGetImageFromCurrentImageContext is Nil "); return UIImage() };
        UIGraphicsEndImageContext();
        
        return resultingImage
    }
    
    //Summon this function VVV
    public  func resizeImageWithAspect(image: UIImage,scaledToMaxWidth width:CGFloat,maxHeight height :CGFloat)->UIImage
    {
        let oldWidth = image.size.width;
        let oldHeight = image.size.height;
        
        let scaleFactor = (oldWidth > oldHeight) ? width / oldWidth : height / oldHeight
        
        let newHeight = oldHeight * scaleFactor
        let newWidth = oldWidth * scaleFactor
        let newSize = CGSize(width: newWidth, height: newHeight)
        
        return self.imageWithSize(size: newSize)
    }
}
