//
//  ParticleEmitterView.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 17/07/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class ParticleEmitterView: UIView {

    enum ParticleType {
        case explosion
        case firework
        case simple
        case snow
        case rain
    }
    fileprivate var particleType : ParticleType
    fileprivate var shouldEnd = false
    
    //1
    fileprivate var emitter:CAEmitterLayer!
    fileprivate var particleTextures : [UIImage] = [#imageLiteral(resourceName: "starparticle"),#imageLiteral(resourceName: "circlestar"),#imageLiteral(resourceName: "fullstar"),#imageLiteral(resourceName: "sparklingstar"),#imageLiteral(resourceName: "brightstar"),#imageLiteral(resourceName: "circleParticle")]
    
    required public init?(coder aDecoder:NSCoder) {
        particleType = .explosion
        super.init(coder: aDecoder)
        setupEmitter()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupEmitter()
    }
    
    override init(frame:CGRect) {
        particleType = .explosion
        super.init(frame:frame)
        setupEmitter()
    }
    
    init(frame:CGRect, type: ParticleType) {
        particleType = type
        super.init(frame:frame)
        setupEmitter()
    }
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //2 configure the UIView to have an emitter layer
    override public class var layerClass : AnyClass {
        return CAEmitterLayer.self
    }
    
    override public func didMoveToSuperview() {
        
        super.didMoveToSuperview()
        if self.superview == nil {
            return
        }
        let index = Int.random(min: 0, max: 4)
        simulateParticle(with: index)
    }
    
    func setupEmitter(){
        //initialize the emitter
        emitter = self.layer as! CAEmitterLayer
        emitter.emitterPosition = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
        emitter.emitterSize = self.bounds.size
        emitter.emitterMode = kCAEmitterLayerAdditive
        
        switch particleType {
        case .explosion:
            emitter.emitterShape = kCAEmitterLayerRectangle
        case .firework:
            emitter.emitterShape = kCAEmitterLayerRectangle
        case .simple:
            emitter.emitterShape = kCAEmitterLayerRectangle
        case .snow:
            emitter.emitterShape = kCAEmitterLayerLine
        case .rain:
            emitter.emitterShape = kCAEmitterLayerLine
        }
    }
    
    func simulateParticle(with index: Int){
        
        //2
        let texture:UIImage? = particleTextures[index]
        assert(texture != nil, "particle image not found")
        
        //3
        let explosionCell = CAEmitterCell.explosionEmitter(birthRate: 200,texture: texture!, color: UIColor.random)
        
        let fireworkCell = CAEmitterCell.fireworkEmitter(birthRate: 400,texture: texture!, color: UIColor.random)
        
        let red = CAEmitterCell.simpleEmitter(birthRate: 10,texture: texture!, color: UIColor.red)
        let green = CAEmitterCell.simpleEmitter(birthRate: 10,texture: texture!, color: UIColor.green)
        let blue = CAEmitterCell.simpleEmitter(birthRate: 10,texture: texture!, color: UIColor.blue)
        
        let snowCell = CAEmitterCell.snowEmitter(birthRate: 50,texture: texture!, color: UIColor.white)
        
        let rainCell = CAEmitterCell.rainEmitter(birthRate: 50,texture: texture!, color: UIColor.random)
        //11
        switch particleType {
        case .explosion:
            emitter.emitterCells = [explosionCell]
            shouldEnd = true
        case .firework:
            emitter.emitterCells = [fireworkCell]
            shouldEnd = true
        case .simple:
            emitter.emitterCells = [red,green,blue]
            shouldEnd = false
        case .snow:
            emitter.emitterCells = [snowCell]
            shouldEnd = false
        case .rain:
            emitter.emitterCells = [rainCell]
            shouldEnd = false
        }
        
        //disable the emitter
        var delay = Int64(0.1 * Double(NSEC_PER_SEC))
        var delayTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            self.disableEmitterCell()
        }
        
        if shouldEnd {
            //remove explosion view
            delay = Int64(2 * Double(NSEC_PER_SEC))
            delayTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) {
                self.removeFromSuperview()
            }
        }
    }
    
    func disableEmitterCell() {
        emitter.setValue(0, forKeyPath: "emitterCells.cell.birthRate")
    }

}
