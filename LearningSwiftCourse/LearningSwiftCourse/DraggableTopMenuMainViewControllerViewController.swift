//
//  DraggableTopMenuMainViewControllerViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 12/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

//https://stackoverflow.com/questions/29659360/swift-uidynamic-animate-panel-from-bottom-to-top

import UIKit

class DraggableTopMenuMainViewControllerViewController: UIViewController {

    @IBOutlet weak var draggableView : DraggableView!
    
    @IBOutlet weak var simpleSlideDrawerView : SimpleDraggableView!
   
    @IBAction func homebutton(_ sender: UIButton) {
        
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
    }
    
    var heightRatio : CGFloat = 0.45
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadDraggableView()
        
        loadSimpleSlideDrawer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func loadDraggableView(){
        self.view.addSubview(draggableView)
        
        let heightToSee : CGFloat = 40
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height * heightRatio
        let frame = CGRect(x: 0, y: -height + heightToSee, width: width, height: height)
        
        draggableView.frame = frame
        draggableView.heightToSee = heightToSee
        draggableView.maxHeight = height
        draggableView.superViewHeight = self.view.bounds.size.height
        draggableView.setup()
        draggableView.backgroundImageView.blurImage()
    }
    
    
    func loadSimpleSlideDrawer(){
        
        self.view.addSubview(simpleSlideDrawerView)
        
        simpleSlideDrawerView.setupDraggableView(with: self.view, widthRatio: 1, heightRatio: heightRatio, heightToSee: 30)
        
        simpleSlideDrawerView.setupGestureRecognizer()
    
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
        print("Draggable menus view controller is \(#function)")
    }

}
