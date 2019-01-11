//
//  AnimatableCircleView.swift
//  CoreGraphicsShapes
//
//  Created by GEORGE QUENTIN on 05/09/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

// https://stackoverflow.com/questions/26578023/animate-drawing-of-a-circle
//

import UIKit

@IBDesignable
public class AnimatableCircleView: UIView {

    @IBInspectable var lineColor: UIColor = UIColor.red {
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var lineWidth: CGFloat = 5.0 {
        didSet{
            if lineWidth >  0.0 {
                //the view needs to be refreshed
                setNeedsDisplay()
            }else {
                lineWidth = 0.0
            }
        }
    }
    
    @IBInspectable var clockWise: Bool = false
    
    var circleLayer: CAShapeLayer!
    var isAnimating = false
    
    func setCircle( clockWise : Bool, rect : CGRect){
        // Use UIBezierPath as an easy way to create the CGPath for the layer.
        // The path should be the entire circle.
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0), radius: (rect.size.width - 10) / 2, startAngle: 0.0, endAngle: CGFloat(CGFloat.pi * 2.0), clockwise: clockWise)
        
        //circleLayer?.removeFromSuperlayer()
        circleLayer = setCirleShapeLayer(with: circlePath)
        layer.addSublayer(circleLayer)
    }

    func setCirleShapeLayer(with circlePath: UIBezierPath) -> CAShapeLayer{
        
        // Setup the CAShapeLayer with the path, colors, and line width
        let circleShape = CAShapeLayer()
        circleShape.path = circlePath.cgPath
        circleShape.fillColor = UIColor.clear.cgColor
        circleShape.strokeColor = lineColor.cgColor
        circleShape.lineWidth = lineWidth
        
        // Don't draw the circle initially
        circleShape.strokeEnd = 0.0
        return circleShape
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        setCircle(clockWise: clockWise, rect: frame)
    } 
   
    
    func animate(duration: TimeInterval){
        self.isAnimating = true
        self.animateToFullCircle(duration: duration)
    }
    
    func endAnimate(){
        self.isAnimating = false
    }
    
    func animateToFullCircle(duration: TimeInterval) {
        if self.isAnimating{
            CATransaction.begin()
            
            // We want to animate the strokeEnd property of the circleLayer
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            
            // Set the animation duration appropriately
            animation.duration = duration
            
             // Animate from 0 (empty circle) to 1 (full circle)
            animation.fromValue = 0
            animation.toValue = 1
            
            // Do a EaseInEaseOut animation (i.e. the speed of the animation stays the same)
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            
//            // Do a linear animation (i.e. the speed of the animation stays the same)
//            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            
            // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
            // right value when the animation ends.
            circleLayer.strokeEnd = 1.0
            
            // Completion block specifies what happens when animation ends
            CATransaction.setCompletionBlock { 
                self.animateToEmptyCircle(duration: duration)
            }
            
            // Do the actual animation
            circleLayer.add(animation, forKey: "animateCircle")
            CATransaction.commit()
        }
    }
    
    func animateToEmptyCircle(duration: TimeInterval){
        if self.isAnimating{
            CATransaction.begin()
            
            // We want to animate the strokeEnd property of the circleLayer
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            
            // Set the animation duration appropriately
            animation.duration = duration
            
             // Animate from 1 (full circle) to 0 (empty circle)
            animation.fromValue = 1
            animation.toValue = 0
            
            // Do a EaseInEaseOut animation (i.e. the speed of the animation stays the same)
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            
            // Set the circleLayer's strokeEnd property to 0.0 now so that it's the
            // right value when the animation ends.
            circleLayer.strokeEnd = 0
            
            // Completion block specifies what happens when animation ends
            CATransaction.setCompletionBlock {
                self.animateToFullCircle(duration: duration)
            }
            
            // Do the actual animation
            circleLayer.add(animation, forKey: "animateCircle")
            CATransaction.commit()
        }
    }
    
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override public func draw(_ rect: CGRect) {
        // Drawing code
        setCircle(clockWise: clockWise, rect: rect)
    }

}
