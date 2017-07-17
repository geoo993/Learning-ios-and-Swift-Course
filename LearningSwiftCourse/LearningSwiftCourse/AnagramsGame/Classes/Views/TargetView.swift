//
//  TargetView.swift
//  Anagrams
//
//  Created by Caroline Begbie on 12/04/2015.
//  Copyright (c) 2015 Caroline. All rights reserved.
//

import Foundation
import UIKit

public class TargetView: UIImageView {
  var letter: Character
  var isMatched:Bool = false
  
  //this should never be called
    required public init?(coder aDecoder:NSCoder) {
        self.letter = Character("")
        super.init(coder: aDecoder)
    }
  
  init(letter:Character, sideLength:CGFloat) {
    self.letter = letter
    
    let image = UIImage(named: "slot")!
    super.init(image:image)
    
    let scale = sideLength / image.size.width
    self.frame = CGRect(x: 0, y: 0, width: image.size.width * scale, height: image.size.height * scale)
  }
}
