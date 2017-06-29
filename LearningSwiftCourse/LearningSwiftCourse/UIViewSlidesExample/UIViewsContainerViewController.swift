//
//  UIViewsContainerViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 29/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class UIViewsContainerViewController: UIViewController {

    @IBOutlet weak var redview : UIView!
    @IBOutlet weak var greenview : UIView!
    @IBOutlet weak var blueview : UIView!
    @IBOutlet weak var yellowview : UIView!
    
    lazy var titles = ["Red", "Green", "Blue", "Yellow"]
    func getAllviews() -> [UIView]
    {
        return [redview, greenview, blueview, yellowview]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpViews()
    }
    
    func setUpViews(){
        let viewsframe = self.view.bounds
        self.view.addSubview(redview)
        self.view.addSubview(greenview)
        self.view.addSubview(blueview)
        self.view.addSubview(yellowview)
        
        let allviews = getAllviews()
        for view in allviews {
            view.frame = viewsframe
        }
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
