//
//  TopDrawerView.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 24/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit
import Cartography



class TopDrawerView: UIView {

    enum SnapTo {
        case top
        case bottom
    }
    
    var parentView = UIView()
    
    // Full size of the drawer
    fileprivate var drawerHeight :CGFloat = 350
    // How much is seen when closed (minimum 32 please)
    fileprivate var amountSeenWhenClosed : CGFloat = 80
    // How much drawer is seen when open
    fileprivate var amountSeenWhenOpened  : CGFloat = 300
    // How far the user has to drag to trigger the drawer to stay open
    fileprivate var triggerPoint : CGFloat = 140
    
    fileprivate var viewTopVerticalPositionConstraint: NSLayoutConstraint?
    fileprivate var viewBottomVerticalPositionConstraint: NSLayoutConstraint?
   
    fileprivate var viewTopVerticalPosition : CGFloat = 0
    fileprivate var viewBottomVerticalPosition :CGFloat = 0
    
    fileprivate var screenHeight : CGFloat = {
        return UIScreen.main.bounds.height
    }()
    
    fileprivate var handleViewWidth :CGFloat = 20
    fileprivate var handleViewHeight :CGFloat = 50
    fileprivate var handleViewInset :CGFloat = 5
    
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
        self.drawerHeight = self.frame.height
        self.autoLayoutEnabled = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.contentMode = .center
        
        // Build handle
        handleView.autoLayoutEnabled = true
        handleView.layer.cornerRadius = 10
        handleView.backgroundColor = UIColor.brown
        
        snapto = SnapTo.top
        setToPosition(to: snapto)
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
            viewBottomVerticalPosition = -screenHeight + amountSeenWhenOpened
        }
    
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
        
        
//        viewBottomVerticalPositionConstraint = 
//            NSLayoutConstraint(item: self, 
//                               attribute: .bottom,
//                               relatedBy: .equal,
//                               toItem: self.parentView, 
//                               attribute: .top, 
//                               multiplier: 1.0, 
//                               constant: /*-fullHeightSize +*/ amountSeenWhenClosed)
        
        NSLayoutConstraint.activate(
            [viewTopVerticalPositionConstraint!,viewBottomVerticalPositionConstraint!])
        
    }
    
    /*
    func hideRedViewAnimated(animated: Bool) {
        //remove current constraint
        removeViewYPositionConstraint()
        let hideConstraint = NSLayoutConstraint(item: self,
                                                attribute: .bottom,
                                                relatedBy: .equal,
                                                toItem: self.parentView,
                                                attribute: .top,
                                                multiplier: 1,
                                                constant: 0)
        viewYPositionConstraint = hideConstraint
        self.parentView.addConstraint(hideConstraint)
        //animate changes
        performConstraintLayout(animated: animated)
        
    }
    
    func showRedViewAnimated(animated: Bool) {
        //remove current constraint
        removeViewYPositionConstraint()
        let centerYConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: self.parentView,
                                                   attribute: .centerY,
                                                   multiplier: 1,
                                                   constant: 0)
        viewYPositionConstraint = centerYConstraint
        self.parentView.addConstraint(centerYConstraint)
        //animate changes
        performConstraintLayout(animated: animated)
        
    }
    
    func performConstraintLayout(animated : Bool) {
        if animated == true {
            UIView.animate(withDuration: 1,
                                       delay: 0,
                                       usingSpringWithDamping: 0.5,
                                       initialSpringVelocity: 0.6,
                                       options: .beginFromCurrentState,
                                       animations: { () -> Void in
                                        self.parentView.layoutIfNeeded()
            }, completion: nil)
        } else {
            parentView.layoutIfNeeded()
        }
      
    }
    
    func removeViewYPositionConstraint() {
        if viewYPositionConstraint != nil {
            parentView.removeConstraint(viewYPositionConstraint!)
            viewYPositionConstraint = nil
        }
    }
    
    func isRedViewVisible() -> Bool {
        return parentView.bounds.contains(self.frame.origin)
    }
    */
    
    func setupGestures(){
        
        // Add slide to open
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handleOpenPanGesture))
        handleView.addGestureRecognizer(recognizer)
        
    }
    
    //swipe up to close
    //drag up to close
    //swipe down to open
    //drag down to open
    
    
    @objc func handleOpenPanGesture(panGestureRecognizer: UIPanGestureRecognizer) {
        
        let offset = panGestureRecognizer.translation(in: self.parentView)
        let amount: CGFloat = abs(offset.y)
       
        //when stretched halfway 
        if (amount + amountSeenWhenClosed + handleViewInset / 2) > triggerPoint {
            //panGestureRecognizer.isEnabled = false
            //self.slideToOpen()
            //return
            print("reached trigger point")
            snapto = SnapTo.bottom
        }else if (amount + amountSeenWhenClosed + handleViewInset) > amountSeenWhenOpened {
            print("reached max point")
            snapto = SnapTo.bottom
        }else{
            snapto = SnapTo.top
        }
        
        print(amount + amountSeenWhenClosed + handleViewInset)
        
        switch panGestureRecognizer.state {
        case .began:
            break
        case .changed:
            
            // Follow finger drag
            let constant = (amount + amountSeenWhenClosed + handleViewInset / 2)
            viewTopVerticalPositionConstraint?.constant = -drawerHeight + constant
            viewBottomVerticalPositionConstraint?.constant = -screenHeight + constant
            
        case .ended:
            
            setToPosition(to: snapto)
            
            // Snap shut
            UIView.animate(withDuration: TimeInterval(snaptocloseDuration), 
                           delay: 0.0, 
                           usingSpringWithDamping: snaptocloseSpringDamping, 
                           initialSpringVelocity: snaptocloseVelocity, 
                           options: [.curveEaseOut], 
                           animations: { [weak self] () -> Void in
                            guard let this = self else { return }
                            this.viewTopVerticalPositionConstraint?.constant = 
                                this.viewTopVerticalPosition
                            this.viewBottomVerticalPositionConstraint?.constant = this.viewBottomVerticalPosition
                            this.parentView.layoutIfNeeded()
                
            }, completion: nil )
            
            break
        default:
            break
        }
 
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
      
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
    }
    

}
