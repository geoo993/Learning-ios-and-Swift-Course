//
//  GameController.swift
//  Anagrams
//
//  Created by Caroline Begbie on 12/04/2015.
//  Copyright (c) 2015 Caroline. All rights reserved.
//

import Foundation
import UIKit

public class GameController {
  var gameView: UIView!
  var level: Level!
  
  fileprivate var tiles = [TileView]()
  fileprivate var targets = [TargetView]()
  
  var hud:HUDView! {
    didSet {
      //connect the Hint button
      hud.hintButton.addTarget(self, action: #selector(GameController.actionHint), for:.touchUpInside)
      hud.hintButton.isEnabled = false
    }
  }
  
  //stopwatch variables
  fileprivate var secondsLeft: Int = 0
  fileprivate var timer: Timer?
  
  fileprivate var data = GameData()
  
  fileprivate var audioController: AudioController
  
    fileprivate var xOffset : CGFloat = 0
    
    fileprivate var tileSize : CGFloat = 0
    
  var onAnagramSolved:( () -> ())!
  
  init() {
    self.audioController = AudioController()
    self.audioController.preloadAudioEffects(AnagramsSet.AudioEffectFiles)
  }
  
    
  func dealRandomAnagram () {
    //1
    assert(level.anagrams.count > 0, "no level loaded")
    
    //2
    let randomIndex = Int.random(min:0, max: level.anagrams.count-1 )
    let anagramPair = level.anagrams[randomIndex]
    
    //3
    let anagram1 = anagramPair[0] as! String
    let anagram2 = anagramPair[1] as! String
    
    //4
    let anagram1length = anagram1.characters.count
    let anagram2length = anagram2.characters.count
    
    //5
    print("phrase1[\(anagram1length)]: \(anagram1)")
    print("phrase2[\(anagram2length)]: \(anagram2)")
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    //calculate the tile size
    tileSize = ceil(screenWidth * 0.9 / CGFloat(max(anagram1length, anagram2length))) - AnagramsSet.TileMargin
    
    //get the left margin for first tile
    xOffset = (screenWidth - CGFloat(max(anagram1length, anagram2length)) * (tileSize + AnagramsSet.TileMargin)) / 2.0
    
    //adjust for tile center (instead of the tile's origin)
    xOffset += tileSize / 2.0
    
    //initialize target list
    targets = []
    
    //create targets
    //for (index) in 0..<anagram2.characters.indices //enumerate(anagram2) {
    for index in 0..<anagram2.characters.count 
    {
        let letter = anagram2[index]
          if letter != " " {
            let target = TargetView(letter: letter, sideLength: tileSize)
            target.center = CGPoint(x:xOffset + CGFloat(index)*(tileSize + AnagramsSet.TileMargin), y: screenHeight/4)
            
            gameView.addSubview(target)
            targets.append(target)
          }
    }
    
    //1 initialize tile list
    tiles = []
    
    //2 create tiles
    for index in 0..<anagram1.characters.count {
        let letter = anagram1[index]
      //3
      if letter != " " {
        let tile = TileView(letter: letter, sideLength: tileSize)
        tile.center = CGPoint(x: xOffset + CGFloat(index)*(tileSize + AnagramsSet.TileMargin), y: screenHeight/4*3)
        
        tile.randomize()
        tile.dragDelegate = self
        
        //4
        gameView.addSubview(tile)
        tiles.append(tile)
      }
    }
    
    //start the timer
    self.startStopwatch()
    
    hud.hintButton.isEnabled = true
    
  }
    
    func updateTilesAndTargetsPosition (){
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        if 
            let firstTileX = tiles.first?.frame.origin.x
        {
            let updateX = (firstTileX < screenWidth * 0.05)
            
            for tile in tiles {
                let x = updateX ? tile.center.x + xOffset : tile.center.x
                tile.center = CGPoint(x: x, y: screenHeight/4*3)
            }
            
            for target in targets {
                let x = updateX ? target.center.x + xOffset : target.center.x
                target.center = CGPoint(x: x , y: screenHeight/4)
            }
        }
    }
    func placeTile(_ tileView: TileView, targetView: TargetView) {
        //1
        targetView.isMatched = true
        tileView.isMatched = true

        //2
        tileView.isUserInteractionEnabled = false

        //3
        UIView.animate(withDuration: 0.35,
          delay:0.00,
          options:UIViewAnimationOptions.curveEaseOut,
          //4
          animations: {
            tileView.center = targetView.center
            tileView.transform = CGAffineTransform.identity
          },
          //5
          completion: {
            (value:Bool) in
            targetView.isHidden = true
        })

        let explode = ExplodeView(frame:CGRect(x: tileView.center.x, y: tileView.center.y, width: 10,height: 10))
        tileView.superview?.addSubview(explode)
        tileView.superview?.sendSubview(toBack: explode)
    }
  
  
  
  func checkForSuccess() {
    for targetView in targets {
      //no success, bail out
      if !targetView.isMatched {
        return
      }
    }
    print("Game Over!")
    
    hud.hintButton.isEnabled = false
    
    //stop the stopwatch
    self.stopStopwatch()
    
    //the anagram is completed!
    audioController.playEffect(AnagramsSet.SoundWin)
    
    let screenWidth = UIScreen.main.bounds.size.width
    // win animation
    let firstTarget = targets[0]
    let startX:CGFloat = 0
    let endX:CGFloat = screenWidth + 300
    let startY = firstTarget.center.y
    
    let stars = StardustView(frame: CGRect(x: startX, y: startY, width: 10, height: 10))
    gameView.addSubview(stars)
    gameView.sendSubview(toBack: stars)
    
    UIView.animate(withDuration: 3.0,
      delay:0.0,
      options:UIViewAnimationOptions.curveEaseOut,
      animations:{
        stars.center = CGPoint(x: endX, y: startY)
      }, completion: {(value:Bool) in
        //game finished
        stars.removeFromSuperview()

        //when animation is finished, show menu
        self.clearBoard()
        self.onAnagramSolved()
    })
  }

  func startStopwatch() {
    //initialize the timer HUD
    secondsLeft = level.timeToSolve
    hud.stopwatch.setSeconds(secondsLeft)
    
    //schedule a new timer
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(GameController.tick(_:)), userInfo: nil, repeats: true)
  }
  
