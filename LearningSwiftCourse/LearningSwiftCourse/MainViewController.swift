//
//  ViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 17/04/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class MainViewController: UIViewController
{

    @IBOutlet weak var mainImageView: UIImageView!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.random
        // Do any additional setup after loading the view.
        
        let img = mainImageView.bluredImage(radius: 2)
        //let img = mainImageView.applyBlurWithCrop(radius: 2,cropBy:2)
        mainImageView.image = img
        
        //mainImageView.blurImage()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /*
        //print(self.childViewControllers)
        
        if let topController1 = UIApplication.topViewController() {
            print("The view controller you're looking at is: \(topController1)")
        }
        
        let window = UIApplication.shared.keyWindow
        if let topController2 = window?.visibleViewController() {
            print(topController2)
        }
        if let currentViewControllers = window?.rootViewController?.childViewControllers {
            print(currentViewControllers)
        }
        */
    }

    
    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "tabbarviewsegue"
        {
            if let destinationViewController = segue.destination as? TabBarViewController
            {
                
            }
        }
    }
    */
    

}
