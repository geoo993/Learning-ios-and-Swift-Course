//
//  FirstItemViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 17/04/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class EnglishViewController: UIViewController {

    var tabs:TabBarViewController!
    
    @IBOutlet weak var inchesTextfield: UITextField!
    @IBOutlet weak var feetLabel: UILabel!
    @IBOutlet weak var milesLabel: UILabel!
    
    @IBAction func inchesChanged(_ sender: UITextField) {
        
        //dismiss the keyboard:
        sender.resignFirstResponder()
        
        //get the text:
        if let strInches = sender.text {
        
            //convert text to double and send to the model:
            let inchesInDouble = NSString(string: strInches).doubleValue
            tabs.model.inches = inchesInDouble
            
            //update the view's controls
            update()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //this is a downcast so we have !, we do not know if it will work
        tabs = tabBarController as! TabBarViewController
        // Do any additional setup after loading the view.
    }

    func update(){
        inchesTextfield.text = String(format: "%f", tabs.model.inches)
        feetLabel.text = String(format: "%f", tabs.model.feet)
        milesLabel.text = String(format: "%f", tabs.model.miles)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        update()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
