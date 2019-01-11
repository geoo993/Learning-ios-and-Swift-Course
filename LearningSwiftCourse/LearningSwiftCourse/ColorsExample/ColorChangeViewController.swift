//
//  ViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 12/04/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class ColorChangeViewController: UIViewController {

    @IBAction func exitButton(_ sender: UIButton) {
        dismiss(animated: true) { 
            print("view controller dismissed")
        }
    }
    
    
    @IBOutlet weak var colorView: UIView!
    var colorViewText : String!
    
    var colorViewDuplicate : UIView!
    
    @IBAction func showHide(_ sender: UIButton) {
        if sender.titleLabel?.text == "Show" {
            let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            colorViewDuplicate = UIView(frame: frame)
            colorViewDuplicate.backgroundColor = colorView.backgroundColor
            colorViewDuplicate.center = CGPoint(x: self.view.center.x, y: colorView.center.y + colorView.frame.height)
            self.view.addSubview(colorViewDuplicate)
            sender.setTitle("Hide", for: UIControl.State.normal)
        }else{
            sender.setTitle("Show", for: UIControl.State.normal)
            colorViewDuplicate.removeFromSuperview()
            colorViewDuplicate = nil
        }
    }
    
    @IBAction func changeColor(_ sender: UISegmentedControl) {
  
        switch sender.selectedSegmentIndex  {
        case 0:
            colorView.backgroundColor = UIColor.red
            colorViewDuplicate?.backgroundColor = UIColor.red
        case 1:
            colorView.backgroundColor = UIColor.green
            colorViewDuplicate?.backgroundColor = UIColor.green
        case 2:
            colorView.backgroundColor = UIColor.blue
            colorViewDuplicate?.backgroundColor = UIColor.blue
        default:
            print("Other")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        //we can get to the name of a function using (#function) anywhere we want to 
        print("init in \(#function)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("view did layout subviews")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
        
        let label = UILabel(frame: CGRect(x: 0,y:0, width: 200, height: 30))
        label.text = colorViewText
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.white
        colorView.addSubview(label)
        label.center = CGPoint(x:colorView.frame.width / 2, y: colorView.frame.height / 2)
    }
    
    //will be called every time thte view is displayed
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("view did disappear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }

 
    deinit {
        print("deinit \(#function)")
    }
}

