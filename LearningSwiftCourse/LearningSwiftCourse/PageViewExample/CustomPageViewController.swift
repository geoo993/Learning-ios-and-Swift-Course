//
//  CustomPageViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 12/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//https://www.youtube.com/watch?v=K3CSBxX5VXA
//

import UIKit

class CustomPageViewController: UIPageViewController {
    

    let pageHeaders = ["Beach Waters", "Sunset Beach", "Clear Water Beach", "Sunny Trees", "Palm Tree Waters"]
    let pageImages = ["beachwater", "sunsetbeach", "beachimage", "intrees", "palmtreesunset"]
    
    var numberOfPages = 5
    var pageIndex = 0
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        
        // Create the first screen
        if let startingViewController = self.pageViewController(atIndex: pageIndex) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    // Mark: - Get the Next View Controller
    func nextPageViewController(withIndex  index: Int) -> UIViewController? {
        if let walkthroughviewController = self.pageViewController(atIndex: (index + 1) ) {
            setViewControllers([walkthroughviewController], direction: .forward, animated: true, completion: nil)
        }
        return nil
    }
    
    // Mark: - Get the Previous View Controller
    func previousPageViewController(withIndex  index: Int) -> UIViewController? {
        if let walkthroughviewController = self.pageViewController(atIndex: (index - 1) ) {
            setViewControllers([walkthroughviewController], direction: .reverse, animated: true, completion: nil)
        }
        return nil
    }
    
    // Mark: - Set the current view controller properties
    fileprivate func pageViewController(atIndex index: Int) -> UIViewController? {
        
        if index == NSNotFound || index < 0 || index >= numberOfPages {
            return nil
        }
        
        if index < numberOfPages {
            
            let page = self.storyboard!.instantiateViewController(withIdentifier: "WalkthroughViewController") as! WalkthroughPageViewController
            
            page.numberOfPages = numberOfPages
            page.pageIndex = index
            page.headerText = pageHeaders[index]
            page.imageName = pageImages[index]
            
            return page
        }
        
        return nil
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
    
    func clearAll(){
        view.removeEverything()
    }
    
    deinit {
        clearAll()
        print("Custom Page view controller is \(#function)")
    }
    
}

// Mark: - UIPageViewControllerDataSource
extension CustomPageViewController: UIPageViewControllerDataSource {
    
    ////next page
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let walkthroughviewController = viewController as! WalkthroughPageViewController
        
        if (walkthroughviewController.pageIndex + 1) < numberOfPages {
            return self.pageViewController(atIndex: (walkthroughviewController.pageIndex + 1) )
        }
        
        return nil
        
    }
    
    
    //previous page
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        
        let walkthroughviewController = viewController as! WalkthroughPageViewController
        
        if walkthroughviewController.pageIndex > 0 {
            return self.pageViewController(atIndex: (walkthroughviewController.pageIndex - 1) )
        }
        
        return nil
        
    }
    
}

// Mark: - UIPageViewControllerDelegate
extension CustomPageViewController: UIPageViewControllerDelegate {
    
    
}


