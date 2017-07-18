//
//  MovingBallViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 16/07/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//https://www.bignerdranch.com/blog/uikit-dynamics-and-ios-7-building-uikit-pong/


import UIKit

class MovingBallsViewController: UIViewController {

    @IBAction func homebutton(_ sender: UIButton) {
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
    }
    
    var ballViews = [UIView]()
    var paddleView: UIView?
    var animator : UIDynamicAnimator? = nil
    var pusher = [UIPushBehavior]()
    var collider : UICollisionBehavior!
    var paddleDynamicProperties : UIDynamicItemBehavior!
    var ballsDynamicProperties: UIDynamicItemBehavior!
    var attacher: UIAttachmentBehavior!
    var paddlePanGesture : UIPanGestureRecognizer!
    
    let ballSize = CGSize(width: 40, height: 40)
    let paddleSize = CGSize(width: 60, height: 40)
    let numberOfBalls = 10
    var pushBall = false
    
    func initBehaviors(){
        
        animator = UIDynamicAnimator(referenceView: view)
        animator?.delegate = self
        
        for ballView in ballViews {
            push(ball: ballView, addToPusher: true)
        }
        
        // Step 1: Add collisions
        collider = UICollisionBehavior(items: [ paddleView!])
        for ballView in ballViews {
            collider.addItem(ballView)
        }
        collider.collisionDelegate = self
        collider.collisionMode = .everything
        collider.translatesReferenceBoundsIntoBoundary = true
        animator?.addBehavior(collider)

        // Step 2: Remove rotation
        ballsDynamicProperties = UIDynamicItemBehavior(items: ballViews)
        ballsDynamicProperties.allowsRotation = true
        animator?.addBehavior(ballsDynamicProperties)
        paddleDynamicProperties = UIDynamicItemBehavior(items: [paddleView!])
        paddleDynamicProperties.allowsRotation = false
        animator?.addBehavior(paddleDynamicProperties)
        // Step 3: Heavy paddle
        //paddleDynamicProperties.density = 1000.0
        // Step 4: Better collisions, no friction
        ballsDynamicProperties.elasticity = 1.0
        ballsDynamicProperties.friction = 0.0
        ballsDynamicProperties.resistance = 0.0
        // Step 5: Move paddle
        attacher = UIAttachmentBehavior(item: paddleView!, attachedToAnchor: CGPoint(x: (paddleView?.frame.midX)!, y: (paddleView?.frame.midY)!))
        animator?.addBehavior(attacher)
    }
    
    @objc func tapGesture(gesture:UIGestureRecognizer )
    {
        //attacher.anchorPoint = gesture.location(in: view)
        
        let location = gesture.location(in: view)
        
        let ballview = view.hitTest(location, with: nil)
        
        if let viewTapped = ballview {
            for ball in ballViews {
                if ball == viewTapped {
                    push(ball: ball, addToPusher: false)
                }
            }
        }
        
    }
  
    func push(ball ballView : UIView, addToPusher: Bool, pushVector: CGVector? = nil ){
       
        let randX = CGFloat.randomF(min: -1.0, max: 1.0)
        let randY = CGFloat.randomF(min: -1.0, max: 1.0)
        
        if (addToPusher){
            
            // Start ball off with a push
            let ballPusher = UIPushBehavior(items: [ballView], mode: .instantaneous)
            ballPusher.pushDirection = (pushVector != nil) ? pushVector! : CGVector(dx: randX, dy: randY)
            // Because push is instantaneous, it will only happen once
            animator?.addBehavior(ballPusher)
        
            pusher.append(ballPusher)
        }else{
            let index = ballView.tag - 1
            animator?.removeBehavior(pusher[index])
            pusher[index] = UIPushBehavior(items: [ballView], mode: .instantaneous)
            pusher[index].pushDirection = (pushVector != nil) ? pushVector! : CGVector(dx: randX, dy: randY)
            // Because push is instantaneous, it will only happen once
            animator?.addBehavior(pusher[index])
        }
    }
    
    func moveBallsApart(from location : CGPoint)
    {
        if (!pusher.isEmpty) {
            for push in pusher {
                animator?.removeBehavior(push)
            }
        }
        
        for ballView in ballViews {
            
            let offset = ballView.center.minus(this: location) 
            let direction = offset.normalized()
            
            // Start ball off with a push
            let pusher = UIPushBehavior(items: [ballView], mode: .instantaneous)
            pusher.pushDirection = CGVector(dx: direction.x, dy: direction.y )
            // Because push is instantaneous, it will only happen once
            animator?.addBehavior(pusher)
            
        }
    }
    @objc func ballsPanGesture(pan: UIPanGestureRecognizer) {
        
        let velocity = pan.velocity(in: view)
        //let location = pan.location(in: view)
        
        if let dragview = pan.view,
            let index = ballViews.index(of: dragview) {
            let ball = ballViews[index]
            
            switch pan.state {
            case .began:
                break
            case .changed:
                break
            case .ended:
                let normalisedVelocity = velocity.normalized()
                let pushVector = CGVector(dx: normalisedVelocity.x, dy: normalisedVelocity.y)
                push(ball: ball, addToPusher: false, pushVector: pushVector)
                break
            default:
                break
            }
        }
        
    }
    
    
    func removePanGestures(){
        // Clean up existing pan recognizers
        paddlePanGesture.isEnabled = false
        view.removeGestureRecognizer(paddlePanGesture)
        paddlePanGesture = nil
    }
    
