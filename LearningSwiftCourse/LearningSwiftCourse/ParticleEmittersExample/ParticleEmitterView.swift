//
//  ParticleEmitterView.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 17/07/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class ParticleEmitterView: UIView {

    //1
    fileprivate var emitter:CAEmitterLayer!
    fileprivate var particleTextures : [UIImage] = [#imageLiteral(resourceName: "starparticle"),#imageLiteral(resourceName: "circlestar"),#imageLiteral(resourceName: "fullstar"),#imageLiteral(resourceName: "sparklingstar"),#imageLiteral(resourceName: "brightstar")]
    
    required public init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
        setupEmitter()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupEmitter()
    }
    
    override init(frame:CGRect) {
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
        emitter.emitterShape = kCAEmitterLayerRectangle
    }
    
    func simulateParticle(with index: Int){
        
        //2
        let texture:UIImage? = particleTextures[index]
        assert(texture != nil, "particle image not found")
        
        //3
        let emitterCell = CAEmitterCell.explosionEmitter(amount: 200,texture: texture!, color: UIColor.randomColor())
        
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
