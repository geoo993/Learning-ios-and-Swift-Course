//
//  CAEmitterCell+Ext.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 17/07/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import Foundation

extension CAEmitterCell {
    
    public static func explosionEmitter(birthRate:Float, texture:UIImage, color:UIColor) -> CAEmitterCell
    {
        //3
        let emitterCell = CAEmitterCell()
        
        emitterCell.color = color.cgColor
        
        //4
        emitterCell.contents = texture.cgImage
        
        //5
        emitterCell.name = "explosioncell"
        
        //6
        emitterCell.birthRate = birthRate//1000
        emitterCell.lifetime = 0.75 // 2
        emitterCell.lifetimeRange = 0
        
        //7
        emitterCell.redRange = 0.53
        emitterCell.redSpeed = -0.53 
        emitterCell.greenRange = 0.63
        emitterCell.greenSpeed = -0.63 
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
        emitterCell.spinRange = 0.4
        
        //13
        emitterCell.speed = 1
        
        //14
        emitterCell.emissionRange = CGFloat(Double.pi*2)
        
        return emitterCell
    }
    
    public static func fireworkEmitter(birthRate:Float, texture:UIImage, color:UIColor) -> CAEmitterCell
    {
        //3
        let emitterCell = CAEmitterCell()
        
        emitterCell.color = color.cgColor
        
        //4
        emitterCell.contents = texture.cgImage
        
        //5
        emitterCell.name = "fireworkcell"
        
        //6
        emitterCell.birthRate = birthRate
        emitterCell.lifetime = 0.7 
        emitterCell.lifetimeRange = 0
        
        //7
        emitterCell.redRange = 0.53
        emitterCell.redSpeed = -0.53 
        emitterCell.greenRange = 0.63
        emitterCell.greenSpeed = -0.63 
        emitterCell.blueRange = 0.33
        emitterCell.blueSpeed = -0.33 
        
        //8
        emitterCell.xAcceleration = 0
        emitterCell.yAcceleration = 500
        
        //9
        emitterCell.alphaRange = 0.5
        emitterCell.alphaSpeed = -0.8
        
        //10
        emitterCell.velocity = 220
        emitterCell.velocityRange = 50
        
        //11
        emitterCell.scale = 0.4
        emitterCell.scaleRange = 0.6
        emitterCell.scaleSpeed = -0.3
        
        //12
        emitterCell.spin = 0.0
        emitterCell.spinRange = 359.4
        
        //13
        emitterCell.speed = 1.0
        
        //14
        emitterCell.emissionLongitude = CGFloat.pi
        emitterCell.emissionRange = CGFloat(Double.pi*2)
        
        return emitterCell
    }
    
    public static func simpleEmitter(birthRate:Float, texture:UIImage, color:UIColor) -> CAEmitterCell
    {
        //3
        let emitterCell = CAEmitterCell()
        
        emitterCell.color = color.cgColor
        
        //4
        emitterCell.contents = texture.cgImage
        
        //5
        emitterCell.name = "cell"
        
        //6
        emitterCell.birthRate = birthRate
        emitterCell.lifetime = Float.infinity 
        emitterCell.lifetimeRange = 0
        
        //7
        emitterCell.redRange = 0.53
        emitterCell.redSpeed = -0.53 
        emitterCell.greenRange = 0.63
        emitterCell.greenSpeed = -0.63 
        emitterCell.blueRange = 0.43
        emitterCell.blueSpeed = -0.43 
        
        //8
        emitterCell.xAcceleration = 0
        emitterCell.yAcceleration = 0
        
        //9
        emitterCell.alphaRange = 0.5
        emitterCell.alphaSpeed = -0.8
        
        //10
        emitterCell.velocity = 200
        emitterCell.velocityRange = 50
        
        //11
        emitterCell.scale = 0.4
        emitterCell.scaleRange = 0.5
        emitterCell.scaleSpeed = -0.05
        
        //12
        emitterCell.spin = 2.0
        emitterCell.spinRange = 3
        
        //13
        emitterCell.speed = 1.0
        
        //14
        emitterCell.emissionLongitude = CGFloat.pi
        //emitterCell.emissionRange = CGFloat.pi / 4  //one angle
        emitterCell.emissionRange = CGFloat(Double.pi*2) //all angles
        
        
        return emitterCell
    }
    
