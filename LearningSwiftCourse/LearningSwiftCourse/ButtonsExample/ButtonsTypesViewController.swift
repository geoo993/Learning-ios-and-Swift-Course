//
//  ButtonsTypesViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 15/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//https://www.youtube.com/watch?v=AdOUVC_wJmw
//https://www.youtube.com/watch?v=v2AZ0JgKhQU
//https://www.youtube.com/watch?v=It3dsnGhhLo

import UIKit

class ButtonsTypesViewController: UIViewController {

    @IBOutlet weak var animatedButton : UIButton!
    
    @IBAction func buttonTouchDown(_ sender: UIButton) {
        print("Touch Down")
        animatedButton.titleLabel?.alpha = 0.2
    }
    @IBAction func buttonTouchUpInside(_ sender: UIButton) {
        print("Touch Up Inside")
        UIView.animate(withDuration: 0.2) { [weak self] () -> Void in
            self?.animatedButton.titleLabel?.alpha = 1.0
        }
    }
    @IBAction func buttonTouchUpOutside(_ sender: UIButton) { 
        print("Touch Up Outside")
        UIView.animate(withDuration: 0.2) { [weak self] () -> Void in
            self?.animatedButton.titleLabel?.alpha = 1.0
        }
    }
   
    @IBAction func homebutton(_ sender: UIButton) {
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        systemsButton()
        customButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func systemsButton (){
        
        //create button
        let yPosition = self.view.frame.size.height - 120
        // var button   = UIButton.buttonWithType(UIButtonType.System) as UIButton
        let button = UIButton(type: .system) // let preferred over var here
        button.frame = CGRect(x:0, y:0, width: 200, height:30)
        button.center = CGPoint(x: self.view.center.x, y: yPosition)
        button.clipsToBounds = true
        button.layer.cornerRadius = 0.05 * button.bounds.size.width
        button.adjustsImageWhenHighlighted = true
        //button.titleLabel?.font = button.titleLabel?.font.withSize(15) 
        button.setTitle("Systems Code Button", for: UIControlState.normal)
        
        //load images
        var defaultImage = UIImage(named: "buttonWhiteBackground")
        defaultImage = defaultImage?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
        let highlighedImage = UIImage(named: "buttonWhiteBackHighlighted")
        button.setBackgroundImage(defaultImage, for: UIControlState.normal)
        button.setBackgroundImage(highlighedImage, for: UIControlState.highlighted)
        button.setBackgroundImage(highlighedImage, for: UIControlState.selected)
        self.view.addSubview(button)
        
        //set gestures target actions
        button.addTarget(self, action: #selector(systemsButtonDown), for: UIControlEvents.touchDown)
        button.addTarget(self, action: #selector(systemsButtonTouchUpInside), for: UIControlEvents.touchUpInside)
        button.addTarget(self, action: #selector(systemsButtonTouchUpOutside), for: UIControlEvents.touchUpOutside)
    }
    @objc func systemsButtonDown(_ sender : UIButton){
        print("Systems Button Touch Down")
    }
    
    @objc func systemsButtonTouchUpInside(_ sender : UIButton){
        print("Systems Button Touch Up Inside")
    }
    @objc func systemsButtonTouchUpOutside(_ sender : UIButton){
        print("Systems Button Touch Up Outside")
    }
    
    func customButton(){
        //create button
        let yPosition = self.view.frame.size.height - 70
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 200.0, height: 30.0)
        button.center = CGPoint(x: self.view.center.x, y: yPosition)
        button.titleLabel?.font = button.titleLabel?.font.withSize(15)
        button.setTitle("Custom Code Button", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 0.05 * button.bounds.size.width
        button.clipsToBounds = true
        button.adjustsImageWhenHighlighted = true
        
        //add background images
        let defaultImage = UIImage(named: "buttonBlueBackground")
        let highlighedImage = UIImage(named: "buttonBlueBackHighlighted")
        button.setBackgroundImage(defaultImage, for: UIControlState.normal)
        button.setBackgroundImage(highlighedImage, for: UIControlState.highlighted)
        self.view.addSubview(button)
        
        //set gestures target actions
        button.addTarget(self, action: #selector(customButtonDown), for: UIControlEvents.touchDown)
        button.addTarget(self, action: #selector(customButtonTouchUpInside), for: UIControlEvents.touchUpInside)
        button.addTarget(self, action: #selector(customButtonTouchUpOutside), for: UIControlEvents.touchUpOutside)
    }
    
    @objc func customButtonDown(_ sender : UIButton){
        sender.titleLabel?.alpha = 0.2
    }
    @objc func customButtonTouchUpInside(_ sender : UIButton){
        UIView.animate(withDuration: 0.2) {
            sender.titleLabel?.alpha = 1.0
        }
    }
    @objc func customButtonTouchUpOutside(_ sender : UIButton){
        UIView.animate(withDuration: 0.2) {
            sender.titleLabel?.alpha = 1.0
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
