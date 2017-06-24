//
//  SimpleSpringDrawerViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 24/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class SimpleSpringDrawerViewController: UIViewController {

    @IBOutlet weak var topDrawerView : TopDrawerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.addSubview(topDrawerView)
        
        let heightRatio : CGFloat = 0.4
        let heightToSee : CGFloat = 60
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height * heightRatio
        let frame = CGRect(x: 0, y: height + heightToSee, width: width, height: height)
        topDrawerView.parentView = self.view
        topDrawerView.frame = frame
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
