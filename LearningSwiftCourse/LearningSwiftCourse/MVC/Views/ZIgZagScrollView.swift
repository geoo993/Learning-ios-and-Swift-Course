//
//  ZIgZagScrollView.swift
//  HomePage
//
//  Created by GEORGE QUENTIN on 16/10/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import UIKit

@IBDesignable
public class ZIgZagScrollView: UIScrollView {

    fileprivate var bezierView: BezierView? {
        didSet{
            print("did set bezier view")
        }
    }
    
    var controlPoints = [CGPoint]()
    
    fileprivate var screenSize : CGRect {
        return UIScreen.main.bounds
    }
    
    fileprivate var inverse = false
    
    @IBInspectable var maxViews: Int = 30
    
    @IBInspectable var viewSize : CGFloat = 50 {
        didSet {
            print(viewSize)
        }
    }
    
    fileprivate var xOffset : CGFloat = 100
    @IBInspectable var horizontalGap : CGFloat = 80 { 
        didSet {
            print (horizontalGap)
            xOffset = horizontalGap
        }
    }
   
    fileprivate var yOffset : CGFloat = 50
    @IBInspectable var verticalGap : CGFloat = 50 { 
        didSet {
            print (verticalGap)
            yOffset = verticalGap
        }
    }
   
    fileprivate var leftMargin : CGFloat = 40  // left scroll view margin
    @IBInspectable var leftMarginValue: CGFloat {
        get { return leftMargin }
        set {
            leftMargin = newValue
        }
    }
    
    fileprivate var rightMargin: CGFloat = 40
    @IBInspectable var rightMarginValue: CGFloat{
        get { return rightMargin }
        set {
            rightMargin = screenSize.width - newValue
        }
    }
    
    fileprivate var currentViewX :CGFloat = 50
    
    fileprivate var topMargin : CGFloat = 60  // top scroll view margin
    @IBInspectable var topMarginValue: CGFloat {
        get { return topMargin }
        set {
            topMargin = newValue
        }
    }

    @IBInspectable var background: UIColor = UIColor.clear {
        didSet {
            print (background)
        }
    }
    
    @IBInspectable var image: UIImage = UIImage() {
        didSet {
        }
    }
    
    @IBInspectable var imageContentMode: UIViewContentMode = UIViewContentMode.scaleToFill {
        didSet {
        }
    }
    
    @IBInspectable var dashLines : Bool = true {
        didSet {
            print (dashLines)
        }
    }
    
    @IBInspectable var dashLinesWidth: CGFloat = 3{
        didSet {
            print (dashLinesWidth)
        }
    }
    @IBInspectable var dashLinesHeight: CGFloat = 2{
        didSet {
            print (dashLinesHeight)
        }
    }
    
    @IBInspectable var lineColor: UIColor = UIColor.blue {
        didSet {
            print (lineColor)
        }
    }
    
    @IBInspectable var lineWidth: CGFloat = 10{
        didSet {
            print (lineWidth)
        }
    }
    
    
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        //setup()
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override public func draw(_ rect: CGRect) {
        // Drawing code
        setup()
    }
    
    
    func setup(){
        
        // Add the Views
        for i in 0..<maxViews {
            addViewToZigZag(at: i)
        }
        
        setupBezierView()
        
    }
    
    func clearBezierView(){
        
        if let bView = bezierView {
            bView.subviews.forEach({ $0.removeFromSuperview() })
            bView.layer.sublayers?.forEach({ $0.removeFromSuperlayer() })
            bView.removeFromSuperview()
        }
        bezierView = nil
    }
    
    func setupBezierView(){
        clearBezierView()
        
        let frame = CGRect(origin: CGPoint.zero, size: self.contentSize)
        bezierView = BezierView(frame: frame)
        
        if let bView = bezierView {
            self.addSubview(bView)
            self.sendSubview(toBack: bView)
            
            let bgImage = UIImageView(frame: frame)
            bgImage.image = image.imageWithSize(size: self.contentSize)
            bgImage.contentMode = imageContentMode
            self.addSubview(bgImage)
            self.sendSubview(toBack: bgImage)
            
            bView.backgroundColor = background
            bView.dashLines = dashLines
            bView.dashLinesPattern = [NSNumber(value:Float(dashLinesWidth)), NSNumber(value:Float(dashLinesHeight))]
            bView.lineColor = lineColor
            bView.lineWidth = lineWidth
            bView.dataSource = self
        }
        updateBezierView()
    }
    
    func updateBezierView(){
        if let bView = bezierView {
            bView.frame = CGRect(origin: CGPoint.zero, size: self.contentSize)
            bView.layoutSubviews()
        }
    }
    
    func updateScrollView() {
        if let maxY = controlPoints.map({ $0.y }).max() {
            self.contentSize = CGSize(width: screenSize.width, height: maxY + yOffset)
            self.scrollToBottom(true)
        }
    }
    
    func addViewToZigZag(at index: Int){
        
        if (currentViewX > (rightMargin - viewSize)){
            inverse = true
        } else if (currentViewX < (leftMargin + viewSize)){
            inverse = false
        }
        
        let inverseValue = inverse ? -xOffset : xOffset
        currentViewX += inverseValue
        
        let pointX :CGFloat = currentViewX
        let pointY :CGFloat = (CGFloat(index) * yOffset) + topMargin
        let point = CGPoint(x:pointX,y:pointY)
        controlPoints.append(point)
        
        let frame = CGRect(origin: CGPoint.zero, size:CGSize(width: viewSize, height: viewSize))
    
        let newView = JourneyView(frame: frame)
        newView.center = point
        newView.tag = index
        newView.setupPanGesture(target: self, panSelector: #selector(self.handlePanGesture))
        newView.setupTapGesture(target: self, tapSelector: #selector(self.handleTapGesture))
        self.addSubview(newView)
        
        xOffset = CGFloat.randomF(min: horizontalGap, max: horizontalGap + 20)
        //yOffset = CGFloat.randomF(lower: verticalGap, verticalGap + 10)
        
        updateScrollView()
    }
    
    @objc func handleTapGesture(_ tapGestureRecognizer: UITapGestureRecognizer) {
        if let jView = tapGestureRecognizer.view as? JourneyView{
            print("tapped view with tag: ", jView.tag)
        }
    }
    
    @objc func handlePanGesture(_ panGestureRecognizer: UIPanGestureRecognizer) {
        
        if let jView = panGestureRecognizer.view as? JourneyView, let superView = jView.superview{
            
            superView.bringSubview(toFront: jView)
            
            let translation = panGestureRecognizer.translation(in: superView)
            
            let newPoint = CGPoint(x: jView.center.x + translation.x, y: jView.center.y + translation.y)
            jView.center = newPoint
            controlPoints[jView.tag] = newPoint
            
            panGestureRecognizer.setTranslation(CGPoint.zero, in: superView)
            
            // update bezier curve
            updateBezierView()
        }
        
    }
    

}

extension ZIgZagScrollView: BezierViewDataSource {
    
    public func bezierViewDataPoints(bezierView: BezierView) -> [CGPoint] {
        return controlPoints
    }
}
