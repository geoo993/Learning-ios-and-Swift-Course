//
//  BBCiPlayerContentDetailedViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 20/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class BBCiPlayerContentDetailedViewController: UIViewController, UINavigationBarDelegate {
    
    @IBAction func stopButton(_ sender: UINavigationItem) {
        dismiss(animated: true) { 
            print("ViewController dismissed, now going to home page")
        }
        //self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func playontvButton(_ sender: UINavigationItem) {
        print("Play on tv")
    }
    
    @IBOutlet weak var navBar : UINavigationBar!
    
    //Mark: - Status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var navbarHeight : CGFloat = 84
    var navbarTitle : String = "Hello"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.clearNavigationBarBackground()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
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

}
