//
//  BezierView.swift
//  Bezier
//
//  Created by Ramsundar Shandilya on 10/14/15.
//  Copyright © 2015 Y Media Labs. All rights reserved.
//

import UIKit
import Foundation

public protocol BezierViewDataSource: class {
    func bezierViewDataPoints(bezierView: BezierView) -> [CGPoint]
}

public class BezierView: UIView {
   
    public let kStrokeAnimationKey = "StrokeAnimationKey"
    public let kFadeAnimationKey = "FadeAnimationKey"
    
    //MARK: Public members
    weak var dataSource: BezierViewDataSource?
    
    var lineColor = UIColor(red: 233.0/255.0, green: 98.0/255.0, blue: 101.0/255.0, alpha: 1.0)
    var shadowColor = UIColor.black
    var dashLines = false
    var dashLinesPattern : [NSNumber] = []
    var animates = false
    
    fileprivate let besierPath = UIBezierPath()
    var pointLayers = [CAShapeLayer]()
    
    var makeRoad = false
    fileprivate var lineLayer = CAShapeLayer()
    var lineWidth : CGFloat = 1
    
    fileprivate var outlineLayer = CAShapeLayer()
    var outlineWidth : CGFloat = 1
    
    fileprivate var roadlineLayer = CAShapeLayer()
    var roadlineWidth : CGFloat = 10
    
    //MARK: Private members
    
    private var dataPoints: [CGPoint]? {
        return self.dataSource?.bezierViewDataPoints(bezierView: self)
    }
    
    private let cubicCurveAlgorithm = BezierCubicCurveAlgorithm()
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.sublayers?.forEach({ (layer: CALayer) -> () in
            layer.removeFromSuperlayer()
        })
        pointLayers.removeAll()
        
        drawSmoothLines()
        //drawPoints()
        
        //animateLayers()
    }
    
    private func drawPoints(){
        
        guard let points = dataPoints else {
            return
        }
       
        for point in points {
            
            let circleLayer = CAShapeLayer()
            circleLayer.bounds = CGRect(x: 0, y: 0, width: 12, height: 12)
            circleLayer.path = UIBezierPath(ovalIn: circleLayer.bounds).cgPath
            circleLayer.fillColor = UIColor(white: 248.0/255.0, alpha: 0.5).cgColor
            circleLayer.position = point
            
            circleLayer.shadowColor = shadowColor.cgColor
            circleLayer.shadowOffset = CGSize(width: 0, height: 2)
            circleLayer.shadowOpacity = 0.7
            circleLayer.shadowRadius = 3.0
            
            self.layer.addSublayer(circleLayer)
            
            if animates {
                circleLayer.opacity = 0
                pointLayers.append(circleLayer)
            }else{
                circleLayer.opacity = 1
                pointLayers.append(circleLayer)
            }
        }
    }
    
    private func drawSmoothLines() {
        
        guard let points = dataPoints else {
            return
        }
        
        let controlPoints = cubicCurveAlgorithm.controlPointsFromPoints(dataPoints: points)
        print("control points ", controlPoints.count)
        
        for i in 0..<points.count {
            
            let point = points[i];
            
            if i==0 {
                besierPath.move(to: point)
            } else {
                
                let segment = controlPoints[i-1]
                besierPath.addCurve(to: point, controlPoint1: segment.controlPoint1, controlPoint2: segment.controlPoint2)
            }
        }
        
        print("cgpath element points: ", besierPath.cgPath.getPathElementsPoints().count)
        print("length: ", besierPath.length)
        
        if (makeRoad) {
            
            // outside outline
            outlineLayer = CAShapeLayer()
            outlineLayer.path = besierPath.cgPath
            outlineLayer.fillColor = UIColor.clear.cgColor
            outlineLayer.strokeColor = UIColor.white.cgColor
            outlineLayer.lineWidth = roadlineWidth + outlineWidth
            
            outlineLayer.shadowColor = shadowColor.cgColor
            outlineLayer.shadowOffset = CGSize(width: 0, height: 8)
            outlineLayer.shadowOpacity = 0.5
            outlineLayer.shadowRadius = 6.0
            
            layer.addSublayer(outlineLayer)
            if animates {
                outlineLayer.strokeEnd = 0
            }else{
                outlineLayer.strokeEnd = 1
            }
            
            // black road line
            roadlineLayer = CAShapeLayer()
            roadlineLayer.path = besierPath.cgPath
            roadlineLayer.fillColor = UIColor.clear.cgColor
            roadlineLayer.strokeColor = UIColor.black.cgColor
            roadlineLayer.lineWidth = roadlineWidth
            layer.addSublayer(roadlineLayer)
            if animates {
                roadlineLayer.strokeEnd = 0
            }else{
                roadlineLayer.strokeEnd = 1
            }
        }
        
        // https://stackoverflow.com/questions/38689322/swift-how-to-get-rounded-cap-on-cashapelayer-or-uibezierpathovalinrect-ovalr
        // https://stackoverflow.com/questions/13679923/dashed-line-border-around-uiview
        // https://stackoverflow.com/questions/26018302/draw-dotted-not-dashed-line-with-ibdesignable-in-2017
        lineLayer = CAShapeLayer()
        lineLayer.path = besierPath.cgPath
        lineLayer.fillColor = UIColor.clear.cgColor
        lineLayer.strokeColor = lineColor.cgColor
        lineLayer.lineWidth = lineWidth
        
        if dashLines || makeRoad {
            lineLayer.lineJoin = kCALineJoinRound
            lineLayer.lineDashPattern = dashLinesPattern // adjust to your liking [width, height]
            //lineLayer.lineCap = kCALineCapRound
        }
        
        if (makeRoad == false) {
            lineLayer.shadowColor = shadowColor.cgColor
            lineLayer.shadowOffset = CGSize(width: 0, height: 8)
            lineLayer.shadowOpacity = 0.5
            lineLayer.shadowRadius = 6.0
        }
        
        layer.addSublayer(lineLayer)
        
        if animates {
            lineLayer.strokeEnd = 0
        }else{
            lineLayer.strokeEnd = 1
        }
        
        
    }
    
    public func getBezierPath() -> UIBezierPath{
        return besierPath
    }
    
    public func getPathInterpolationPoints() -> [CGPoint]{
        return besierPath.cgPath.getPathElementsPoints()
    }
    
}


public extension BezierView {
    
    public func animateLayers() {
        animatePoints()
        animateLine()
    }
    
    public func animatePoints() {
        
        var delay = 0.2
        
        for point in pointLayers {
            
            let fadeAnimation = CABasicAnimation(keyPath: "opacity")
            fadeAnimation.toValue = 1
            fadeAnimation.beginTime = CACurrentMediaTime() + delay
            fadeAnimation.duration = 0.2
            fadeAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            fadeAnimation.fillMode = kCAFillModeForwards
            fadeAnimation.isRemovedOnCompletion = false
            point.add(fadeAnimation, forKey: kFadeAnimationKey)
            
            delay += 0.15
        }
    }
    
    public func animateLine() {
        
        let growAnimation = CABasicAnimation(keyPath: "strokeEnd")
        growAnimation.toValue = 1
        growAnimation.beginTime = CACurrentMediaTime() + 0.5
        growAnimation.duration = 1.5
        growAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        growAnimation.fillMode = kCAFillModeForwards
        growAnimation.isRemovedOnCompletion = false
        lineLayer.add(growAnimation, forKey: kStrokeAnimationKey)
    }
    
}


