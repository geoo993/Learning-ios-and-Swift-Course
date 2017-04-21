//
//  ViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 17/04/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class MainViewController: UIViewController
//, UITextFieldDelegate 
{

    
    
//    @IBOutlet weak var maintextfield: UITextField!
//    
//    
//    @IBAction func mainTextfieldAction(_ sender: UITextField) {
//    }
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        
//        //self.view.endEditing(true)
//        print("REturnnn")
//        
//        if (textField.returnKeyType == UIReturnKeyType.next) {
//            // tab forward logic here
//            return true
//        }
//        else if (textField.returnKeyType == UIReturnKeyType.go) {
//            // submit action here
//            return true
//        }
//
//        
//        return true
//        
//    }
//    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.maintextfield.delegate = self
        
        self.view.backgroundColor = UIColor.randomColor()
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

}
