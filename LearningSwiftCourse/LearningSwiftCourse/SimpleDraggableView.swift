//
//  SimpleDraggableView.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 13/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation
import UIKit

class SimpleDraggableView: UIView {
    
    @IBOutlet weak var topIndicator : UIView!
    
    var panelWidth  : CGFloat = 0
    var panelHeight : CGFloat = 0
    var panelHeightToSee : CGFloat = 50
    var screenHeight : CGFloat = 0
    
    var animator : UIDynamicAnimator? = nil
    var containerBoundary : UICollisionBehavior!
    var snapBehavior : UISnapBehavior!
    var dynamicItemBehavior : UIDynamicItemBehavior!
    var gravityBehavior : UIGravityBehavior!
    
    var isOpen = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isHidden = true
    }
    
    convenience init() {
        self.init()
        
        self.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isHidden = true
    }
    
    /*
     override func awakeFromNib() {
     super.awakeFromNib()
     // Initialization code
     }
     
     public override func willMove(toSuperview newSuperview: UIView?) {
     super.willMove(toSuperview: newSuperview)
     }
     
     public override func layoutSubviews() {
     super.layoutSubviews()
     
     }
     
     */
    
    func setupDraggableView(with mainView:UIView, widthRatio: CGFloat, heightRatio:CGFloat, heightToSee: CGFloat){
        
        animator?.removeAllBehaviors()
        self.isHidden = false
        
        panelWidth = (widthRatio < 1) ? (mainView.frame.size.width * widthRatio) : mainView.frame.size.width
        panelHeight  = (heightRatio < 1) ? (mainView.frame.size.height) * heightRatio : (mainView.frame.size.height)
        
        screenHeight = mainView.frame.size.height
        
        panelHeightToSee = heightToSee
        
        // Set the frame for this view based on the parent
        self.frame = CGRect(x:0, y: screenHeight, width: panelWidth, height: panelHeight)
        
        setupAnimator(with: mainView)
        
    }
    
    
    func setupAnimator(with mainView: UIView){
        animator = UIDynamicAnimator(referenceView: mainView)
        setupDynamicItemBehavior()
        setupGravityBehavior()
        setupContainerBoundary()
        
        // set the animator behvaiours
        animator?.addBehavior(gravityBehavior)
        animator?.addBehavior(dynamicItemBehavior)
        animator?.addBehavior(containerBoundary)
    }
    
  
    func setupDynamicItemBehavior (){
        // Set the behvaiours
        dynamicItemBehavior = UIDynamicItemBehavior(items: [self])
        dynamicItemBehavior.allowsRotation = false
        dynamicItemBehavior.elasticity = 0
    }
    func setupGravityBehavior (){
        gravityBehavior = UIGravityBehavior(items: [self])
        //let gravityY:CGFloat  = (shouldOpen) ? -1.5 : 1.5
        //gravityBehavior.gravityDirection = CGVector(dx: 0, dy: gravityY)
    }
    func setupContainerBoundary (){
        // Set collision behaviours
        containerBoundary = UICollisionBehavior(items: [self])
        
        let boundaryX:CGFloat = panelWidth //UIScreen.main.bounds.size.width
        
        let upperContainerBoundary = (screenHeight - panelHeight)  
        containerBoundary.addBoundary(withIdentifier: ("upperBoundary" as NSCopying) , from: CGPoint(x:0,y:upperContainerBoundary), to: CGPoint(x:boundaryX,y:upperContainerBoundary))
        
        let lowerContainerBoundary = (screenHeight + panelHeight) - panelHeightToSee//maxHeight ?? UIScreen.main.bounds.size.height
        containerBoundary.addBoundary(withIdentifier: ("lowerBoundary" as NSCopying) , from: CGPoint(x:0,y:lowerContainerBoundary), to: CGPoint(x:boundaryX,y:lowerContainerBoundary))
    }
    

    func snapToTop(_ gravityY: CGFloat){
        gravityBehavior.gravityDirection = CGVector(dx: 0, dy: -gravityY)
        self.roundCorners([.topRight, .topLeft], radius: 10)
    }
    
    func snapToBottom(_ gravityY:CGFloat){
        gravityBehavior.gravityDirection = CGVector(dx: 0, dy: gravityY)
        self.roundCorners([.topRight, .topLeft], radius: 0)
    }
    
    
    func showBasePanel(open:Bool)
    {
        isOpen = open
        if open {
            snapToTop( 1.5 )
        }else{
            snapToBottom( 1.5)
        }
    }
    
    func setupGestureRecognizer()
    {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 1
        topIndicator.addGestureRecognizer(doubleTap)
    }
    
    func handleDoubleTap(_ recognizer: UITapGestureRecognizer)
    {
        isOpen = !isOpen
        showBasePanel(open: isOpen)
    }
    
    
    deinit {
        self.removeEverything()
        animator = nil
        containerBoundary = nil
        snapBehavior = nil
        dynamicItemBehavior = nil
        gravityBehavior = nil
        
    }
}
