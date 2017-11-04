//
//  ViewController.swift
//  HomePage
//
//  Created by GEORGE QUENTIN on 16/10/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import UIKit
import LearningSwiftCourseExtensions

public class ZigZagScrollViewHomeViewController: UIViewController {

    @IBOutlet weak var scrollView: ZIgZagScrollView!

    func animateBackgroundColor( )
    {
        var colorTransSwitch : String = ""
        var colorTransNum : CGFloat = 0
        var curveValue : CGFloat = 0
        
        var startColor : UIColor = .random
        var endColor : UIColor = .random
        var deltaTime = 0
        
        let gameLoop = GameLoop()
        gameLoop.framesPerInterval = 30
        gameLoop.doSomething = { [weak self] () -> () in
            deltaTime += 1
          
            if(colorTransSwitch == "goingUp")
            {
                colorTransNum += 1;
            }
            if(colorTransSwitch == "goingDown")
            {
                colorTransNum -= 1;
            }
            
            if(curveValue <= 0)
            {
                colorTransSwitch = "goingUp";
                endColor = .random;
            }
            if(curveValue >= 1)
            {
                startColor = .random;
                colorTransSwitch = "goingDown"
            }
            
            curveValue = CGFloat(colorTransNum / 255.0)
            let color = UIColor.interpolate(from: startColor, to: endColor,with: curveValue)
            print(deltaTime, curveValue, colorTransNum,  colorTransSwitch)
        
           self?.view.backgroundColor = color
        }
        gameLoop.start()
        
    }



    public override func viewDidLoad() {
        super.viewDidLoad()
        animateBackgroundColor()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupTapGesture()
    }
   
    func setupTapGesture(){
        // Add tap to open
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture))
        tapRecognizer.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(tapRecognizer)
        
    }
    
    @objc func handleTapGesture(_ tapGestureRecognizer: UITapGestureRecognizer) {
        
        scrollView.addViewToZigZag(at: scrollView.controlPoints.count, with: scrollView.controlPoints.count)
        scrollView.setupBezierView()
    }
    
}


