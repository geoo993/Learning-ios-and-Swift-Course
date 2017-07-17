//
//  AudioController.swift
//  Anagrams
//
//  Created by Caroline Begbie on 12/04/2015.
//  Copyright (c) 2015 Caroline. All rights reserved.
//

import Foundation
import AVFoundation

public class AudioController {
    fileprivate var audio = [String:AVAudioPlayer]()

    func preloadAudioEffects(_ effectFileNames:[String]) {
        for effect in AnagramsSet.AudioEffectFiles {
          //1 get the file path URL
         
            if let soundPath = Bundle.main.resourcePath {
                //.appendingPathComponent("Owl.jpg") 
                //.stringByAppendingPathComponent(effect)
              let soundURL = URL(fileURLWithPath: soundPath).appendingPathComponent(effect)
                
                
              //2 load the file contents
              //var loadError:NSError?
                if let player = try? AVAudioPlayer(contentsOf: soundURL) { 
                    // (contentsOfURL: soundURL, error: &loadError)
                  //assert(loadError == nil, "Load sound failed")
                  
                  //3 prepare the play
                  player.numberOfLoops = 0
                  player.prepareToPlay()
                  
                  //4 add to the audio dictionary
                  audio[effect] = player
                }else{
                    print("sound file url error")
                }
            }else{
                print("resource file error")
            }
            
            
        }
    }

    func playEffect(_ name:String) {
        if let player = audio[name] {
          if player.isPlaying {
            player.currentTime = 0
          } else {
            player.play()
          }
        }
    }
  
}

