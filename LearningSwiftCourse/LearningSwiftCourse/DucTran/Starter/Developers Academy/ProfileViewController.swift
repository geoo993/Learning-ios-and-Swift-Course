//
//  ProfileViewController.swift
//  Walkthroughs
//
//  Created by Duc Tran on 11/29/15.
//  Copyright © 2015 Developers Academy. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var joinProgramsButton: UIButton!
    
    @IBAction func joinProgramsClicked(_ sender: AnyObject)
    {
        self.tabBarController?.selectedIndex = 2
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        joinProgramsButton.layer.cornerRadius = 5.0
        joinProgramsButton.layer.masksToBounds = true
        
        // burger side bar menu
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
