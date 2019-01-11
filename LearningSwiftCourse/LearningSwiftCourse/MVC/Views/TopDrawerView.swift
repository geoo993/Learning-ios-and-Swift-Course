//
//  TopDrawerView.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 24/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//https://stackoverflow.com/questions/27371935/how-to-animate-a-uiview-with-constraints-in-swift
//http://www.ryanwright.me/cookbook/ios/autolayout/programmatic

import UIKit
import Cartography

class TopDrawerView: UIView {

    enum SnapTo {
        case top
        case bottom
    }
    
    var parentView = UIView()
    
    // Full size of the drawer and also how much drawer is seen when open
    fileprivate var drawerHeight :CGFloat = 300
    // How much is seen when closed (minimum 32 please)
    fileprivate var amountSeenWhenClosed : CGFloat = 60
    //stretching until this max point
    fileprivate var maximumStretch  : CGFloat = 320
    // How far the user has to drag to trigger the drawer to stay open
    fileprivate var triggerPoint : CGFloat = 140
    
    fileprivate var viewTopVerticalPositionConstraint: NSLayoutConstraint?
    fileprivate var viewBottomVerticalPositionConstraint: NSLayoutConstraint?
   
    fileprivate var viewTopVerticalPosition : CGFloat = 0
    fileprivate var viewBottomVerticalPosition :CGFloat = 0
    
    fileprivate var screenHeight : CGFloat = {
        return UIScreen.main.bounds.height
    }()
    
    fileprivate var handleViewInset :CGFloat = 10
    
    fileprivate var snapto = SnapTo.top
    fileprivate var snaptocloseDuration : CGFloat = 0.3//1.5
    fileprivate var snaptocloseSpringDamping : CGFloat = 0.9//0.25
    fileprivate var snaptocloseVelocity : CGFloat = 0.7
    
