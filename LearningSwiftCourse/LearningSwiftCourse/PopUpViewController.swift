//
//  PopUpViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 08/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//https://www.youtube.com/watch?v=CXvOS6hYADc

import UIKit
import IBAnimatable

@IBDesignable
class PopUpViewController: UIViewController {

    
    @IBOutlet var addItemPopUpView: AnimatableView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    @IBAction func homeItem(_ sender: UIBarButtonItem) {
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        animateIn()
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
        animateOut()
    }
    
    var effect : UIVisualEffect!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        effect = visualEffectView.effect
        visualEffectView.effect = nil
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animateIn(){
        self.view.addSubview(addItemPopUpView)
        addItemPopUpView.center = self.view.center
        
        addItemPopUpView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        addItemPopUpView.alpha = 0
        
        UIView.animate(withDuration: 0.4) { [weak self] _ in
            self?.visualEffectView.effect = self?.effect
            self?.addItemPopUpView.alpha = 1.0
            self?.addItemPopUpView.transform = CGAffineTransform.identity
        }
        
    }
    
    func animateOut(){
        
        UIView.animate(withDuration: 0.3, animations: { [weak self] _ in            
            self?.addItemPopUpView.alpha = 0.0
            self?.addItemPopUpView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self?.visualEffectView.effect = nil
        }, completion: { [weak self] (completed: Bool) in
            self?.addItemPopUpView.removeFromSuperview()
        })
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
        effect = nil
        
        if view != nil {
            for sv in view.subviews {
                sv.removeFromSuperview()
            }
            
            view.removeFromSuperview()
        }
    }
    
    
    deinit {
        clearAll()
        print("Pop Up view controller is \(#function)")
    }

}
