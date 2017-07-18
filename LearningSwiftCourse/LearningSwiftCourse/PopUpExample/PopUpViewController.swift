//
//  PopUpViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 08/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//https://www.youtube.com/watch?v=CXvOS6hYADc

import UIKit
import RxSwift

class PopUpViewController: UIViewController  {

    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    @IBAction func homeItem(_ sender: UIBarButtonItem) {
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
    }

    @IBAction func addItem(_ sender: UIBarButtonItem) {
        
        let view = AddItemView(frame: popUpFrame)
        animateIn(with: view)
        view.animateOut = { [weak self] () -> Void in
            guard let this = self else { return }
            
            this.animateOut(with: view)
        } 
    }

    @IBAction func pickItem(_ sender: UIBarButtonItem) {
        
        let view = PickItemView(frame: popUpFrame)
        animateIn(with: view)
        view.animateOut = { [weak self] () -> Void in
            guard let this = self else { return }
            this.animateOut(with: view)
        } 
    }
    
    var effect : UIVisualEffect!
    let popUpFrame = CGRect(x: 0, y: 0, width: 280, height: 200)
    let disposebag = DisposeBag()
    
    func removePopUpViews(with tag: Int){
        for subview in view.subviews {
            if subview.tag == tag {
                subview.removeEverything()
                subview.removeFromSuperview()
            }
        }
    }
    
    func animateIn(with view: UIView ) {
        let tag = 10
        removePopUpViews(with: tag)
        self.view.addSubview(view)
        view.center = self.view.center
        view.tag = tag
        view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        view.alpha = 0
        
        UIView.animate(withDuration: 0.4) { [weak self] () -> Void in
            self?.visualEffectView.effect = self?.effect
            view.alpha = 1.0
            view.transform = CGAffineTransform.identity
        }
        
    }
    
    func animateOut(with view: UIView) {
        
        UIView.animate(withDuration: 0.3, animations: { [weak self] () -> Void in            
            view.alpha = 0.0
            view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            
            if self?.visualEffectView.effect != nil {
                self?.visualEffectView.effect = nil
            }
        }, completion: { (completed: Bool) in
            view.removeEverything()
            view.removeFromSuperview()
        })
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        effect = visualEffectView.effect
        visualEffectView.effect = nil
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
 
    func clearAll(){
        effect = nil
        view.removeEverything()
    }
    
    deinit {
        clearAll()
        print("Pop Up view controller is \(#function)")
    }

}
