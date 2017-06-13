//
//  DraggableTopMenuMainViewControllerViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 12/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class DraggableTopMenuMainViewControllerViewController: UIViewController {

    @IBOutlet weak var draggableView : DraggableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadDraggableView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func loadDraggableView(){
        self.view.addSubview(draggableView)
        
        let heightToSee : CGFloat = 50
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height * 0.96
        let frame = CGRect(x: 0, y: -height + heightToSee, width: width, height: height)
        
        draggableView.frame = frame
        draggableView.heightToSee = heightToSee
        draggableView.maxHeight = height
        draggableView.superViewHeight = self.view.bounds.size.height
        draggableView.setup()
        draggableView.backgroundImageView.blurImage()
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
