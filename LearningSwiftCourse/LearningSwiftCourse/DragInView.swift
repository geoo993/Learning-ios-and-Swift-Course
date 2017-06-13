//
//  DragInView.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 13/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
// https://github.com/erica/useful-things
//http://www.informit.com/articles/article.aspx?p=2217000

import Foundation

import UIKit



class DragInView : UIView {
    
    // Full size of the drawer
    let kDrawerExtent :CGFloat = 320
    // How much is seen when closed (minimum 32 please)
    let kClosedDrawExtent :CGFloat = 32
    // How much drawer is seen when open
    let kOpenDrawExtent  :CGFloat = 200
    // How far the user has to drag to trigger the drawer to stay open
    let kTriggerPoint :CGFloat = 260
    // Handle dimensions
    let kHandleExtent :CGFloat = 20
    let kHandleLength :CGFloat = 50
    let kHandleInset :CGFloat = 4
    
    var handleView: UIImageView!
    var side = NSLayoutAttribute.notAnAttribute
    var c = NSLayoutConstraint()

    func handleCloseTapGesture(tapGestureRecognizer: UITapGestureRecognizer) {
        
        handleView.removeGestureRecognizer(tapGestureRecognizer)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: [], animations: {() -> Void in
            self.c.constant = self.kClosedDrawExtent
            self.superview!.layoutIfNeeded()
        }, completion: {(finished: Bool) -> Void in
                // Add drag-to-open
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handleOpenPanGesture))
            self.handleView.addGestureRecognizer(panGestureRecognizer)
                // Add tap-to-open
            let openTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleOpenTapGesture))
            openTapRecognizer.numberOfTapsRequired = 1
            self.handleView.addGestureRecognizer(openTapRecognizer)
        })
    }

    func slideToOpen() {
        
        // Clean up existing recognizers
        for recognizer: UIGestureRecognizer in handleView.gestureRecognizers! {
            recognizer.isEnabled = false
            handleView.removeGestureRecognizer(recognizer)
            
        }
        // trigger
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: [], animations: {() -> Void in
            self.c.constant = self.kOpenDrawExtent
            self.superview!.layoutIfNeeded()
        }, completion: {(finished: Bool) -> Void in
                // Add tap-to-close
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleCloseTapGesture))
            tapGestureRecognizer.numberOfTapsRequired = 1
            self.handleView.addGestureRecognizer(tapGestureRecognizer)
        })
        return
    }

    func handleOpenTapGesture(tapGestureRecognizer: UITapGestureRecognizer) {
        
        tapGestureRecognizer.isEnabled = false
        self.slideToOpen()
    }

    func handleOpenPanGesture(panGestureRecognizer: UIPanGestureRecognizer) {
        
        
        let horizontal = [(.left), (.leading), (.right), (.trailing)].contains((side))
        let offset = panGestureRecognizer.translation(in: self.superview!)
        let amount: CGFloat = horizontal ? abs(offset.x) : abs(offset.y)
        if (amount + kClosedDrawExtent + kHandleInset + kHandleExtent / 2) > kTriggerPoint {
            panGestureRecognizer.isEnabled = false
            self.slideToOpen()
            return
        }
        switch panGestureRecognizer.state {
            case .began:
                break
            case .changed:
                                // Follow finger drag
                
                let constant = (amount + kClosedDrawExtent + kHandleInset + kHandleExtent / 2)
                self.c.constant = constant
            
                print(constant, self.c.constant)
            case .ended:
                                // Snap shut
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.25, initialSpringVelocity: 0.5, options: [], animations: {() -> Void in
                    self.c.constant = self.kClosedDrawExtent
                    self.superview!.layoutIfNeeded()
                }, completion: {(finished: Bool) -> Void in
                })
                
                print(self.c.constant)
            default:
                break
        }

    }

    
    func getHandleView() -> UIImageView {
        return handleView
    }
    
    init(frame: CGRect, parent: UIViewController, side: NSLayoutAttribute) {
        
        super.init(frame: frame)
        
        if ![(.left), (.leading), (.right), (.trailing), (.top), (.bottom)].contains((side)) {
          
        }
        
        // Establish general look and auto layout
        self.backgroundColor = UIColor.white
        self.autoLayoutEnabled = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        // Create child nav bar for translucency
        let nb = UINavigationBar()
        nb.autoLayoutEnabled = true
        self.addSubview(nb)
        StretchViewToSuperview(view: nb, inset: CGSize.zero, priority: 1000)
        // Build handle
        handleView = UIImageView()
        handleView.isUserInteractionEnabled = true
        handleView.contentMode = .center
        handleView.autoLayoutEnabled = true
        handleView.layer.cornerRadius = 10
        handleView.backgroundColor = UIColor.green
        self.addSubview(handleView)
        // Add to parent
        parent.view.addSubview(self)
        self.side = side
        
        let horizontal = [(.left), (.leading), (.right), (.trailing)].contains((side))
        if horizontal {
            CenterViewInSuperview(view: handleView, horizontal: false, vertical: true, priority: 1000)
            SizeView(view: handleView, size: CGSize(width: kHandleExtent, height: kHandleLength), priority: 1000)
            SizeView(view: self, size: CGSize(width: kDrawerExtent,height: SkipConstraint), priority: 1000)
            StretchViewToTopLayoutGuide(controller: parent, view: self, inset: 0, priority: 1000)
            StretchViewToBottomLayoutGuide(controller: parent, view: self, inset: 0, priority: 1000)
        }
        else {
            CenterViewInSuperview(view: handleView, horizontal: true, vertical: false, priority: 1000)
            SizeView(view: handleView, size: CGSize(width: kHandleLength, height: kHandleExtent), priority: 1000)
            SizeView(view: self, size: CGSize(width: SkipConstraint, height: kDrawerExtent), priority: 1000)
            StretchViewHorizontallyToSuperview(view: self, inset: 0, priority: 1000)
        }
        switch side {
        case .left, .leading:
            self.c = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: parent.view, attribute: .leading, multiplier: 1, constant: kClosedDrawExtent)
            AlignViewInSuperview(view: handleView, attribute: .trailing, inset: kHandleInset, priority: 1000)
        case .right, .trailing:
            self.c = NSLayoutConstraint(item: parent.view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: kClosedDrawExtent)
            AlignViewInSuperview(view: handleView, attribute: .leading, inset: kHandleInset, priority: 1000)
        case .top:
            
            
            self.c = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: parent.view, attribute: .top, multiplier: 1, constant: kClosedDrawExtent)
            AlignViewInSuperview(view: handleView, attribute: .bottom, inset: kHandleInset, priority: 1000)
        case .bottom:
            self.c = NSLayoutConstraint(item: parent.view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: kClosedDrawExtent)
            AlignViewInSuperview(view: handleView, attribute: .top, inset: kHandleInset, priority: 1000)
        default:
            break
        }
        
        // This is the all-purpose position constraint regardless
        // of the side the view is presented on
        //c.installWithPriority(750)
        c.priority = 750
        
        // Add slide to open
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handleOpenPanGesture))
        handleView.addGestureRecognizer(recognizer)
        // Add tap to open
        let openTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleOpenTapGesture))
        openTapRecognizer.numberOfTapsRequired = 1
        handleView.addGestureRecognizer(openTapRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    class func viewWithParent(parent: UIViewController, side: NSLayoutAttribute) -> Self {
//        return self.init(frame: CGRect.zero, parent: parent, side: side)
//    }
}
