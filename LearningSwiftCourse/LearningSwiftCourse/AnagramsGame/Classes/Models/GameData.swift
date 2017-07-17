//
//  GameData.swift
//  Anagrams
//
//  Created by Caroline Begbie on 12/04/2015.
//  Copyright (c) 2015 Caroline. All rights reserved.
//

import Foundation

class GameData {
  //store the user's game achievement
  var points:Int = 0 {
    didSet {
      //custom setter - keep the score positive
      points = max(points, 0)
    }
  }
}
