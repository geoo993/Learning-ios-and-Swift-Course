//
//  StretchyHeaderOnlyViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 26/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//https://stackoverflow.com/questions/11536918/how-to-know-in-which-way-uitableview-is-being-scrolled

import UIKit
import Cartography

class BBCiPlayerStretchyHeaderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {

    //Mark: - Status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func homebutton(_ sender: Any) {
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
    }
    
    @IBOutlet weak var tableView: BBCiPlayerStretchyTableView!
    
    // Full size of the drawer and also how much drawer is seen when open
    fileprivate var headerHeight :CGFloat = 350
    // How much is seen when closed (minimum 20 please)
    fileprivate var amountSeenWhenClosed : CGFloat = 64
    // How far the user has to drag to trigger the drawer to stay open or closed
    fileprivate var triggerPoint : CGFloat = 50
    //screen width
    fileprivate var screenWidth : CGFloat = {
        return UIScreen.main.bounds.width
    }()
    //screen height
    fileprivate var screenHeight : CGFloat = {
        return UIScreen.main.bounds.height
    }()
    
    var latestContentOffset = CGPoint.zero
    var lastContentOffset = CGPoint.zero
    var lastContentOffsetWhenSpringEnabled = CGPoint.zero
    var animator : UIDynamicAnimator? = nil
    var containerBoundary : UICollisionBehavior!
    var snapBehavior : UISnapBehavior!
    var dynamicItemBehavior : UIDynamicItemBehavior!
    var gravityBehavior : UIGravityBehavior!
    var panGesture : UIPanGestureRecognizer!
    var isOpen : Bool = false
    var isClosing : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initialSetup()
    }
    
    func initialSetup(){
        setTableView()
        setupPanGesture()
        setupAnimator()
        shouldOpenPanel(false)
        
    }
    deinit {
        view.removeEverything()
        tableView = nil
        print("BBC iplayer stretchy Header view controller is \(#function)")
    }
    
}

// Mark - Behaviours
extension BBCiPlayerStretchyHeaderViewController {
    
    func activateDrag(with drag : Bool) {
        tableView.isScrollEnabled = drag
        //tableView.isSpringLoaded = drag
    }
    
    func setTableView (){
        
        let tableViewFrame = CGRect(origin: tableView.frame.origin, size: CGSize(width: screenWidth, height: headerHeight))
        tableView.frame = tableViewFrame
    }
    
    func setupAnimator(){
        animator = UIDynamicAnimator(referenceView: self.view)
        animator?.delegate = self
        
        setupDynamicItemBehavior()
        setupGravityBehavior()
        setupContainerBoundary()
        configureContainerBoundary()
        animator?.addBehavior(gravityBehavior)
        animator?.addBehavior(dynamicItemBehavior)
        animator?.addBehavior(containerBoundary)
    
    }
    
    func setupDynamicItemBehavior (){
        dynamicItemBehavior = UIDynamicItemBehavior(items: [self.tableView])
        dynamicItemBehavior.resistance = 0
        dynamicItemBehavior.elasticity = 0
        dynamicItemBehavior.allowsRotation = false
    }
    func setupGravityBehavior (){
        gravityBehavior = UIGravityBehavior(items: [self.tableView])
        gravityBehavior.gravityDirection = CGVector(dx: 0, dy: -1)
    }
    func setupContainerBoundary (){
        containerBoundary = UICollisionBehavior(items: [self.tableView])
    }
  
    func configureContainerBoundary (){
        let upperContainerBoundary = (-headerHeight + amountSeenWhenClosed)
        containerBoundary.addBoundary(withIdentifier: ("upperBoundary" as NSCopying) , from: CGPoint(x:0,y:upperContainerBoundary), to: CGPoint(x:screenWidth,y:upperContainerBoundary))
        
        let lowerContainerBoundary = headerHeight + 20
        containerBoundary.addBoundary(withIdentifier: ("lowerBoundary" as NSCopying) , from: CGPoint(x:0,y:lowerContainerBoundary), to: CGPoint(x:screenWidth,y:lowerContainerBoundary))
        
    }
    
    func snapToTop(_ gravityY: CGFloat){
        gravityBehavior.gravityDirection = CGVector(dx: 0, dy: -gravityY)
        //self.tableView.roundCorners([.topRight, .topLeft], radius: 10)
    }
    
    func snapToBottom(_ gravityY:CGFloat){
        gravityBehavior.gravityDirection = CGVector(dx: 0, dy: gravityY)
        //self.tableView.roundCorners([.topRight, .topLeft], radius: 0)
    }
  
    func shouldOpenPanel(_ open:Bool)
    {
        if open {
            snapToBottom( 2.0)
            removePanGestures()
            activateDrag(with: open )
        }else{
            snapToTop( 2.0 )
        }
    }
    