    @IBOutlet weak var handleView : UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    init(frame: CGRect, parent : UIView){
        super.init(frame: frame)
        self.parentView = parent
      
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView(){
        drawerHeight = frame.height
        triggerPoint = drawerHeight * 0.5
        maximumStretch = drawerHeight * 2.0
        autoLayoutEnabled = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        contentMode = .center
        
        // Build handle
        handleView.autoLayoutEnabled = true
        handleView.layer.cornerRadius = 10
        handleView.backgroundColor = UIColor.brown
        
        snapto = SnapTo.top
        setToPosition(to: snapto)
        
    }
    
    func addConstraints(){
        
        constrain(self, self.parentView) { (view1, view2) in
            //view1.height == self.fullHeightSize
            view1.trailing  == view2.trailing
            view1.leading == view2.leading
            //view1.top == view2.top
            view1.centerX == view2.centerX
        }
        
        viewTopVerticalPositionConstraint = 
            NSLayoutConstraint(item: self, 
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: self.parentView, 
                               attribute: .top, 
                               multiplier: 1.0, 
                               constant: viewTopVerticalPosition)
        
        viewBottomVerticalPositionConstraint = 
            NSLayoutConstraint(item: self, 
                               attribute: .bottom,
                               relatedBy: .equal,
                               toItem: self.parentView, 
                               attribute: .bottom, 
                               multiplier: 1.0, 
                               constant: viewBottomVerticalPosition)
        
     
        NSLayoutConstraint.activate(
            [viewTopVerticalPositionConstraint!,viewBottomVerticalPositionConstraint!])
        
    }
    
    func setupPanGesture(){
        
        // Add slide to open
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture))
        handleView.addGestureRecognizer(recognizer)
    }
    
    func setupMaxStretchPanGesture(){
        
        // Add slide to open
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handleMaxStretchPanGesture))
        handleView.addGestureRecognizer(recognizer)
    }
    
    func setupSwipeUpGesture(){
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.swiped))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.addGestureRecognizer(swipeUp)
    }
    
    fileprivate func removePanGestures(){
        // Clean up existing pan recognizers
        for recognizer: UIGestureRecognizer in handleView.gestureRecognizers! {
            recognizer.isEnabled = false
            handleView.removeGestureRecognizer(recognizer)
        }
    }
    
    fileprivate func removeSwipeUpGesture(_ swipeUp: UISwipeGestureRecognizer){
        removeGestureRecognizer(swipeUp)
        // Clean up existing swipe recognizers
        for recognizer: UIGestureRecognizer in self.gestureRecognizers! {
            recognizer.isEnabled = false
            self.removeGestureRecognizer(recognizer)
        }
    }
    
    fileprivate func slideToOpenAfterTrigger() {
        
        removePanGestures()
        
        // trigger
        let completionBlock : (Bool) -> () = { [weak self] _ in 
            self?.setupSwipeUpGesture()
            self?.setupMaxStretchPanGesture()
        } 
        animateDrawer(with: completionBlock)
        
        return
    }
    
    @objc func swiped(swipeGestureRecognizer: UISwipeGestureRecognizer)
    {
        if swipeGestureRecognizer.direction ==  UISwipeGestureRecognizer.Direction.up {
            
            removePanGestures()
            removeSwipeUpGesture(swipeGestureRecognizer)
            
            snapto = SnapTo.top
            setToPosition(to: snapto)
            let completionBlock : (Bool) -> () = { [weak self] _ in 
                self?.setupPanGesture()
            } 
            animateDrawer(with: completionBlock)
            
        }else {
            print("other swipe")
        }
   
    }
    
    
    @objc func handlePanGesture(panGestureRecognizer: UIPanGestureRecognizer) {
        
        let offset = panGestureRecognizer.translation(in: self.parentView)
        let panMovement: CGFloat = abs(offset.y)
     
        if (panMovement + amountSeenWhenClosed + handleViewInset / 2) > drawerHeight {
            //print("reached max point")
            snapto = SnapTo.bottom
            setToPosition(to: snapto)
            panGestureRecognizer.isEnabled = false
            slideToOpenAfterTrigger()
            return
        }
        
        if (panMovement + amountSeenWhenClosed + handleViewInset / 2) > triggerPoint {
            //when stretched halfway 
            //print("reached trigger point")
            snapto = SnapTo.bottom
            setToPosition(to: snapto)
        }else{
            snapto = SnapTo.top
            setToPosition(to: snapto)
        }
        
        switch panGestureRecognizer.state {
        case .changed:
           
            let constant : CGFloat = (panMovement + amountSeenWhenClosed + handleViewInset / 2) 
            viewTopVerticalPositionConstraint?.constant =  -drawerHeight + constant
            viewBottomVerticalPositionConstraint?.constant = -screenHeight + constant
         
        case .ended:
            snapBackToBottom()
            break
        default:
            break
        }
    }
    
    @objc func handleMaxStretchPanGesture(panGestureRecognizer: UIPanGestureRecognizer) {
        
        let offset = panGestureRecognizer.translation(in: self.parentView)
        let panMovement: CGFloat = abs(offset.y)
        
        if (panMovement + drawerHeight + handleViewInset / 2) > maximumStretch {
            //when stretched beyond rest lenght  
            //print("reached max stretch")
            snapto = SnapTo.bottom
            setToPosition(to: snapto)
            panGestureRecognizer.isEnabled = false
            slideToOpenAfterTrigger()
            return
        }
        
        // hooke's law
        // panMovement * extension of spring, given that the extension hs not exceeded the elastic limit (maximumStretch)
        // the closer you get to elastic limit the smaller the constant e.g 0.9, 0.8, 0.7 0.6, 0.5, 0.3, 0.2, 0.1  
        // The extension is the new length/distance after rest length (100 * (maximumStretch - drawerHeight) / distance)
        // stiffness is from 0 to 1
        
        let distance = (panMovement + drawerHeight + handleViewInset / 2)
        let springStiffness = distance.percentageBetween(maxValue: maximumStretch, minValue: drawerHeight) / 100
        let newPanMovement = panMovement * (1 - springStiffness)
        
        switch panGestureRecognizer.state {
        case .changed:
            
            // Follow finger drag
            let topConstant : CGFloat = 0//(newPanMovement + handleViewInset / 2) 
            let bottomConstant : CGFloat = (newPanMovement + drawerHeight + handleViewInset / 2) 
            viewTopVerticalPositionConstraint?.constant = topConstant
            viewBottomVerticalPositionConstraint?.constant = -screenHeight + bottomConstant

        case .ended:
            snapBackToBottom()
            break
        default:
            break
        }
 
    }
  
    func setToPosition(to position: SnapTo){
        
        switch position {
        case SnapTo.top:
            // top and bottom constraint positions when closed
            viewTopVerticalPosition  = -drawerHeight + amountSeenWhenClosed
            viewBottomVerticalPosition = -screenHeight + amountSeenWhenClosed
        case SnapTo.bottom:
            // top and bottom constraint positions when opened
            viewTopVerticalPosition  = 0
            viewBottomVerticalPosition = -screenHeight + drawerHeight
        }
        
    }
    
    func snapBackToBottom(){
        //snap back to position
        let completionBlock : (Bool) -> () = { [weak self] _ in 
            if self?.snapto == SnapTo.bottom {
                self?.removePanGestures()
                self?.setupSwipeUpGesture()
                self?.setupMaxStretchPanGesture()
            }
        } 
        animateDrawer(with: completionBlock)
    }
    
    func animateDrawer(with complete: ((Bool) -> Void)?  ) {
        
        // Snap to shut or open
        UIView.animate(withDuration: TimeInterval(snaptocloseDuration), 
                       delay: 0.0, 
                       usingSpringWithDamping: snaptocloseSpringDamping, 
                       initialSpringVelocity: snaptocloseVelocity, 
                       options: .beginFromCurrentState, 
                       animations: { [weak self] () -> Void in
                        guard let this = self else { return }
                        this.viewTopVerticalPositionConstraint?.constant = 
                            this.viewTopVerticalPosition
                        this.viewBottomVerticalPositionConstraint?.constant = this.viewBottomVerticalPosition
                        this.parentView.layoutIfNeeded()
                        
            }, completion: complete)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
    }
    

}
