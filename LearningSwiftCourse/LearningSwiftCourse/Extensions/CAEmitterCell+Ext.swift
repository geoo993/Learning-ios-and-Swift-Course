//
//  CAEmitterCell+Ext.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 17/07/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation

extension CAEmitterCell {
    
    public static func explosionEmitter(amount:Float, texture:UIImage, color:UIColor) -> CAEmitterCell
    {
        //3
        let emitterCell = CAEmitterCell()
        
        emitterCell.color = color.cgColor
        
        //4
        emitterCell.contents = texture.cgImage
        
        //5
        emitterCell.name = "cell"
        
        //6
        emitterCell.birthRate = amount//1000
        emitterCell.lifetime = 0.75 // 2
        
        //7
        //emitterCell.speed = 100
        emitterCell.blueRange = 0.33
        emitterCell.blueSpeed = -0.33 
        
        //8
        emitterCell.xAcceleration = 0
        emitterCell.yAcceleration = 0
        
        //9
        emitterCell.alphaRange = 0.2
        emitterCell.alphaSpeed = -0.5
        
        //10
        emitterCell.velocity = 160
        emitterCell.velocityRange = 40
        
        //11
        emitterCell.scale = 0.75
        emitterCell.scaleRange = 0.6
        emitterCell.scaleSpeed = -0.3
        
        //12
        emitterCell.spin = 2.0
        
        //13
        emitterCell.emissionRange = CGFloat(Double.pi*2)
        
        return emitterCell
    }
    
}
