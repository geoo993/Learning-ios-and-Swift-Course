//
//  Config.swift
//  Anagrams
//
//  Created by Caroline on 1/08/2014.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

import Foundation
import UIKit


public struct AnagramsSet {
    
    //UI Constants
    static let TileMargin: CGFloat = 20.0

    static let FontHUD = UIFont(name:"comic andy", size: CGFloat.overrideHeightSizeF(size: 50.0) )
    static let FontHUDBig = UIFont(name:"comic andy", size: CGFloat.overrideHeightSizeF(size: 100.0) )

    // Sound effects
    static let SoundDing = "ding.mp3"
    static let SoundWrong = "wrong.m4a"
    static let SoundWin = "win.mp3"
    static let AudioEffectFiles = [SoundDing, SoundWrong, SoundWin]

}
