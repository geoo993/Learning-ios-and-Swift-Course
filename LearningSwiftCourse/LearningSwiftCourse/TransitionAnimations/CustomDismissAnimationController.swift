//
//  CustomDismissAnimationController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 09/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation

class CustomDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    var duration = 0.9
    //var isPresenting = false
    var type = 1
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
      
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if type == 1 {
            let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
            let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
            let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
            let containerView = transitionContext.containerView
            toViewController.view.frame = finalFrameForVC
            toViewController.view.alpha = 0.5
            containerView.addSubview(toViewController.view)
            containerView.sendSubviewToBack(toViewController.view)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                fromViewController.view.frame = fromViewController.view.frame.insetBy(dx: fromViewController.view.frame.size.width / 2, dy: fromViewController.view.frame.size.height / 2)
                toViewController.view.alpha = 1.0
            }, completion: {
                finished in
                transitionContext.completeTransition(true)
            })
        }
        if type == 2 {
            
            let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
            let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
            let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
            let containerView = transitionContext.containerView
            toViewController.view.frame = finalFrameForVC
            toViewController.view.alpha = 0.5
            containerView.addSubview(toViewController.view)
            containerView.sendSubviewToBack(toViewController.view)
            
            let snapshotView = fromViewController.view.snapshotView(afterScreenUpdates: false)
            snapshotView?.frame = fromViewController.view.frame
            containerView.addSubview(snapshotView!)
            
            fromViewController.view.removeFromSuperview()
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                snapshotView?.frame = fromViewController.view.frame.insetBy(dx: fromViewController.view.frame.size.width / 2, dy: fromViewController.view.frame.size.height / 2)
                toViewController.view.alpha = 1.0
            }, completion: {
                finished in
                snapshotView?.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
            
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        //isPresenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        //isPresenting = false
        return self
    }

}