    public static func snowEmitter(birthRate:Float, texture:UIImage, color:UIColor) -> CAEmitterCell
    {
        //3
        let emitterCell = CAEmitterCell()
        
        emitterCell.color = color.cgColor
        
        //4
        emitterCell.contents = texture.cgImage
        
        //5
        emitterCell.name = "snowcell"
        
        //6
        emitterCell.birthRate = birthRate
        emitterCell.lifetime = 60
        emitterCell.lifetimeRange = 20 // can go up to 80 or 40
        
        //7
        emitterCell.redRange = 0.93
        emitterCell.redSpeed = -0.03 
        emitterCell.greenRange = 0.93
        emitterCell.greenSpeed = -0.03 
        emitterCell.blueRange = 0.93
        emitterCell.blueSpeed = -0.03 
        
        //8
        emitterCell.xAcceleration = 0
        emitterCell.yAcceleration = 0
        
        //9
        emitterCell.alphaRange = 1.0
        emitterCell.alphaSpeed = -0.4
        
        //10
        emitterCell.velocity = 200
        emitterCell.velocityRange = 10  // can go up to 190 or 210
        
        //11
        emitterCell.scale = 0.6
        emitterCell.scaleRange = 0.2  // can go up to 0.4 or 0.8
        emitterCell.scaleSpeed = -0.05
        
        //12
        emitterCell.spin = 1.4
        emitterCell.spinRange = 0.5  // can go up to 1.9 or 0.9
        
        //13
        emitterCell.speed = 0.2
        
        //14
        emitterCell.emissionLongitude = CGFloat(180 * (CGFloat.pi / 180) )
        emitterCell.emissionRange = CGFloat(45) * CGFloat(Double.pi / 180) 
        
        
        return emitterCell
    }
    
    public static func rainEmitter(birthRate:Float, texture:UIImage, color:UIColor) -> CAEmitterCell
    {
        //3
        let emitterCell = CAEmitterCell()
        
        emitterCell.color = color.cgColor
        
        //4
        emitterCell.contents = texture.cgImage
        
        //5
        emitterCell.name = "raincell"
        
        //6
        emitterCell.birthRate = birthRate
        emitterCell.lifetime = 60
        emitterCell.lifetimeRange = 20 // can go up to 80 or 40
        
        //7
        emitterCell.redRange = 0.83
        emitterCell.redSpeed = -0.03 
        emitterCell.greenRange = 0.83
        emitterCell.greenSpeed = -0.03 
        emitterCell.blueRange = 0.83
        emitterCell.blueSpeed = -0.03 
        
        //8
        emitterCell.xAcceleration = 0
        emitterCell.yAcceleration = 0
        
        //9
        emitterCell.alphaRange = 1.0 
        emitterCell.alphaSpeed = -0.2
        
        //10
        emitterCell.velocity = 400
        emitterCell.velocityRange = 25  // can go up to 375 or 425
        
        //11
        emitterCell.scale = 0.8
        emitterCell.scaleRange = 0.5 // can go up to 1.3 or 0.3
        emitterCell.scaleSpeed = -0.08
        
        //12
        emitterCell.spin = 1.0
        emitterCell.spinRange = 0.2 // can go up to 1.2 or 0.8
        
        //13
        emitterCell.speed = 1.0
        
        //14
        emitterCell.emissionLongitude = CGFloat(180 * (CGFloat.pi / 180) )
        emitterCell.emissionRange = CGFloat(5) * CGFloat(Double.pi / 180) 
        
        
        return emitterCell
    }
    
}
