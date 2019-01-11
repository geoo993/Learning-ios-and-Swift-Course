//
//  SideBarMenu.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 08/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//
//https://www.youtube.com/watch?v=qaLiZgUK2T0

import UIKit

@objc protocol SideBarMenuDelegate {
    func sideBarMenuDidSelectButtonAtIndex(at index: Int)
    @objc optional func sideBarMenuWillClose()
    @objc optional func sideBarMenuWillOpen()
}

class SideBarMenu: NSObject, SideBarMenuTableViewControllerDelegate {
    
    var sideBarMenuWidth : CGFloat = 150
    var sideBarMenutableViewTopInsect : CGFloat = 50
    let sideBarMenuContainerView = UIView()
    let sideBarMenuTableViewController = SideBarMenuTableViewController()
    var sideBarMenuOriginView : UIView? = nil
    
    var sideBarMenuAnimator : UIDynamicAnimator? = nil
    var sideBarMenuDelegate : SideBarMenuDelegate? = nil
    var isSideBarMenuOpen : Bool = false
    
    override init(){
        super.init()
    }
    
    init(originView: UIView, menuItems: Array<String>, width : CGFloat = 50, topInsect: CGFloat = 50){
        super.init()
        
        sideBarMenuWidth = width
        sideBarMenutableViewTopInsect = topInsect
        sideBarMenuOriginView = originView
        sideBarMenuTableViewController.tableData = menuItems
        
        setupSideBarMenu()
        
        sideBarMenuAnimator = UIDynamicAnimator(referenceView: originView)
        
        //gesture recogniser of right swipe
        let showGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        showGestureRecognizer.direction = UISwipeGestureRecognizer.Direction.right
        originView.addGestureRecognizer(showGestureRecognizer)
        
        //gesture recogniser of left swipe
        let hideGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        hideGestureRecognizer.direction = UISwipeGestureRecognizer.Direction.left
        originView.addGestureRecognizer(hideGestureRecognizer)
    }
    
    func setupSideBarMenu(){
        
        if sideBarMenuOriginView != nil {
            let xPosition = -sideBarMenuWidth - 1
            let yPosition = (sideBarMenuOriginView?.frame.origin.y)!
            let height = (sideBarMenuOriginView?.frame.size.height)!
            sideBarMenuContainerView.frame = CGRect(x: xPosition, y: yPosition, width: sideBarMenuWidth, height: height)
            sideBarMenuContainerView.backgroundColor = UIColor.clear
            sideBarMenuContainerView.clipsToBounds = false
            sideBarMenuOriginView?.addSubview(sideBarMenuContainerView)
            
            sideBarMenuContainerView.blurNewView(newChild: UIView(), effect: UIBlurEffect.Style.light)
            sideBarMenuTableViewController.sideBarMenuDelegate = self
            sideBarMenuTableViewController.tableView.frame = sideBarMenuContainerView.bounds
            sideBarMenuTableViewController.tableView.clipsToBounds = false
            sideBarMenuTableViewController.tableView.separatorStyle = .none
            sideBarMenuTableViewController.tableView.backgroundColor = UIColor.clear
            sideBarMenuTableViewController.tableView.scrollsToTop = false
            sideBarMenuTableViewController.tableView.contentInset = UIEdgeInsets(top: sideBarMenutableViewTopInsect, left: 0, bottom: 0, right: 0)
            
            sideBarMenuTableViewController.tableView.reloadData()
            
            sideBarMenuContainerView.addSubview(sideBarMenuTableViewController.tableView)
        }
    }

    @objc func handleSwipe(recongizer: UISwipeGestureRecognizer){
        
        if recongizer.direction == .right{
            //show
            showSideBarMenu(true)
            sideBarMenuDelegate?.sideBarMenuWillOpen?()
        }else if recongizer.direction == .left {
            //hide
            showSideBarMenu(false)
            sideBarMenuDelegate?.sideBarMenuWillClose?()
        }
    }
    
    func showSideBarMenu(_ shouldOpen: Bool){
        sideBarMenuAnimator?.removeAllBehaviors()
        isSideBarMenuOpen = shouldOpen
        
        let gravityX:CGFloat = shouldOpen ? 0.5 : -0.5
        let magnitude:CGFloat = shouldOpen ? 20 : -20
        let leftBoundary : CGFloat = shouldOpen ? sideBarMenuWidth : -sideBarMenuWidth - 1
        let height = (sideBarMenuOriginView?.frame.size.height)!
        
        let gravityBehavior =  UIGravityBehavior(items: [sideBarMenuContainerView])
        gravityBehavior.gravityDirection = CGVector(dx: gravityX, dy: 0)
        sideBarMenuAnimator?.addBehavior(gravityBehavior)
        
        let containerBoundary = UICollisionBehavior(items: [sideBarMenuContainerView])
        containerBoundary.addBoundary(withIdentifier: ("sideBarBoundary" as NSCopying) , from: CGPoint(x:leftBoundary,y:20), to: CGPoint(x:leftBoundary,y:height))
        sideBarMenuAnimator?.addBehavior(containerBoundary)
        
        let pushBehavior = UIPushBehavior(items: [sideBarMenuContainerView], mode: UIPushBehavior.Mode.instantaneous) 
        pushBehavior.magnitude = magnitude
        sideBarMenuAnimator?.addBehavior(pushBehavior)
        
        let dynamicItemBehavior = UIDynamicItemBehavior(items: [sideBarMenuContainerView])
        dynamicItemBehavior.allowsRotation = false
        dynamicItemBehavior.elasticity = 0.3
        sideBarMenuAnimator?.addBehavior(dynamicItemBehavior)
    }
    
    func sideBarMenuControlDidSelectRow(at indexPath: IndexPath) {
        sideBarMenuDelegate?.sideBarMenuDidSelectButtonAtIndex(at: indexPath.row)
    }
}
