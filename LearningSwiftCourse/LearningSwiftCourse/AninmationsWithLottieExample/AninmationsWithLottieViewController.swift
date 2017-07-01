//
//  AninmationsWithLottieViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 01/07/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//https://github.com/brianadvent/AninmationsWithLottie
//https://github.com/bodymovin/bodymovin
//https://github.com/airbnb/lottie-ios
//https://airbnb.design/lottie/#get-started
//https://www.youtube.com/watch?v=ESjFEaZx7UI

import UIKit
import Lottie

class AninmationsWithLottieViewController: UIViewController {

    @IBAction func homeButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
    }
    
    let animationView = LOTAnimationView(name: "PinJump")
    @IBAction func showAnimation(_ sender: UIButton) {
        
        for subview in view.subviews {
            if subview == animationView {
                subview.removeFromSuperview()
            }
        }
        
        let frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: 250)
        animationView.frame = frame
        animationView.contentMode = .scaleAspectFill
        animationView.loopAnimation = true
        view.addSubview(animationView)
        
        animationView.play()
    }
    
    var isMenuOn = false
    var hamburgerMenuButton : LOTAnimationView?
    let hamburgerMenuFrame =  CGRect(x: 0, y: 10, width: 100, height: 100)
    
    func addHamburgermenuButton(is on: Bool){
        
        if hamburgerMenuButton != nil {
            hamburgerMenuButton?.removeFromSuperview()
            hamburgerMenuButton = nil
        }
        
        let animationName = on ? "buttonOff" : "buttonOn"
        hamburgerMenuButton = LOTAnimationView(name: animationName)
        hamburgerMenuButton?.isUserInteractionEnabled = true
        hamburgerMenuButton?.frame = hamburgerMenuFrame
        hamburgerMenuButton?.contentMode = .scaleAspectFill
        
        hamburgerMenuButton?.gestureRecognizers?.removeAll()
        addMenuToggleRecognizer()
        
        view.addSubview( hamburgerMenuButton!)
        
    }
  
    func addMenuToggleRecognizer(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(menuToggle))
        tap.numberOfTapsRequired = 1
        hamburgerMenuButton?.addGestureRecognizer(tap)
    }
    
    @objc func menuToggle(tapped : UITapGestureRecognizer){
        
        hamburgerMenuButton?.play(completion: { (completed) in
            self.isMenuOn = !self.isMenuOn
            self.addHamburgermenuButton(is: self.isMenuOn)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addHamburgermenuButton(is: isMenuOn)
        
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
