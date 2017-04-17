//
//  SecondItemViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 17/04/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class MetricViewController: UIViewController {

    var tabs:TabBarViewController!
    
    @IBOutlet weak var centimetersTextfield: UITextField!
    @IBOutlet weak var metersLabel: UILabel!
    @IBOutlet weak var kilometersLabel: UILabel!
    
    @IBAction func centimetersChanged(_ sender: UITextField) {
        
        //dismiss the keyboard:
        sender.resignFirstResponder()
        
        //get the text:
        if let strCentimeters = sender.text {
            //convert text to double and send to the model
            let centimetersTextInDouble = NSString(string: strCentimeters).doubleValue
            tabs.model.centimeters = centimetersTextInDouble
            
            //update the view's controls
            update()
            
        }
    }
    
    func update(){
        centimetersTextfield.text = String(format: "%f", tabs.model.centimeters)
        metersLabel.text = String(format: "%f", tabs.model.meters)
        kilometersLabel.text = String(format: "%f", tabs.model.kilometers)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //downcast on tab bar view controller class
        tabs = tabBarController as! TabBarViewController
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        update()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    deinit {
        print("Metric View controller is \(#function)")
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
