//
//  ZIgZagScrollView.swift
//  HomePage
//
//  Created by GEORGE QUENTIN on 16/10/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import UIKit
import LearningSwiftCourseExtensions

@IBDesignable
public class ZIgZagScrollView: UIScrollView {

    fileprivate var bezierView: BezierView? {
        didSet{
            print("did set bezier view")
        }
    }
    
    fileprivate var animatableView = UIView()
    fileprivate var animationCounter = 0
    fileprivate var generatedPointFromPath : [CGPoint] = []
    
    var images : [UIImage?] = []
    var controlPoints = [CGPoint]()
    
    fileprivate var screenSize : CGRect {
        return UIScreen.main.bounds
    }
    
    fileprivate var inverse = false
    
    @IBInspectable var maxButtons: Int = 30
    
    fileprivate var xOffset : CGFloat = 100
    @IBInspectable var horizontalGap : CGFloat = 80 { 
        didSet {
            print ("horizontalGap:",horizontalGap)
            xOffset = horizontalGap
        }
    }
   
    fileprivate var yOffset : CGFloat = 50
    @IBInspectable var verticalGap : CGFloat = 50 { 
        didSet {
            print ("verticalGap:",verticalGap)
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
            print ("background:",background)
        }
    }
    
    @IBInspectable var backgroundImage: UIImage = UIImage() {
        didSet {
        }
    }
    
    var imageContentMode: UIView.ContentMode = UIView.ContentMode.scaleToFill {
        didSet {
        }
    }
    
    @IBInspectable var dashLines : Bool = true {
        didSet {
            print ("dashLines:",dashLines)
        }
    }
    
    @IBInspectable var dashLinesWidth: CGFloat = 3{
        didSet {
            print ("dashLinesWidth:",dashLinesWidth)
        }
    }
    @IBInspectable var dashLinesHeight: CGFloat = 2{
        didSet {
            print ("dashLinesHeight:",dashLinesHeight)
        }
    }
    
    @IBInspectable var lineColor: UIColor = UIColor.blue {
        didSet {
            print ("lineColor:",lineColor)
        }
    }
    
    @IBInspectable var lineWidth: CGFloat = 10{
        didSet {
            print ("lineWidth:",lineWidth)
        }
    }
    
    @IBInspectable var makeRoad: Bool = true{
        didSet {
            print ("makeRoad:",makeRoad)
        }
    }
    @IBInspectable var roadOutlineWidth: CGFloat = 1{
        didSet {
            print ("roadOutlineWidth:",roadOutlineWidth)
        }
    }
    @IBInspectable var roadlineWidth: CGFloat = 10{
        didSet {
            print ("roadlineWidth:",roadlineWidth)
        }
    }
    
    
    @IBInspectable var buttonsRandColors: Bool = true {
        didSet {
        }
    }
    
    @IBInspectable var buttonsColor: UIColor = UIColor.white {
        didSet {
        }
    }
    
    @IBInspectable var buttonsTitle: String = String() {
        didSet {
        }
    }
    
