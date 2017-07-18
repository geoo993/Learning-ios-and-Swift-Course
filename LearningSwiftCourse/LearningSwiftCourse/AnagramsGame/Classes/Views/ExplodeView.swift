//
//  ExplodeView.swift
//  Anagrams
//
//  Created by Caroline Begbie on 12/04/2015.
//  Copyright (c) 2015 Caroline. All rights reserved.
//

import Foundation
import UIKit

public class ExplodeView: UIView {
      //1
      fileprivate var emitter:CAEmitterLayer!
      
    required public init?(coder aDecoder:NSCoder) {
            super.init(coder: aDecoder)
      }
      
      override init(frame:CGRect) {
        super.init(frame:frame)
        
        //initialize the emitter
        emitter = self.layer as! CAEmitterLayer
        emitter.emitterPosition = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
        emitter.emitterSize = self.bounds.size
        emitter.emitterMode = kCAEmitterLayerAdditive
        emitter.emitterShape = kCAEmitterLayerRectangle
      }
      
      //2 configure the UIView to have an emitter layer
    override public class var layerClass : AnyClass {
        return CAEmitterLayer.self
      }
      
    override public func didMoveToSuperview() {
            //1
            super.didMoveToSuperview()
            if self.superview == nil {
              return
            }
            
            //2
            let texture:UIImage? = UIImage(named:"particle")
            assert(texture != nil, "particle image not found")
            
            //3
        
            let emitterCell = CAEmitterCell.explosionEmitter(birthRate: 200,texture: texture!, color: UIColor.yellow)
          
            //11
            emitter.emitterCells = [emitterCell]
            
            //disable the emitter
            var delay = Int64(0.1 * Double(NSEC_PER_SEC))
            var delayTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) {
              self.disableEmitterCell()
            }
            
            //remove explosion view
            delay = Int64(2 * Double(NSEC_PER_SEC))
            delayTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) {
              self.removeFromSuperview()
            }
      }
      
      func disableEmitterCell() {
            emitter.setValue(0, forKeyPath: "emitterCells.cell.birthRate")
      }
  
}
