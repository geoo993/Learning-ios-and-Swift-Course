//
//  PartialCircleView.swift
//  CoreGraphicsShapes
//
//  Created by GEORGE QUENTIN on 05/09/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

// https://stackoverflow.com/questions/28490355/drawing-a-partial-circle

import UIKit

@IBDesignable
public class PartialCircleView: UIView {

    @IBInspectable var mainColor: UIColor = UIColor.blue
        {
        didSet { print("mainColor was set here") }
    }
    @IBInspectable var ringColor: UIColor = UIColor.orange
        {
        didSet { print("bColor was set here") }
    }
    @IBInspectable var ringThickness: CGFloat = 4
        {
        didSet { print("ringThickness was set here") }
    }
    
    @IBInspectable var radius: CGFloat = 25.0 {
        didSet{
            if radius >  0.0 {
                //the view needs to be refreshed
                setNeedsDisplay()
            }else {
                radius = 0.0
            }
        }
    }
    
    @IBInspectable var ratio: CGFloat = 1.0 {
        didSet{
            if ratio > 0.0 && ratio < 100.0  {
                //the view needs to be refreshed
                ratio = ratio / 100.0
                setNeedsDisplay()
            }else {
                ratio = 0.0
            }
            
        }
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    } 
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        // Drawing code
        drawPartialCircle(with:rect )
    }
    
    func drawPartialCircle( with rect : CGRect) {
        
        let circleCenter = CGPoint(x:rect.midX, y:rect.midY)
        
        let start = CGFloat(3 * (CGFloat.pi / 2) )
        let end = start + CGFloat(2 * CGFloat.pi * ratio)
        let partialCirclePath = UIBezierPath(arcCenter: circleCenter, radius: radius, startAngle: start, endAngle: end, clockwise: true)
        
        let fillLayer = CAShapeLayer()
        fillLayer.path = partialCirclePath.cgPath
        fillLayer.fillColor = mainColor.cgColor
        layer.addSublayer(fillLayer)
        
        let strokeLayer = CAShapeLayer()
        strokeLayer.path = partialCirclePath.cgPath
        strokeLayer.fillColor = UIColor.clear.cgColor
        strokeLayer.strokeColor = ringColor.cgColor
        strokeLayer.lineWidth = ringThickness
        layer.addSublayer(strokeLayer)
        
    }
    

}
