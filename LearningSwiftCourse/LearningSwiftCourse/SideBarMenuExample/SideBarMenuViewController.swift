//
//  SideBarMenuViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 08/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//https://www.youtube.com/watch?v=qaLiZgUK2T0

import UIKit

class SideBarMenuViewController: UIViewController, SideBarMenuDelegate {

    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBAction func homebutton(_ sender: UIButton) {
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
    }
    
    var sideBarMenu : SideBarMenu?
    
    //Mark: - Status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        sideBarMenu = SideBarMenu(originView: self.view, menuItems: ["First Item", "Second Item", "Third Item", "Final Item"], width: 160, topInsect: 60)
        sideBarMenu?.sideBarMenuDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sideBarMenuDidSelectButtonAtIndex(at index: Int) {
        if index == 0 {
            bgImageView.image = UIImage(named: "beachwater")
        }else if index == 1{
            bgImageView.image = UIImage(named: "hawaiibeach")
        }else if index == 2 {
            bgImageView.image = UIImage(named: "foamywaves")
        }else if index == 3 {
            bgImageView.image = UIImage(named: "beachimage")
        }else{
            bgImageView.image = UIImage(named: "frosstedwhite")
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
    
    func clearAll(){
        sideBarMenu = nil
        
        if view != nil {
            for sv in view.subviews {
                sv.removeFromSuperview()
            }
            
            view.removeFromSuperview()
        }
    }
    
    
    deinit {
        clearAll()
        print("Side Bar Menu view controller is \(#function)")
    }

}
