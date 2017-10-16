//
//  ProgressView.swift
//  HomePage
//
//  Created by GEORGE QUENTIN on 16/10/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//
// https://www.ioscreator.com/tutorials/dragging-views-gestures-tutorial-ios8-swift
// https://www.ioscreator.com/tutorials/dragging-views-gestures-tutorial-ios10


import UIKit

public class JourneyView: UIButton {

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    func setup(){
        //randomize view color
        let blueValue = CGFloat.randomF(min: 0.0, max: 1.0)
        let greenValue = CGFloat.randomF(min: 0, max: 1.0)
        let redValue = CGFloat.randomF(min: 0, max: 1.0)
        
        self.backgroundColor = UIColor(red:redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        
        self.isUserInteractionEnabled = true
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.width * 0.5
    }
    
    func setupTapGesture( target: Any?, tapSelector : Selector){
        
        // Tap gesture
        let tapRecognizer = UITapGestureRecognizer(target: target, action: tapSelector)
        tapRecognizer.numberOfTapsRequired = 1
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapRecognizer)
        
    }
    
    func setupPanGesture( target: Any?, panSelector : Selector){

        // Pan gesture
        let panRecognizer = UIPanGestureRecognizer(target: target, action: panSelector)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(panRecognizer)
    }
    
   
    /*
    @objc func handlePanGesture(_ panGestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = panGestureRecognizer.translation(in: self.superview!)
        self.center = CGPoint(x:center.x + translation.x, y:center.y + translation.y)
        panGestureRecognizer.setTranslation(CGPoint.zero, in: self.superview!)
     
        /*
        switch panGestureRecognizer.state {
        case .began:
            break
        case .changed:
            break
        case .ended:
            break
        default:
            break
        }
        */
    
    }
    */
    
    
}
