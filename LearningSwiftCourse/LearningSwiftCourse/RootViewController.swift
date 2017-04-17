//
//  RootViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 17/04/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UITextViewDelegate  {

    
    @IBAction func homeBarItem(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
        
    }
    
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var showDetailButton: UIButton!
    
    @IBOutlet weak var buttonDone: UIButton!
    
    @IBAction func dismissKeyboard(_ sender: UIButton) {
        
        textView.resignFirstResponder()
        
        //disable done button again
        sender.isEnabled = false
        
        //re-enable the show detail button
        showDetailButton.isEnabled = true
        
        //downcast
        let navController = navigationController as! NavigationViewController
        navController.model.enteredString = textView.text
        print(navController.model.enteredString)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        buttonDone.isEnabled = true
        showDetailButton.isEnabled = false
        print("entered editing mode")
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = ""
        textView.delegate = self
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
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.title = ""
        self.navigationItem.rightBarButtonItem?.title = ""
        
    }
    func enableNavigationbarItems(){
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Red View"
        
    }
  
    deinit {
        print("Navigation controller is \(#function)")
    }

}
