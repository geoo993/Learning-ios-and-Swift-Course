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

    deinit {
        print(" UIView Slides View Controller \(#function)")
    }
}
