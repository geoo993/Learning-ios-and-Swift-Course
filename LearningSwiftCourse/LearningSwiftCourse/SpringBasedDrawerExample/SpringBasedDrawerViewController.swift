//
//  SpringBasedDrawerViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 13/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class SpringBasedDrawerViewController: UIViewController {

    @IBAction func homeButton(_ sender: UIButton) {
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
    }
    
    var dragInView : DragInView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if dragInView == nil {
            let height : CGFloat = 400
            dragInView = DragInView(parent: self, side: .bottom)
            dragInView?.drawerFullHeight(height)
            dragInView?.handleDrawerSize(CGSize(width: 50, height: 20))
            dragInView?.handleViewColor(UIColor.brown)
            dragInView?.drawerMaxCutOffExtent(300)
            dragInView?.visibleHeightWhenClosed(40)
            dragInView?.visibleHeightWhenOpened(height - 50)
            dragInView?.backgroundColor = UIColor.white
            
            dragInView?.setupConstraints(onParent: self)
            dragInView?.setupGestures()
            self.view.addSubview( dragInView!)
        }
        
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
        dragInView = nil
    }
    
    deinit {
        clearAll()
        print("Spring Based Drawer view controller is \(#function)")
    }

}
