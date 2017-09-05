//
//  RoundedCornerView.swift
//  CoreGraphicsShapes
//
//  Created by GEORGE QUENTIN on 05/09/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//
// http://lab.dejaworks.com/uiview-with-rounded-background-designable-in-storyboard/

import UIKit

@IBDesignable
public class RoundedCornerView: UIView {

    @IBInspectable var rectWidth:   CGFloat = 60
    @IBInspectable var rectHeight:  CGFloat = 40
    
    @IBInspectable var rectBgColor:     UIColor = UIColor.darkGray
    @IBInspectable var rectBorderColor: UIColor = UIColor.lightGray
    @IBInspectable var rectBorderWidth: CGFloat = 2
    @IBInspectable var rectCornerRadius:CGFloat = 5
        {
        didSet { print("cornerRadius was set here")
            invalidateIntrinsicContentSize()
        }
    }
    
    override public func draw(_ rect: CGRect)
    {
        super.draw(rect)
        roundRect()
    }
    
    internal func roundRect()
    {
        let xf:CGFloat = (self.frame.width  - rectWidth)  / 2
        let yf:CGFloat = (self.frame.height - rectHeight) / 2
        
        let ctx: CGContext = UIGraphicsGetCurrentContext()!
        ctx.saveGState()
        
        ctx.setLineWidth(rectBorderWidth)
        ctx.setStrokeColor(rectBorderColor.cgColor)
        
        
        let rect = CGRect(x: xf, y: yf, width: rectWidth, height: rectHeight)
        let clipPath: CGPath = UIBezierPath(roundedRect: rect, cornerRadius: rectCornerRadius).cgPath
        let linePath: CGPath = UIBezierPath(roundedRect: rect, cornerRadius: rectCornerRadius).cgPath
        
        
        ctx.addPath(clipPath)
        ctx.setFillColor(rectBgColor.cgColor)
        ctx.closePath()
        ctx.fillPath()
        
        ctx.addPath(linePath)
        ctx.strokePath()
        
        ctx.restoreGState()
        
    }
}