    func addPanGesture(){
        // Add slide to open or close
        paddlePanGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        paddlePanGesture?.cancelsTouchesInView = false
        view.addGestureRecognizer(paddlePanGesture)
    }
    
    @objc func handlePanGesture(pan: UIPanGestureRecognizer) {
        
        let location = pan.location(in: view)
        let dragview = view.hitTest(location, with: nil)
        
        switch pan.state {
        case .began:
            if dragview == paddleView! {
                attacher.anchorPoint = location
            }
            break
        case .changed:
            if dragview == paddleView! {
                attacher.anchorPoint = location
            }
            break
        case .ended:
            
            break
        default:
            break
        }
        
    }
    
    func resetAll(){
        for push in pusher {
            animator?.removeBehavior(push)
        }
        pusher.removeAll()
        animator?.removeAllBehaviors()
        animator = nil
        collider = nil
        ballsDynamicProperties = nil
        paddleDynamicProperties = nil
        attacher = nil
        
        for ballView in ballViews{
            let x = CGFloat.randomF(min: 0, max: view.frame.width - ballSize.width)
            let y = CGFloat.randomF(min: 0, max: view.frame.height - ballSize.height)
            let ballPosition = CGPoint(x: x, y: y)
            let ballFrame = CGRect(origin: ballPosition, size: ballSize)
            ballView.frame = ballFrame
        }
        paddleView?.frame = CGRect(origin: CGPoint.zero, size:paddleSize)
        paddleView?.center = view.center
        
        initBehaviors()
    }
    
    func clearAll (){
        for push in pusher {
            animator?.removeBehavior(push)
        }
        pusher.removeAll();
        animator?.removeAllBehaviors()
        animator = nil;
        collider = nil;
        paddleDynamicProperties = nil
        ballsDynamicProperties = nil
        attacher = nil
        paddlePanGesture = nil
        
        removePanGestures()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
         // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for i in 0..<numberOfBalls{
            
            let x = CGFloat.randomF(min: 0, max: view.frame.width - ballSize.width)
            let y = CGFloat.randomF(min: 0, max: view.frame.height - ballSize.height)
            let ballPosition = CGPoint(x: x, y: y)
            let ballFrame = CGRect(origin: ballPosition, size: ballSize)
            let ballView = UIView(frame: ballFrame)
            ballView.tag = i + 1
            ballView.backgroundColor = UIColor.randomColor()
            ballView.layer.cornerRadius = ballSize.width * 0.5
            ballView.layer.borderColor = UIColor.black.cgColor
            ballView.layer.borderWidth = 2.0
            let image : UIImage = #imageLiteral(resourceName: "bnr_hat_only")   ////"bnr_hat_only"
            ballView.layer.contents = image.cgImage
            view.addSubview(ballView)
            ballViews.append(ballView)
            
            let pan = UIPanGestureRecognizer(target: self, action: #selector(ballsPanGesture))
            pan.minimumNumberOfTouches = 1
            ballView.addGestureRecognizer(pan)
            
        }
        
        let paddleFrame = CGRect(origin: CGPoint.zero, size:paddleSize)
        paddleView = UIView(frame: paddleFrame)
        paddleView?.center = view.center
        paddleView?.backgroundColor = UIColor.orange
        paddleView?.layer.cornerRadius = 8.0
        paddleView?.layer.borderWidth = 2.0
        paddleView?.layer.borderColor = UIColor.black.cgColor
        view.addSubview(paddleView!)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        
        addPanGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        resetAll()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    deinit {
        view.removeEverything()
        print("Moving Ball view controller is \(#function)")
    }
    
}

// Mark - UICollisionBehaviorDelegate
extension MovingBallsViewController: UICollisionBehaviorDelegate {
   
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
        
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        
    }
}

// Mark - UIDynamicAnimatorDelegate
extension MovingBallsViewController: UIDynamicAnimatorDelegate {
    
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
     
    }
    
    func dynamicAnimatorWillResume(_ animator: UIDynamicAnimator) {
        
    }
}
