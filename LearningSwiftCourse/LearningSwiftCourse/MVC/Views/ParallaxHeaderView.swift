//
//  ParallaxHeaderView.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 10/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//https://stackoverflow.com/questions/42953360/swift-how-to-do-add-an-header-with-parallax-effect-to-tableview

import Foundation
import UIKit

final class ParallaxHeaderView: UIView {
    
    fileprivate var heightLayoutConstraint = NSLayoutConstraint()
    fileprivate var bottomLayoutConstraint = NSLayoutConstraint()
    fileprivate var containerView = UIView()
    fileprivate var containerLayoutConstraint = NSLayoutConstraint()
    
    fileprivate var originalFrame = CGRect()
    
    fileprivate var headerBgColor = UIColor.red
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.originalFrame = self.frame
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = headerBgColor
        self.backgroundColor = headerBgColor
        
        self.addSubview(containerView)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[containerView]|",
                                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                           metrics: nil,
                                                           views: ["containerView" : containerView]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[containerView]|",
                                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                           metrics: nil,
                                                           views: ["containerView" : containerView]))
        
        containerLayoutConstraint = NSLayoutConstraint(item: containerView,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: self,
                                                       attribute: .height,
                                                       multiplier: 1.0,
                                                       constant: 0.0)
        self.addConstraint(containerLayoutConstraint)
        
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = headerBgColor
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "YourImage")
        
        containerView.addSubview(imageView)
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageView]|",
                                                                    options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                    metrics: nil,
                                                                    views: ["imageView" : imageView]))
        
        bottomLayoutConstraint = NSLayoutConstraint(item: imageView,
                                                    attribute: .bottom,
                                                    relatedBy: .equal,
                                                    toItem: containerView,
                                                    attribute: .bottom,
                                                    multiplier: 1.0,
                                                    constant: 0.0)
        
        containerView.addConstraint(bottomLayoutConstraint)
        
        heightLayoutConstraint = NSLayoutConstraint(item: imageView,
                                                    attribute: .height,
                                                    relatedBy: .equal,
                                                    toItem: containerView,
                                                    attribute: .height,
                                                    multiplier: 1.0,
                                                    constant: 0.0)
        
        containerView.addConstraint(heightLayoutConstraint)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        containerLayoutConstraint.constant = scrollView.contentInset.top
        let yPosition = scrollView.contentOffset.y
        let offsetY = -(yPosition + scrollView.contentInset.top)
      
        containerView.clipsToBounds = offsetY <= 0
        bottomLayoutConstraint.constant = offsetY >= 0 ? 0 : -offsetY / 2
        heightLayoutConstraint.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
        
//        var headerFrame = self.frame
//        
//        // Adjust view
//        if yPosition < 0 {
//            headerFrame = CGRect(x: self.frame.origin.x,
//                                 y: 0,
//                                 width: self.frame.size.width,
//                                 height: self.originalFrame.size.height - yPosition) //-- is positive
//        }else{
//            headerFrame = CGRect(x: self.frame.origin.x,
//                                 y: 0,
//                                 width: self.frame.size.width,
//                                 height: self.originalFrame.size.height)
//        }
//        self.containerView.frame = headerFrame
//        self.frame = headerFrame
        
    }
    
}
