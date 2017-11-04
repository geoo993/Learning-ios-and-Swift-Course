//
//  ParticleEmittersViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 17/07/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//https://www.raywenderlich.com/128745/scene-kit-tutorial-swift-part-5-particle-systems
//http://stefansdevplayground.blogspot.co.uk/2014/12/how-to-implement-space-shooter-with.html
//https://stackoverflow.com/questions/21539029/ios-firework-explosion-using-sprite-kit-particles
//https://www.hackingwithswift.com/example-code/calayer/how-to-emit-particles-using-caemitterlayer
//http://www.techotopia.com/index.php/An_iOS_9_Sprite_Kit_Particle_Emitter_Tutorial
//https://www.youtube.com/watch?v=Cg5GzKsMF7M&feature=share

import UIKit
import LearningSwiftCourseExtensions

public class ParticleEmittersViewController: UIViewController {

    @IBAction func homebutton(_ sender: UIButton) {
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
    }
    
    var particlesView : ParticleEmitterView!
    
    @IBAction func explosionButtonAction(_ sender: UIButton) {
        runParticle(with: ParticleEmitterView.ParticleType.explosion,xPosition: view.center.x,yPosition:view.center.y,width:10)
    }
    
    @IBAction func fireworkButtonAction(_ sender: UIButton) {
        runParticle(with: ParticleEmitterView.ParticleType.firework,xPosition: view.center.x,yPosition:view.center.y - 100,width:10)
    }
    
    @IBAction func particleButtonAction(_ sender: UIButton) {
        runParticle(with: ParticleEmitterView.ParticleType.simple,xPosition: view.center.x,yPosition:view.center.y,width:10)
    }
    
    @IBAction func snowButtonAction(_ sender: UIButton) {
        
        runParticle(with: ParticleEmitterView.ParticleType.snow, xPosition: 0,yPosition:view.center.y - 200,width:view.bounds.width)
    }
    @IBAction func rainButtonAction(_ sender: UIButton) {
        
        runParticle(with: ParticleEmitterView.ParticleType.rain, xPosition: 0,yPosition:view.center.y - 200, width:view.bounds.width)
    }
    
    func runParticle(with type: ParticleEmitterView.ParticleType, xPosition: CGFloat, yPosition: CGFloat, width: CGFloat){
        if particlesView != nil {
            particlesView.removeEverything()
            particlesView.removeFromSuperview()
        }
        
        particlesView = ParticleEmitterView(frame: CGRect(x: xPosition, y: yPosition, width: width,height: 10), type: type)
        view.addSubview(particlesView)
        view.sendSubview(toBack: particlesView)
    }
    
    // background color interpolation
    var colorTransSwitch : String = ""
    var colorTransNum : CGFloat = 0
    var curveValue : CGFloat = 0
    
    var startColor : UIColor = .random
    var endColor : UIColor = .random
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        let gameLoop = GameLoop()
        var deltaTime = 0
        gameLoop.framesPerInterval = 360
        gameLoop.doSomething = { [weak self] () -> () in
            deltaTime += 1
            
            self?.view.backgroundColor = self?.backgroundColorTransition(with : 1)
            
            print()
            print(deltaTime)
        }
        gameLoop.start()
    }
 
    func backgroundColorTransition( with interval: CGFloat) -> UIColor
    {
        
        if(colorTransSwitch == "goingUp")
        {
            colorTransNum += interval;
        }
        if(colorTransSwitch == "goingDown")
        {
            colorTransNum -= interval;
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
        print(curveValue, colorTransNum,  colorTransSwitch)
        
        return color
    }
    
    
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    deinit {
        view.removeEverything()
        print("Particle Emmiters view controller is \(#function)")
    }
}
