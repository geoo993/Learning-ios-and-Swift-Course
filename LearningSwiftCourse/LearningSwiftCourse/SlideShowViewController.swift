//
//  SlideShowViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 10/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
///https://stackoverflow.com/questions/40289976/how-to-apply-an-animation-effect-to-uiimageview-slideshow
//https://stackoverflow.com/questions/35244884/move-view-in-direction-of-specific-angle


import UIKit
import EasyAnimation

class SlideShowViewController: UIViewController {

    
    var containerView : SlideShowView? = nil
    let imageNames = ["seasunset", "blossomBlue", "blueMoon", "coralreef", "blueseabluesky"]
   
    //Mark: - Status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var homebutton : UIButton!
    
    //Mark: - Dismiss controller
    @IBAction func homebuttonAction(_ sender: UIButton) {
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if containerView == nil {
            let frame = self.view.frame
            let images = imageNames.flatMap{ UIImage(named: $0)! }
            
            containerView = SlideShowView(frame: frame, parentView: view, images: images) 
            if let container = containerView {
                view.addSubview(container)
                view.bringSubview(toFront: homebutton) 
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        containerView?.animateImageViews()
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
    
    func clearAll(){
        view.removeEverything()
    }
    
    deinit {
        clearAll()
        print("Slide show view controller is \(#function)")
    }

}
