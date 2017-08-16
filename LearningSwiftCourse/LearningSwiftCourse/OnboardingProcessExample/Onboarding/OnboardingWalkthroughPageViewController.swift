//
//  OnboardingWalkthrough.swift
//  StorySmartiesView
//
//  Created by GEORGE QUENTIN on 09/08/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit
import RxSwift


public class OnboardingWalkthroughPageViewController: UIPageViewController {

    public let didCompleteWalkthrough = PublishSubject<Void>()
    public let didPressSkip = PublishSubject<Void>()
    
    public var numberOfPages = 0
    public var pageIndex = 0
    public var walkthroughPageModels : WalkthroughModel?
    var walkthroughModelService : WalkthroughModelService?

    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self

    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        walkthroughPageModels = walkthroughModelService!.getWalkthroughModel() 
        guard let walkthrough = walkthroughPageModels else {
            // TODO: warning
            return 
        }
        
        numberOfPages = walkthrough.pages.count
        pageIndex = 0
        
        
        // Create the first screen
        if let startingViewController = self.pageViewController(atIndex: pageIndex) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // Mark: - Get the Next View Controller
    func goToNextPageViewController(withIndex  index: Int, animated: Bool = true) {
        if let walkthroughviewController = self.pageViewController(atIndex: (index + 1)) {
            setViewControllers([walkthroughviewController], direction: .forward, animated: animated, completion: nil)
        }else{
            print("We are on the last page")
        }
    }
    
    // Mark: - Get the Previous View Controller
    func goToPreviousPageViewController(withIndex  index: Int, animated: Bool = true){
        if let walkthroughviewController = self.pageViewController(atIndex: (index - 1)) {
            setViewControllers([walkthroughviewController], direction: .reverse, animated: animated, completion: nil)
        }else{
            print("We are on the First page")
        }
    }

    // Mark: - Set the current view controller properties
    fileprivate func pageViewController(atIndex index: Int) -> UIViewController? {
        
        if index == NSNotFound || index < 0 || index >= numberOfPages {
            return nil
        }
        
        if let walkthrough = walkthroughPageModels, index < numberOfPages  { 
            let pageModel = walkthrough.pages[index] 
         
            let page = self.storyboard!.instantiateViewController(withIdentifier: "OnboardingProcessWalkthroughViewController") as! OnboardingProcessWalkthroughViewController
            page.pageModel = pageModel
            page.numberOfPages = numberOfPages
            page.pageIndex = index
            
            page.skipAction = {
                self.didPressSkip.onNext(())
            }
            
            page.nextAction = {
                
                if (page.pageIndex + 1) < self.numberOfPages {
                    self.goToNextPageViewController(withIndex: page.pageIndex)
                }else{
                    
                    print("We are on the last page")
                    self.didCompleteWalkthrough.onNext(())
                }
            }
            
            return page
        }
        
        return nil
    }

}

// MARK: - UIPageViewControllerDelegate
extension OnboardingWalkthroughPageViewController : UIPageViewControllerDelegate {
    
    
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingWalkthroughPageViewController : UIPageViewControllerDataSource {
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
                
        let walkthroughviewController = viewController as! OnboardingProcessWalkthroughViewController
        
        if walkthroughviewController.pageIndex > 0 {
            return self.pageViewController(atIndex: (walkthroughviewController.pageIndex - 1) )
        }
        
        return nil
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
                
     
        let walkthroughviewController = viewController as! OnboardingProcessWalkthroughViewController
        
        if (walkthroughviewController.pageIndex + 1) < numberOfPages {
            return self.pageViewController(atIndex: (walkthroughviewController.pageIndex + 1) )
        }
        
        return nil
    }
    
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return numberOfPages
    }
    
    
}
