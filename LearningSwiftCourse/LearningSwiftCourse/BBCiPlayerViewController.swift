//
//  BBCiPlayerViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 23/05/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class BBCiPlayerViewController: UIViewController {

    @IBAction func homebutton(_ sender: Any) {
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.randomColor()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
    }
   
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    deinit {
        print("BBCiPlayer view controller is \(#function)")
    }
    
}
