//
//  TabBarViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 17/04/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    var model:TabBarModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model = TabBarModel()
        // Do any additional setup after loading the view.
       
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //This method will be called when user changes tab.
        
        if (item.title == "Home"){
            dismiss(animated: true) { 
                self.viewControllers?.removeAll()
                print("tab bar controller dismissed, now going to home page")
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let emptyViewController = EmptyViewController()
        self.viewControllers?.append(emptyViewController)
        
        let item3 = UITabBarItem(title: "Home", image: nil, tag: 2)
        emptyViewController.tabBarItem = item3
            
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    deinit {
        print("Tab Bar view controller is \(#function)")
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
