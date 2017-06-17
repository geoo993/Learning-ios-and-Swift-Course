//
//  SliderMenuDrawerCustomViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 17/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class SliderMenuDrawerCustomViewController: SliderMenuDrawerBaseViewController {

    @IBOutlet weak var mainLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSlideMenuButton()
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
        print("Slider Menu Drawer custom view controller is \(#function)")
    }
}
