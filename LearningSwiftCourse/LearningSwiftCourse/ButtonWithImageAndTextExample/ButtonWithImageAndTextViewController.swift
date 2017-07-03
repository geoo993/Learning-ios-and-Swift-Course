//
//  ButtonWithImageAndTextViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 02/07/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//https://stackoverflow.com/questions/4201959/label-under-image-in-uibutton
//https://stackoverflow.com/questions/4564621/aligning-text-and-image-on-uibutton-with-imageedgeinsets-and-titleedgeinsets
//https://stackoverflow.com/questions/33033737/display-image-and-text-in-button
//https://stackoverflow.com/questions/4564621/aligning-text-and-image-on-uibutton-with-imageedgeinsets-and-titleedgeinsets


import UIKit

class ButtonWithImageAndTextViewController: UIViewController {

    @IBOutlet weak var buttonOne : UIButton!
    @IBOutlet weak var buttonTwo : UIButton!
    @IBOutlet weak var buttonThree : UIButton!
    @IBOutlet weak var buttonFour : UIButton!
    @IBOutlet weak var buttonFive : UIButton!
    @IBOutlet weak var buttonSix : UIButton!
    
    @IBAction func homebutton(_ sender: UIButton) {
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

}
