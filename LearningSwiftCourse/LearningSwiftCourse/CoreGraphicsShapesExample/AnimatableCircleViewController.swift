//
//  AnimatableCircleViewController.swift
//  CoreGraphicsShapes
//
//  Created by GEORGE QUENTIN on 05/09/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import UIKit

class AnimatableCircleViewController: UIViewController {

    
    @IBOutlet weak var animatableCircle: AnimatableCircleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //addAnimatableCircleView()
        
        animatableCircle.animate(duration: 2.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addAnimatableCircleView() {
        let circleWidth : CGFloat = CGFloat(200)
        let circleHeight : CGFloat = circleWidth
        
        // Create a new CircleView
        let circleView = AnimatableCircleView(frame: CGRect(x: 50, y: 100, width: circleWidth, height: circleHeight))
        circleView.center = view.center
            
        view.addSubview(circleView)
        
        // Animate the drawing of the circle over the course of 1 second
        circleView.animate(duration: 2.0)
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
