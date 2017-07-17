//
//  ViewController.swift
//  Anagrams
//
//  Created by Caroline on 1/08/2014.
//  Copyright (c) 2014 Caroline. All rights reserved.
//
//https://www.raywenderlich.com/77983/make-letter-word-game-uikit-swift-part-33

import UIKit

class AnagramsViewController: UIViewController {

    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscapeLeft
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return UIInterfaceOrientation.landscapeLeft
    }
    
    fileprivate let controller:GameController
  
    required init?(coder aDecoder: NSCoder) {
        controller = GameController()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Force the device in portrait mode when the view controller gets loaded
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation") 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        //add one layer for all game elements
        let gameView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        self.view.addSubview(gameView)
        controller.gameView = gameView
        
        //add one view for all hud and controls
        let hudView = HUDView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        self.view.addSubview(hudView)
        controller.hud = hudView
        
        controller.onAnagramSolved = self.showLevelMenu
    }
  
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        controller.hud.updateFrames()
        controller.updateTilesAndTargetsPosition()
    }
    
    //show the game menu on app start
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showLevelMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    override var prefersStatusBarHidden : Bool {
        return true
    }

    func showLevelMenu() {
        //1 show the level selector menu
        let alertController = UIAlertController(title: "Choose Difficulty Level",
          message: nil,
          preferredStyle:UIAlertControllerStyle.alert)
        
        //2 set up the menu actions
        let easy = UIAlertAction(title: "Easy-peasy", style:.default,
          handler: {(alert:UIAlertAction!) in
            self.showLevel(1)
        })
        let hard = UIAlertAction(title: "Challenge accepted", style:.default,
          handler: {(alert:UIAlertAction!) in
            self.showLevel(2)
        })
        let hardest = UIAlertAction(title: "I'm totally hard-core", style: .default,
          handler: {(alert:UIAlertAction!) in
            self.showLevel(3)
        })
        
        //3 add the menu actions to the menu
        alertController.addAction(easy)
        alertController.addAction(hard)
        alertController.addAction(hardest)
        
        //4 show the UIAlertController
        self.present(alertController, animated: true, completion: nil)
    }
  
    //5 show the appropriate level selected by the player
    func showLevel(_ levelNumber:Int) {
        controller.level = Level(levelNumber: levelNumber)
        controller.dealRandomAnagram()
    }
  
}

