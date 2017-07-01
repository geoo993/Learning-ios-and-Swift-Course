//
//  PieChartPageViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 30/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class PieChartPageViewController: UIPageViewController {

    let pageTitles = ["Circle Pie Chart", "Simple Pie Chart", "Pie Chart With Sub Data", "Pie Chart With Border Lines"]
    let pageColor = [UIColor.red, UIColor.orange, UIColor.cyan, UIColor.brown]
    var numberOfPages = 4
    var pageIndex = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dataSource = self
        
        // Create the first screen
        if let startingViewController = self.pageViewController(atIndex: pageIndex) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: - Get the Next View Controller
    func nextPageViewController(withIndex  index: Int) -> UIViewController? {
        if let piechartviewController = self.pageViewController(atIndex: (index + 1) ) {
            setViewControllers([piechartviewController], direction: .forward, animated: true, completion: nil)
        }
        return nil
    }
    
    // Mark: - Get the Previous View Controller
    func previousPageViewController(withIndex  index: Int) -> UIViewController? {
        if let piechartviewController = self.pageViewController(atIndex: (index - 1) ) {
            setViewControllers([piechartviewController], direction: .reverse, animated: true, completion: nil)
        }
        return nil
    }
    
    // Mark: - Set the current view controller properties
    fileprivate func pageViewController(atIndex index: Int) -> UIViewController? {
        
        if index == NSNotFound || index < 0 || index >= numberOfPages {
            return nil
        }
        
        if index < numberOfPages {
            
            let page = self.storyboard!.instantiateViewController(withIdentifier: "PieChartViewViewController") as! PieChartViewViewController
            
            page.numberOfPages = numberOfPages
            page.pageIndex = index
            page.titleText = pageTitles[index]
            page.view.backgroundColor = pageColor[index]
            
            return page
        }
        
        return nil
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


// Mark: - UIPageViewControllerDataSource
extension PieChartPageViewController: UIPageViewControllerDataSource {
    
    ////next page
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let piechartviewController = viewController as! PieChartViewViewController
        
        if (piechartviewController.pageIndex + 1) < numberOfPages {
            return self.pageViewController(atIndex: (piechartviewController.pageIndex + 1) )
        }
        
        return nil
        
    }
    
    
    //previous page
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        
        let piechartviewController = viewController as! PieChartViewViewController
        
        if piechartviewController.pageIndex > 0 {
            return self.pageViewController(atIndex: (piechartviewController.pageIndex - 1) )
        }
        
        return nil
        
    }
    
}
