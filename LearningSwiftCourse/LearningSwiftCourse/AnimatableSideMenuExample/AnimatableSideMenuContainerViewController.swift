//
//  ContainerViewController.swift
//  Taasky
//
//  Created by Audrey M Tam on 18/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//
//https://www.raywenderlich.com/87268/3d-effect-taasky-swift

import UIKit

class AnimatableSideMenuContainerViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var sideMenuContainerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
  
    private var detailViewController: AnimatableDetailViewController?
    
    var menuItem: NSDictionary? {
        didSet {
            hideOrShowMenu(show: false, animated: true)
            if let detailViewController = detailViewController {
                detailViewController.menuItem = menuItem
            }
        }
    }
  
    var showingMenu = false
  
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sideMenuContainerView.layer.anchorPoint = CGPoint(x:1.0, y:0.5)
        hideOrShowMenu(show: showingMenu, animated: false)
    }
  
    // MARK: ContainerViewController
    func hideOrShowMenu(show: Bool, animated: Bool) {
        let xOffset = sideMenuContainerView.bounds.size.width
        scrollView.setContentOffset(show ? CGPoint.zero : CGPoint(x:xOffset,y: 0), animated: animated)
        showingMenu = show
    }
  
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let multiplier = 1.0 / (sideMenuContainerView.bounds.size.width)
        let offset = scrollView.contentOffset.x * multiplier
        let fraction = 1.0 - offset
        
        sideMenuContainerView.layer.transform = transformForFraction(fraction: fraction)
        sideMenuContainerView.alpha = fraction
    
        if let detailViewController = detailViewController {
            if let rotatingView = detailViewController.hamburgerView {
                rotatingView.rotate(fraction: fraction)
            }
        }
    
        /*
         Fix for the UIScrollView paging-related issue mentioned here:
         http://stackoverflow.com/questions/4480512/uiscrollview-single-tap-scrolls-it-to-top
         */
        scrollView.isPagingEnabled = scrollView.contentOffset.x < (scrollView.contentSize.width - scrollView.frame.size.width)
    
        let menuOffset = sideMenuContainerView.bounds.size.width
        showingMenu = !CGPoint(x: menuOffset, y: 0).equalTo(scrollView.contentOffset)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailViewSegue" {
            let navigationController = segue.destination as! UINavigationController
            detailViewController = navigationController.topViewController as? AnimatableDetailViewController
        }
    }
    
    // MARK: - Private
  
    func transformForFraction(fraction:CGFloat) -> CATransform3D {
        var identity = CATransform3DIdentity
        identity.m34 = -1.0 / 1000.0;
        let angle = Double(1.0 - fraction) * -(Double.pi/2)
        let xOffset = (sideMenuContainerView.bounds.size.width) * 0.5
        let rotateTransform = CATransform3DRotate(identity, CGFloat(angle), 0.0, 1.0, 0.0)
        let translateTransform = CATransform3DMakeTranslation(xOffset, 0.0, 0.0)
        return CATransform3DConcat(rotateTransform, translateTransform)
    }


}