    @IBInspectable var buttonsImage: UIImage = UIImage() {
        didSet {
        }
    }
    @IBInspectable var buttonsImageSize: CGSize = CGSize(width: 20, height: 20) {
        didSet {
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override public func draw(_ rect: CGRect) {
        // Drawing code
        setup()
    }
    
    
    func setup(){
        
        self.removeEverything()
        
        self.setControlPoints(with: maxButtons)
        
        self.setupBezierView()
        //moveAlongPath()
        
    }
    
    func moveAlongPath(){
        animatableView = UIView(frame:CGRect(origin: CGPoint.zero, size: CGSize(width: 40, height: 40)))
        animatableView.backgroundColor = .orange
        animatableView.layer.cornerRadius = 30
        animatableView.clipsToBounds = true
        self.addSubview(animatableView)
        
        guard let path = bezierView?.getBezierPath() else { return }
        print("magnitude = \(path.magnitude())")
        /*
         animatableView.center = path.point(atPercentOfLength: 0.01)
         
         generatedPointFromPath = [0..<300]
         .flatMap({ $0 })
         .map { index -> CGPoint in
         let percent: CGFloat = CGFloat(index) / 100.0
         //print("point at [\(percent)] = \(path.point(atPercentOfLength: percent)) ")
         return path.point(atPercentOfLength: percent)
         }
         */
        
        //let panRecognizer = UIPanGestureRecognizer(target: self, action:#selector(self.handleAnimatableViewPanGesture) )
        //self.isUserInteractionEnabled = true
        //self.addGestureRecognizer(panRecognizer)
        
        //animate(with: 200, path: path)
        
        if let points = bezierView?.getPathInterpolationPoints() {
            animate(with: points)
        }
        
        //keyAnimation(with : path.cgPath)
    }
    
    func keyAnimation(with path : CGPath) {
        let keyFrameAnimation = CAKeyframeAnimation(keyPath:"position")
        keyFrameAnimation.path = path
        keyFrameAnimation.duration = 20.0  // How long to animate 
        keyFrameAnimation.speed = 1  // How fast to animate want
        keyFrameAnimation.fillMode = CAMediaTimingFillMode.forwards
        keyFrameAnimation.isRemovedOnCompletion = false
        keyFrameAnimation.calculationMode = CAAnimationCalculationMode.paced // This give the animation an even pace
        keyFrameAnimation.repeatCount = Float(CGFloat.infinity) // This makes the animation repeat forever
        keyFrameAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        animatableView.layer.add(keyFrameAnimation, forKey: "animation")
        
    }
    
    func animate(with max: CGFloat, path: UIBezierPath){
        let percentage = (CGFloat(self.animationCounter) / max )
        UIView.animate(withDuration: 1.0, animations: { 
            let point = path.point(atPercentOfLength: percentage)
            self.animatableView.center = point
        }, completion: { (completed) in
            if (self.animationCounter >= Int(max)) { self.animationCounter = 0 }
            self.animationCounter += 1
            self.animate(with: max, path: path)
        })
    }
    
    func animate(with points: [CGPoint]){
        UIView.animate(withDuration: 1.0, animations: { 
            self.animatableView.center = points[self.animationCounter % points.count]
        }, completion: { (completed) in
            self.animationCounter += 1
            self.animate(with: points)
        })
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
            self.sendSubviewToBack(bView)
            
            let bgImage = UIImageView(frame: frame)
            bgImage.image = backgroundImage.imageWithSize(size: self.contentSize)
            bgImage.contentMode = imageContentMode
            self.addSubview(bgImage)
            self.sendSubviewToBack(bgImage)
            
            bView.backgroundColor = background
            bView.dashLines = dashLines
            bView.dashLinesPattern = [NSNumber(value:Float(dashLinesWidth)), NSNumber(value:Float(dashLinesHeight))]
            bView.lineColor = lineColor
            bView.lineWidth = lineWidth
            bView.makeRoad = makeRoad
            bView.outlineWidth = roadOutlineWidth
            bView.roadlineWidth = roadlineWidth
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
    
    func setControlPoints(with buttons: Int){
        
        // Add a first point at the top of screen
        let screenSize = UIScreen.main.bounds.size
        let firstPoint = CGPoint(x: screenSize.width / 2, y: -screenSize.height)
        controlPoints.append(firstPoint)
        
        // Add the button Views
        for i in 0..<buttons {
            addViewToZigZag(at: i, with: i+1) // plus 1 includes the first point added above
        }
    }
    
    func addViewToZigZag(at index: Int, with tag: Int){
        
        if (currentViewX > (rightMargin - buttonsImageSize.width)){
            inverse = true
        } else if (currentViewX < (leftMargin + buttonsImageSize.width)){
            inverse = false
        }
        
        let inverseValue = inverse ? -xOffset : xOffset
        currentViewX += inverseValue
        
        let pointX :CGFloat = currentViewX
        let pointY :CGFloat = (CGFloat(index) * yOffset) + topMargin
        let point = CGPoint(x:pointX,y:pointY)
        controlPoints.append(point)
        
        addJourneyView(at: index, with: point, tag: tag, size: buttonsImageSize)
        
        xOffset = CGFloat.random(min: horizontalGap, max: horizontalGap + 20)
        //yOffset = CGFloat.randomF(min: verticalGap, max: verticalGap + 2)
        
        updateScrollView()
    }
    
    func addJourneyView(at index: Int, with point: CGPoint, tag: Int, size: CGSize){
        
        let frame = CGRect(origin: CGPoint.zero, size: size)
        
        let newView = JourneyView(frame: frame)
        newView.contentMode = .scaleAspectFill
        newView.originalColor = buttonsRandColors ? UIColor.random : buttonsColor
        newView.originalPoint = point
        newView.center = point
        newView.tag = tag
        newView.title = buttonsTitle
        newView.image = buttonsImage//images[index]
        newView.imageSize = buttonsImageSize
        let isLocked = (index > 30)//(images[index] == nil)
        newView.isLocked = isLocked
        newView.setupPanGesture(target: self, panSelector: #selector(self.handlePanGesture))
        //newView.setupTapGesture(target: self, tapSelector: #selector(self.handleTapGesture))
        newView.setupTouchGestures(target: self, touchDown: #selector(self.buttonTouchDown), touchUpInside: #selector(self.buttonTouchUpInside))
        self.addSubview(newView)
        
    }
    
    
    @objc func buttonTouchDown(_ sender: UIControl) {
        if let jView = sender as? JourneyView{
            jView.isSelect = true
        }
    }
    
    @objc func buttonTouchUpInside(_ sender: UIControl) {
        if let jView = sender as? JourneyView{
            jView.isSelect = false
        }
    }
    
    @objc func handleTapGesture(_ tapGestureRecognizer: UITapGestureRecognizer) {
        if let jView = tapGestureRecognizer.view as? JourneyView{
            print("tapped view with tag: ", jView.tag)
        }
    }
    
    @objc func handlePanGesture(_ panGestureRecognizer: UIPanGestureRecognizer) {
        
        if let jView = panGestureRecognizer.view as? JourneyView, let superView = jView.superview{
            
            superView.bringSubviewToFront(jView)
            
            let _ /* velocityInView */ = panGestureRecognizer.velocity(in: superView)
            let translation = panGestureRecognizer.translation(in: superView)
            
            
            let newPoint = CGPoint(x: jView.center.x + translation.x, y: jView.center.y + translation.y)
            let _ /* distanceAway */ = jView.center.distance(to: jView.originalPoint)
            
            //print(distanceAway, velocityInView.normalized())
            
            jView.center = newPoint
            controlPoints[jView.tag] = newPoint
            
            panGestureRecognizer.setTranslation(CGPoint.zero, in: superView)
            
            switch panGestureRecognizer.state {
            case .began:
                jView.isHeld = true
                break
            case .changed:
                jView.isHeld = true
                break
            case .ended:
                jView.isHeld = false
                break
            default:
                break
            }
            
            // update bezier curve
            updateBezierView()
        }
    }
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        /* // touch to find point on bezier
         if let touch = touches.first {
         let location = touch.location(in: self)
         //self.center = CGPoint(x: location.x, y: location.y)
         animatableView.center = location.findClosestPointOnPath(within: generatedPointFromPath)
         }
         */
    }
    
    @objc func handleAnimatableViewPanGesture(_ panGestureRecognizer: UIPanGestureRecognizer) {
        
        let location = panGestureRecognizer.location(in: self)
        
        switch panGestureRecognizer.state {
        case .began:
            break
        case .changed:
            animatableView.center = location.findClosestPointOnPath(within: generatedPointFromPath)
            break
        case .ended:
            break
        default:
            break
        }
    }
    
    

}

extension ZIgZagScrollView: BezierViewDataSource {
    
    public func bezierViewDataPoints(bezierView: BezierView) -> [CGPoint] {
        return controlPoints
    }
}