    func removePanGestures(){
        // Clean up existing pan recognizers
        panGesture.isEnabled = false
        tableView.removeGestureRecognizer(panGesture)
        panGesture = nil
    }
    
    func setupPanGesture(){
        // Add slide to open or close
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture))
        panGesture?.cancelsTouchesInView = false
        tableView.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePanGesture(pan: UIPanGestureRecognizer) {
       
        let velocity = pan.velocity(in: self.view).y
        var movement = self.tableView.frame
        movement.origin.x = 0
        movement.origin.y = movement.origin.y + (velocity * 0.04)
        
        switch pan.state {
        case .began:
            break
        case .changed:
            
            if (self.snapBehavior != nil) {
                animator?.removeBehavior(snapBehavior)
            }
            snapBehavior = UISnapBehavior(item: self.tableView, snapTo: CGPoint(x: movement.midX, y: movement.midY))
            animator?.addBehavior(snapBehavior)
            break
        case .ended:
            panGestureEnded()
            break
        default:
            break
        }
        
    }
    
    func panGestureEnded(){
        
        if (self.snapBehavior != nil) {
            animator?.removeBehavior(snapBehavior)
        }
        let velocity = dynamicItemBehavior.linearVelocity(for: self.tableView)
        
        let panOffset = panGesture.translation(in: self.tableView)
        let panMovement: CGFloat = abs(panOffset.y)
        
        
        //if fabsf(Float(velocity.y)) > Float(triggerPoint) {
        if (panMovement > triggerPoint) {
            if velocity.y < 0 {
                shouldOpenPanel(false)
            }else{
                shouldOpenPanel(true)
            }
        }else{
            
            if self.tableView.frame.origin.y > (headerHeight / 2) {
                shouldOpenPanel(true)
            }else{
                shouldOpenPanel(false)
            }
            
        }
        
    }
 
}

// Mark - UIDynamicAnimatorDelegate
extension BBCiPlayerStretchyHeaderViewController: UIDynamicAnimatorDelegate {
    
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        isOpen = (tableView.frame.origin.y > 0 )
        isClosing = false
        tableView.contentOffset = CGPoint.zero
        activateDrag(with: isOpen )
        
    }
    
    func dynamicAnimatorWillResume(_ animator: UIDynamicAnimator) {
    }
}

// Mark - TableView Scroll Delegate and Datasource
extension BBCiPlayerStretchyHeaderViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
   
        if isOpen == false {
            scrollView.contentOffset = CGPoint.zero
        }
        
        if isOpen {
           
            let currentOffset = scrollView.contentOffset;
            if (currentOffset.y > lastContentOffsetWhenSpringEnabled.y && currentOffset.y < 0 && isClosing == false)
            {
                // Upward
                //print("heading upwards")
                
                // Snap shut
                //scrollView.contentOffset.y = scrollView.contentOffset.y * 0.95
                
                //make sure offset is at zero
                UIView.animate(withDuration: 0.5, 
                               delay: 0.0, 
                               usingSpringWithDamping: 0.9, 
                               initialSpringVelocity: 0.6, 
                               options: .beginFromCurrentState, 
                               animations: { [weak self] () -> Void in
                                guard let this = self else { return }
                                scrollView.contentOffset = CGPoint.zero
                                this.tableView.contentOffset = CGPoint.zero
                                this.tableView.layoutIfNeeded()
                                
                    }, completion: { (completed) -> Void in
                        scrollView.contentOffset = CGPoint.zero
                })
             
                
            }else if isClosing {
                //scrollView.contentOffset = latestContentOffset
                //print(scrollView.contentOffset,latestContentOffset ,isOpen)
            }
            else
            {
                // Downward
                //print("heading downward")
            }
            
            lastContentOffsetWhenSpringEnabled = currentOffset;
        }
         
    
    }
 
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
//        if (velocity.y > 0){
//            print("Going up");
//        }
//        if (velocity.y < 0){
//            print("Going down");
//        }
        
//        if targetContentOffset.pointee.y < scrollView.contentOffset.y {
//            print("Going up!")
//            
//        } else {
//            print("Going down!")
//            
//        }
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
      
        
        if isOpen {
            let panGestureRecognizer = scrollView.panGestureRecognizer
            let panOffset = panGestureRecognizer.translation(in: scrollView)
            let panMovement: CGFloat = abs(panOffset.y)
            
            lastContentOffset = CGPoint.zero
            let currentOffset = scrollView.contentOffset
            let goingUp = (currentOffset.y > lastContentOffset.y)
            lastContentOffset = currentOffset
            
            if (panMovement > triggerPoint && goingUp){
                latestContentOffset = lastContentOffset
                //activateDrag(with: false )
                setupPanGesture()
                shouldOpenPanel(false)
                isClosing = true
            }
            
            //print(panMovement, goingUp)
        }
 
     
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.contentOffset = CGPoint.zero
    }
  
    
}
