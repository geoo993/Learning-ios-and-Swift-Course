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


import UIKit

public class ParticleEmittersViewController: UIViewController {

    @IBAction func homebutton(_ sender: UIButton) {
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
    }
    
    @IBOutlet weak var simulateParticles : UIButton!
    @IBAction func simulateParticlesAction(_ sender: UIButton) {
        runParticle()
    }
    
    func runParticle(){
        let particlesView = ParticleEmitterView(frame:CGRect(x: view.center.x, y: view.center.y, width: 10,height: 10))
        view.addSubview(particlesView)
        view.sendSubview(toBack: particlesView)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        runParticle()
        
        // Do any additional setup after loading the view.
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
