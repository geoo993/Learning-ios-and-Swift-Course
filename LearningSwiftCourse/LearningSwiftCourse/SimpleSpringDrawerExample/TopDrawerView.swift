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
    fileprivate var amountSeenWhenClosed : CGFloat = 80
    //stretching until this max point
    fileprivate var maximumStretched  : CGFloat = 320
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
        drawerHeight = frame.height
        triggerPoint = drawerHeight * 0.5
        maximumStretched = drawerHeight * 1.2
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
        
        print(viewTopVerticalPosition, viewBottomVerticalPosition)
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
    
    func setupGestures(){
        
        // Add slide to open
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handleOpenPanGesture))
        handleView.addGestureRecognizer(recognizer)
        
    }
    
    //swipe up to close
    //drag up to close
    //swipe down to open
    //drag down to open
    
    fileprivate func slideToOpen() {
        
        // Clean up existing recognizers
        for recognizer: UIGestureRecognizer in handleView.gestureRecognizers! {
            recognizer.isEnabled = false
            handleView.removeGestureRecognizer(recognizer)
        }
        
        // trigger
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: [], animations: { [weak self] () -> Void in
                guard let this = self else { return }
                this.viewTopVerticalPositionConstraint?.constant = this.viewTopVerticalPosition
                this.viewBottomVerticalPositionConstraint?.constant = this.viewBottomVerticalPosition
                this.parentView.layoutIfNeeded()
            }, completion: { [weak self] (finished: Bool) in
//                // Add tap-to-close
//                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self?.handleCloseTapGesture))
//                tapGestureRecognizer.numberOfTapsRequired = 1
//                self?.handleView.addGestureRecognizer(tapGestureRecognizer)
        })
        return
    }
    
    
    @objc func handleOpenPanGesture(panGestureRecognizer: UIPanGestureRecognizer) {
        
        let offset = panGestureRecognizer.translation(in: self.parentView)
        let amount: CGFloat = abs(offset.y)
       
        if (amount + amountSeenWhenClosed + handleViewInset / 2) > maximumStretched {
            //when stretched beyond rest lenght  
            print("reached max stretch")
            snapto = SnapTo.bottom
            setToPosition(to: snapto)
            panGestureRecognizer.isEnabled = false
            slideToOpen()
            return
        } else if (amount + amountSeenWhenClosed + handleViewInset / 2) > triggerPoint {
            //when stretched halfway 
            print("reached trigger point")
            snapto = SnapTo.bottom
            setToPosition(to: snapto)
        }else if (amount + amountSeenWhenClosed + handleViewInset) > drawerHeight {
            print("reached max point")
            snapto = SnapTo.bottom
            setToPosition(to: snapto)
        }else{
            snapto = SnapTo.top
            setToPosition(to: snapto)
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