  func stopStopwatch() {
    timer?.invalidate()
    timer = nil
  }
  
  @objc func tick(_ timer: Timer) {
    secondsLeft -= 1
    hud.stopwatch.setSeconds(secondsLeft)
    if secondsLeft == 0 {
      self.stopStopwatch()
    }
  }
  
  //the user pressed the hint button
  @objc func actionHint() {
    //1
    hud.hintButton.isEnabled = false
    
    //2
    data.points -= level.pointsPerTile / 2
    hud.gamePoints.setValue(data.points, duration: 1.5)
    
    //3 find the first unmatched target and matching tile
    var foundTarget:TargetView? = nil
    for target in targets {
      if !target.isMatched {
        foundTarget = target
        break
      }
    }
    
    //4 find the first tile matching the target
    var foundTile:TileView? = nil
    for tile in tiles {
      if !tile.isMatched && tile.letter == foundTarget?.letter {
        foundTile = tile
        break
      }
    }
    
    //ensure there is a matching tile and target
    if let target = foundTarget, let tile = foundTile {
      
      //5 don't want the tile sliding under other tiles
      gameView.bringSubview(toFront: tile)
      
      //6 show the animation to the user
      UIView.animate(withDuration: 1.5,
        delay:0.0,
        options:UIViewAnimationOptions.curveEaseOut,
        animations:{
          tile.center = target.center
        }, completion: {
          (value:Bool) in
          
          //7 adjust view on spot
          self.placeTile(tile, targetView: target)
          
          //8 re-enable the button
          self.hud.hintButton.isEnabled = true
          
          //9 check for finished game
          self.checkForSuccess()
          
      })
    }
  }
  
  //clear the tiles and targets
  func clearBoard() {
    tiles.removeAll(keepingCapacity: false)
    targets.removeAll(keepingCapacity: false)
    
    for view in gameView.subviews  {
      view.removeFromSuperview()
    }
  }
  
}

extension GameController:TileDragDelegateProtocol {
  //a tile was dragged, check if matches a target
  func tileView(_ tileView: TileView, didDragToPoint point: CGPoint) {
    var targetView: TargetView?
    for tv in targets {
      if tv.frame.contains(point) && !tv.isMatched {
        targetView = tv
        break
      }
    }
    
    //1 check if target was found
    if let targetView = targetView {
      
      //2 check if letter matches
      if targetView.letter == tileView.letter {
        
        //3
        self.placeTile(tileView, targetView: targetView)

        //more stuff to do on success here
        
        audioController.playEffect(AnagramsSet.SoundDing)
        
        //give points
        data.points += level.pointsPerTile
        hud.gamePoints.setValue(data.points, duration: 0.5)
        
        //check for finished game
        self.checkForSuccess()
      
      } else {
        
        //4
        //1
        tileView.randomize()
        
        //2
        UIView.animate(withDuration:0.35,
          delay:0.00,
          options:UIViewAnimationOptions.curveEaseOut,
          animations: {
            tileView.center = CGPoint(x: tileView.center.x + CGFloat(CGFloat.randomF(min:0, max:40) - 20) ,
              y: tileView.center.y + CGFloat.randomF(min:20, max:30) )
          },
          completion: nil)
        
        //more stuff to do on failure here
        
        audioController.playEffect(AnagramsSet.SoundWrong)
        
        //take out points
        data.points -= level.pointsPerTile/2
        hud.gamePoints.setValue(data.points, duration: 0.25)
      }
    }
    
  }
  

}
