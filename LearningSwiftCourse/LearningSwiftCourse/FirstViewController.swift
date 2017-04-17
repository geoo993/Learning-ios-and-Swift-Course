//
//  ViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 16/04/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBAction func homeButton(_ sender: UIButton) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            dismiss(animated: true) { 
                print("view controller dismissed, now going to home page")
            }
        }
    }
    
    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.cyan
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if sender is UIButton {
             print("clicked on button")
             
             if segue.identifier == "toColorsViewControllerSegue" {
                let colorsViewController = segue.destination as? ColorChangeViewController
                colorsViewController?.colorViewText = textField.text
                print("going to colors view controller")
             }
        }
     
    }
    
    deinit {
        print("Colors View controller is \(#function)")
    }
    

}
