//
//  TileView.swift
//  Anagrams
//
//  Created by Caroline Begbie on 12/04/2015.
//  Copyright (c) 2015 Caroline. All rights reserved.
//

import Foundation
import UIKit
import LearningSwiftCourseExtensions

protocol TileDragDelegateProtocol {
  func tileView(_ tileView: TileView, didDragToPoint: CGPoint)
}

//1
public class TileView:UIImageView {
  //2
  var letter: Character
  
  //3
  var isMatched: Bool = false
  
  fileprivate var xOffset: CGFloat = 0.0
  fileprivate var yOffset: CGFloat = 0.0
  
  var dragDelegate: TileDragDelegateProtocol?
  
  fileprivate var tempTransform: CGAffineTransform = CGAffineTransform.identity
  
  //4 this should never be called
    required public init?(coder aDecoder:NSCoder) {
        self.letter = Character("")
        super.init(coder: aDecoder)
    }
  
  //5 create a new tile for a given letter
  init(letter:Character, sideLength:CGFloat) {
    self.letter = letter
    
    //the tile background
    let image = UIImage(named: "tile")!
    
    //superclass initializer
    //references to superview's "self" must take place after super.init
    super.init(image:image)
    
    //6 resize the tile
    let scale = sideLength / image.size.width
    self.frame = CGRect(x: 0, y: 0, width: image.size.width * scale, height: image.size.height * scale)
    
    //add a letter on top
    let letterLabel = UILabel(frame: self.bounds)
    letterLabel.textAlignment = NSTextAlignment.center
    letterLabel.textColor = UIColor.white
    letterLabel.backgroundColor = UIColor.clear
    letterLabel.text = String(letter).uppercased()
    letterLabel.font = UIFont(name: "Verdana-Bold", size: 78.0*scale)
    self.addSubview(letterLabel)
    
    self.isUserInteractionEnabled = true
    
    //create the tile shadow
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOpacity = 0
    self.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
    self.layer.shadowRadius = 15.0
    self.layer.masksToBounds = false
    
    let path = UIBezierPath(rect: self.bounds)
    self.layer.shadowPath = path.cgPath
    
  }
  
  func randomize() {
    //1
    //set random rotation of the tile
    //anywhere between -0.2 and 0.3 radians
    let rotation = CGFloat(CGFloat.random(min:0, max:50)) / 100.0 - 0.2
    self.transform = CGAffineTransform(rotationAngle: rotation)
    
    //2
    //move randomly upwards
    let yOffset = CGFloat.random(min: 0, max: 10) - 10
    self.center = CGPoint(x: self.center.x, y: self.center.y + yOffset)
  }
  
    //1
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        if let touch = touches.first {
          let point = touch.location(in: self.superview)
          xOffset = point.x - self.center.x
          yOffset = point.y - self.center.y
          
        }
        //show the drop shadow
        self.layer.shadowOpacity = 0.8
        
        //save the current transform
        tempTransform = self.transform
        //enlarge the tile
        self.transform = self.transform.scaledBy(x: 1.2, y: 1.2)

        self.superview?.bringSubviewToFront(self)
    }
  
    //2
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            let point = touch.location(in: self.superview)
            self.center = CGPoint(x: point.x - xOffset, y: point.y - yOffset)
        }
    }
  
  //3
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        self.touchesMoved(touches, with: event)
        
        //restore the original transform
        self.transform = tempTransform
        
        dragDelegate?.tileView(self, didDragToPoint: self.center)
        self.layer.shadowOpacity = 0.0
    }
    
    //reset the view transform in case drag is cancelled
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.transform = tempTransform
        self.layer.shadowOpacity = 0.0
    }
}
