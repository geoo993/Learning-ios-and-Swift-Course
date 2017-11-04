//
//  GameLoop.swift
//  LearningSwiftCourseExtensions
//
//  Created by GEORGE QUENTIN on 03/11/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
// https://gist.github.com/drosenstark/dbdf0f38e2ae22761fc2
// https://stackoverflow.com/questions/24103691/how-to-set-up-game-loop-in-swift

import Foundation
import UIKit

public class GameLoop : NSObject {
    
    fileprivate var displayLink : CADisplayLink!
    public var doSomething: () -> ()
    public var framesPerInterval : Int!
    
    public override init() {
        self.doSomething = { }
        self.framesPerInterval = nil
    }
    
    public init(framesPerInterval: Int, doSomething: @escaping () -> ()) {
        self.doSomething = doSomething
        self.framesPerInterval = framesPerInterval
        super.init()
        //start()
    }
    
    // you could overwrite this too
    @objc func handleTimer() {
        doSomething()
    }
    
    public func start() {
        displayLink = CADisplayLink(target: self, selector: #selector(handleTimer))
        /*
         * If set to zero, the
         * display link will fire at the native cadence of the display hardware.
         * The display link will make a best-effort attempt at issuing callbacks
         * at the requested rate.
         */
        displayLink.preferredFramesPerSecond = framesPerInterval
        displayLink.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
    }
    
    public func stop() {
        displayLink.invalidate()
        displayLink.remove(from: RunLoop.main, forMode: RunLoopMode.commonModes)
        displayLink = nil
    }
    
}
