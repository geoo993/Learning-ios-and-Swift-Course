//
//  MenuTransitionManager.swift
//  SlideMenu
//
//  Created by Simon Ng on 19/10/2015.
//  Copyright © 2015 AppCoda. All rights reserved.
//
//https://www.appcoda.com/custom-view-controller-transitions-tutorial/

import UIKit

@objc protocol AnimationTransitionManagerDelegate {
    func dismiss()
}

class AnimationControllerManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    var duration = 0.5
    var isPresenting = false
    var type = 0
    var reverse = false
    
    var snapshot:UIView? {
        didSet {
            if let delegate = delegate {
                let tapGestureRecognizer = UITapGestureRecognizer(target: delegate, action: #selector(AnimationTransitionManagerDelegate.dismiss))
                snapshot?.addGestureRecognizer(tapGestureRecognizer)
            }
        }
    }
    
    var delegate: AnimationTransitionManagerDelegate?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if type == 1 {
            
            // Get reference to our fromView, toView and the container view
            let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
            
            // Set up the transform we'll use in the animation
            let container = transitionContext.containerView 
            
            
            let moveDown = CGAffineTransform(translationX: 0, y: container.frame.height - 150)
            let moveUp = CGAffineTransform(translationX: 0, y: -50)
            
            // Add both views to the container view
            if isPresenting {
                toView.transform = moveUp
                snapshot = fromView.snapshotView(afterScreenUpdates: true)
                container.addSubview(toView)
                container.addSubview(snapshot!)
            }
            
            // Perform the animation
            UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: { [weak self] _ in
                
                guard let this = self else { return }
                
                if this.isPresenting {
                    this.snapshot?.transform = moveDown
                    toView.transform = CGAffineTransform.identity
                } else {
                    this.snapshot?.transform = CGAffineTransform.identity
                    fromView.transform = moveUp
                }
                
                }, completion: { [weak self] finished in
                    guard let this = self else { return }
                    transitionContext.completeTransition(true)

                    if !this.isPresenting {
                        this.snapshot?.removeFromSuperview()
                    }
            })
        }
        
        if type == 2 {
        
            let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
            let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
            let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
            let containerView = transitionContext.containerView
            let bounds = UIScreen.main.bounds
            reverse = !reverse
            let dy = reverse ? -bounds.size.height : bounds.size.height
            toViewController.view.frame = finalFrameForVC.offsetBy(dx: 0, dy: dy)
            containerView.addSubview(toViewController.view)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
                fromViewController.view.alpha = 0.5
                toViewController.view.frame = finalFrameForVC
            }, completion: {
                finished in
                transitionContext.completeTransition(true)
                fromViewController.view.alpha = 1.0
            })
            
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresenting = false
        return self
    }

}
