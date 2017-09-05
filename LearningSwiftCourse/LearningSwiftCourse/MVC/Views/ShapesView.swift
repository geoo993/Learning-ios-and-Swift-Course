//
//  ShapeView.swift
//  CoreGraphicsShapes
//
//  Created by GEORGE QUENTIN on 05/09/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

// https://wingoodharry.wordpress.com/2015/06/24/ibinspectable-and-ibdesignable-swift/
// https://www.ioscreator.com/tutorials/drawing-shapes-core-graphics-tutorial-ios10

// https://github.com/ccabanero/ios-coregraphics-snippets
//

import UIKit


extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}
extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}


@IBDesignable
public class ShapeView: UIView {

    let π : CGFloat = CGFloat.pi
    
    @IBInspectable var cornerRadius: CGFloat = 0
        {
        didSet
        {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var shapeType: Int
        {
        set(newValue)
        {
            internalShapeType = min(newValue, 10)
            internalShapeType = max(0, internalShapeType)
        }
        get{
            return internalShapeType
        }
    }
    
    var internalShapeType: Int = 0
   
    @IBInspectable var lineWidth: CGFloat = 1.0 {
        didSet{
            if lineWidth >  0.0 {
                //the view needs to be refreshed
                setNeedsDisplay()
            }else {
                lineWidth = 0.0
            }
        }
    }
    
    @IBInspectable var numberOfStars: Int = 2 {
        didSet{
            if numberOfStars >  0 {
                //the view needs to be refreshed
                setNeedsDisplay()
            }else {
                numberOfStars = 1
            }
        }
    }
 
    @IBInspectable var starsSize: CGFloat = 10.0 {
        didSet{
            if starsSize >  0.0 {
                //the view needs to be refreshed
                setNeedsDisplay()
            }else {
                starsSize = 0.0
            }
        }
    }
    
    @IBInspectable var shapeColor: UIColor = UIColor.blue
    {
        didSet { 
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var lineColor: UIColor = UIColor.orange
    {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var gradientStartColor: UIColor = UIColor.gray
    {
        didSet { 
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var gradientEndColor: UIColor = UIColor.black
        {
        didSet { 
            setNeedsDisplay()
        }
    }
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override public func draw(_ rect: CGRect)
    {
        drawShape(with: rect, type:internalShapeType)
    }
    
    func drawShape( with rect: CGRect, type: Int) {
        switch type {
        case 0:
            drawCross(with: rect )
        case 1:
            drawCircle(with : rect)
        case 2:
            drawRectangle(with: rect)
        case 3:
            drawArc(with : rect)
        case 4:
            drawEllipse(with : rect)
        case 5:
            drawTriangle(with : rect)
        case 6:
            drawStars(with: rect)
        case 7:
            drawGradient(with: rect)
        default:
            break
        }
    }
    
    override public func layoutSubviews()
    {
        super.layoutSubviews()
    }
    
}


extension ShapeView {
    
    func drawCross( with rect : CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.move(to: CGPoint.zero)
        context.addLine(to: CGPoint(x:rect.width,y:rect.height))
        context.move(to: CGPoint(x:rect.width,y:0))
        context.addLine(to: CGPoint(x:0,y:rect.height))
        
        lineColor.set()
        context.setLineWidth(lineWidth);
        context.strokePath();
    }
    
    func drawCircle( with rect: CGRect)
    {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let insection:CGFloat = lineWidth/2
        let circleRect = rect.insetBy(dx: insection, dy: insection)
        
        // shadow
        //let blur : CGFloat = 6.0
        //let shadowOffset = CGSize(width:15, height:15)
        //context.setShadow(offset: shadowOffset, blur: blur)
        
        // ellipse
        context.addEllipse(in: circleRect)
        
        lineColor.set()
        
        context.setLineWidth(lineWidth);
        context.setStrokeColor(lineColor.cgColor)
        context.strokePath()
        
        // fill
        context.setFillColor(shapeColor.cgColor)
        context.fillEllipse(in: circleRect)
        
    }
    
    func drawRectangle( with rect : CGRect ) {
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let rectangleWidth:CGFloat = rect.size.width - 10
        let rectangleHeight:CGFloat = (rectangleWidth * 0.75)
        
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        
        //4
        ctx.addRect(CGRect(x: center.x - (0.5 * rectangleWidth), y: center.y - (0.5 * rectangleHeight), width: rectangleWidth, height: rectangleHeight))
        ctx.setLineWidth(lineWidth)
        ctx.setStrokeColor(lineColor.cgColor)
        ctx.strokePath()
        
        //5
        ctx.setFillColor(shapeColor.cgColor)
        
        ctx.addRect(CGRect(x: center.x - (0.5 * rectangleWidth), y: center.y - (0.5 * rectangleHeight), width: rectangleWidth, height: rectangleHeight))
        
        ctx.fillPath()
    }
    
    func drawArc( with rect : CGRect) {
       
        // center of view
        let center = CGPoint(x:rect.size.width/2, y: rect.size.height/2)
        
        // derived from max width/height dimensions of view
        let radius: CGFloat = max(rect.size.width, rect.size.height)
        
        
        // start and end angles of arc
        let startAngle: CGFloat = 3 * π / 4 //note: use alt + p to get pi
        let endAngle: CGFloat = π / 4
        
        // create path based on center, radius, and angles
        let path = UIBezierPath(arcCenter: center,
                                radius: radius/3 - lineWidth/3,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        // set line width
        path.lineWidth = lineWidth
        lineColor.setStroke()
        
        // stroke the path
        path.stroke()
    }
    
    func drawEllipse(with rect : CGRect){
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let insection:CGFloat = lineWidth/2
        let circleRect = rect.insetBy(dx: insection, dy: insection)
        
        context.setLineWidth(lineWidth)
        
        context.setStrokeColor(lineColor.cgColor)
        
        context.addEllipse(in: circleRect)
        
        context.strokePath()
    }
    
    func drawTriangle (with rect : CGRect){
        
        // get the graphics context for the view
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // line width
        context.setLineWidth(lineWidth)
        
        // stroke color
        context.setStrokeColor(lineColor.cgColor)
        
        // triangle path
        context.move(to: CGPoint(x: 100, y: 50))
        context.addLine(to: CGPoint(x: 150, y: 200))
        context.addLine(to: CGPoint(x: 50, y: 200))
        context.addLine(to: CGPoint(x: 100, y: 50))
        
        // draw line
        context.strokePath()
        
    }
    
    private func drawStars(with rect: CGRect) {
        
        // get the graphics context for the view
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        var xCenter : CGFloat = rect.minX + starsSize
        let yCenter : CGFloat = rect.midY
        
        let w : CGFloat = starsSize;
        let r : CGFloat = w / 2.0;
        let flip : CGFloat = -1.0;
        
        for _ in 1...numberOfStars {
            
            context.setFillColor(shapeColor.cgColor)
            
            let theta = 2.0 * π * (2.0 / 5.0); // 144 degrees
            
            context.move(to: CGPoint(x: CGFloat(xCenter), y: CGFloat(r * flip + yCenter)))
            
            
            for index in 1...4 {
                let x = r * sin(CGFloat(index) * theta)
                let y = r * cos(CGFloat(index) * theta)
                
                context.addLine(to: CGPoint(x: CGFloat(x + xCenter), y: CGFloat(y * flip + yCenter)))
                
            }
            
            let spaceBetweenStars = w + 10
            xCenter += spaceBetweenStars;
        }
        context.closePath()
        context.fillPath()
    }
    
    func drawGradient(with rect: CGRect) {
        
        /*
        // round the top left and right corners by clipping with path
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [UIRectCorner.topLeft,  UIRectCorner.topRight], cornerRadii: CGSize(width: 20.0, height: 20.0))
        path.addClip()
        */
        
        // get the graphics context for the view
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // create gradient with - colors, color space, and color stop locations
        let colors = [gradientStartColor.cgColor, gradientEndColor.cgColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations:[CGFloat] = [0.0, 1.0]
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: colorLocations) else { return }
        
        // draw the background gradient
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: rect.size.height)
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions.drawsAfterEndLocation)
       
    }
 
    
    
}

