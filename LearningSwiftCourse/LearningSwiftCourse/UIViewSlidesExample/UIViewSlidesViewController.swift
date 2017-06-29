//
//  UIViewSlidesViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 29/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class UIViewSlidesViewController: UIViewController {

    @IBAction func homebutton(_ sender: Any) {
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
    }
    
    var currentViewIndex = 0
    var containerViewController: UIViewsContainerViewController?
    
    @IBOutlet weak var viewsContainer: UIView!
    @IBOutlet weak var topVisualEffectView: UIVisualEffectView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var leftArrow: UIImageView!
    @IBOutlet weak var rightArrow: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBAction func indexChanged(_ sender: UISegmentedControl)
    { 
        
        guard containerViewController != nil else { print("container view is nil"); return }
        currentViewIndex = segmentedControl.selectedSegmentIndex
        transitionView(with: currentViewIndex )
    }
    
    func transitionView(with index: Int){
        
        if let allviews = containerViewController?.getAllviews() {
            allviews.forEach({ (view) in
                view.isHidden = true
                view.isUserInteractionEnabled = false
            })
            //allviews[index].isHidden = false
            //allviews[index].setVisible(visible: true, animated: true)
            allviews[index].setHidden(with: false, animated: true)
            allviews[index].isUserInteractionEnabled = true
            titleLabel.text = containerViewController?.titles[index] ?? ""
            leftArrow.isHidden = (index <= 0)
            rightArrow.isHidden = (index >= (allviews.count - 1) )
            pageControl.currentPage = index
        }
        
    }
    
    func setupSwipeGesture (){
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeLeft.direction = .left
        topVisualEffectView.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeRight.direction = .right
        topVisualEffectView.addGestureRecognizer(swipeRight)
    }
    
    @objc func handleSwipeGesture(gesture: UISwipeGestureRecognizer) -> Void {
        
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            if currentViewIndex >= (pageControl.numberOfPages - 1) {
                currentViewIndex = (pageControl.numberOfPages - 1)
            }else{
                currentViewIndex += 1
                segmentedControl.selectedSegmentIndex = currentViewIndex
                transitionView(with: currentViewIndex )
            }
        }else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            if currentViewIndex <= 0 {
                currentViewIndex = 0
            }else{
                currentViewIndex -= 1
                segmentedControl.selectedSegmentIndex = currentViewIndex
                transitionView(with: currentViewIndex )
            }
        }
        
        segmentedControl.reloadInputViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSwipeGesture()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "containerOfViews" {
            let containerVC = segue.destination as! UIViewsContainerViewController
            containerViewController = containerVC
            pageControl.numberOfPages = containerVC.titles.count
            segmentedControl.selectedSegmentIndex = currentViewIndex
            transitionView(with: currentViewIndex)
        }
    }
  
    deinit {
        print(" UIView Slides View Controller \(#function)")
    }
}
