//
//  BBCiPlayerContentNavigationController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 24/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class BBCiPlayerContentNavigationController: UINavigationController {

    var titleName : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.topItem?.title = titleName
        
        // Do any additional setup after loading the view.
        self.navigationBar.clearNavigationBarBackground(with: UIColor.bbciplayerDark())
        self.navigationBar.tintColor = UIColor.bbciplayerPink()
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
