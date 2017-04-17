//
//  RootViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 17/04/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    func hideRemoveNavigationbarItems(){
//        self.navigationController?.isNavigationBarHidden = true
//        self.navigationItem.title = ""
//        self.navigationItem.rightBarButtonItem?.title = ""
        
    }
    func setupNavigationbarItems(){
        
        //self.navigationController?.isNavigationBarHidden = false
        
        //self.navigationController?.navigationBar.backgroundColor = UIColor.white
        //self.navigationController?.navigationBar.barTintColor = UIColor.white
        //self.navigationController?.navigationBar.isOpaque = true
        
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = UIColor.clear
//        
//        
//        self.navigationItem.hidesBackButton = true
//        self.navigationItem.backBarButtonItem?.isEnabled = false
//        
//        self.navigationItem.title = "Games"
//        //self.navigationItem.titleView = UIImageView(image: UIImage(named: ""))
//        
//        //Barbutton with text
//        self.navigationItem.rightBarButtonItem = nil
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Back To Reading", style: .plain, target: self, action: #selector(rightMenuButtonTapped(sender:)))
        
    }
    
    func rightMenuButtonTapped(sender: UIBarButtonItem) {
        print("\nRight Navigation Bar Item tapped")
        //self.navigationController?.popToRootViewController(animated: true)  
//        hideRemoveNavigationbarItems()
//        backToPage = true
//        if let navController = self.navigationController {
//            navController.popViewController(animated: true)
//        }
    }

}
