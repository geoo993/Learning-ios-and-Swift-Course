//
//  AudioCheckViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 22/05/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit
import AVFoundation
import RxSwift
import RxCocoa

class AudioCheckViewController: UIViewController {

    
    var audioPlayer : AVAudioPlayer?
    var bgColor = UIColor.red
    
    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var pause: UIButton!
    @IBOutlet weak var restart: UIButton!
    @IBOutlet weak var stop: UIButton!
    
    @IBAction func homebutton(_ sender: Any) {
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
        
    }
    
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgColor = UIColor.randomColor()
        view.backgroundColor = bgColor
        
        if (audioPlayer == nil){
            audioPlayer = AVAudioPlayer()
        }
        
        do {
          
            guard let path = Bundle.main.path(forResource: "brooks", ofType: "mp3") else {
                print("Error: No Audio")
                return
            }
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: path ))
            audioPlayer?.prepareToPlay()
            
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            }catch let error {
                print(error.localizedDescription)
            }
        }
        catch let error {
            print(error.localizedDescription)
        }
        
        play.backgroundColor = bgColor
        play.rx.tap
        .subscribe(onNext: { [weak self] tap in
            guard let this = self else { return }
            this.audioPlayer?.play()
                
        }).addDisposableTo(disposeBag)
        
        pause.backgroundColor = bgColor
        pause.rx.tap
        .subscribe(onNext: { [weak self] tap in
            guard let this = self else { return }
            
            if let isPlaying = (this.audioPlayer?.isPlaying) {
                if isPlaying {
                    this.audioPlayer?.pause()
                }else{
                    
                }
            }
            
        }).addDisposableTo(disposeBag)
        
        restart.backgroundColor = bgColor
        restart.rx.tap
        .subscribe(onNext: { [weak self] tap in
            guard let this = self else { return }
            
            if let isPlaying = (this.audioPlayer?.isPlaying) {
                if isPlaying {
                    //this.audioPlayer.stop()
                    this.audioPlayer?.currentTime = 0
                    this.audioPlayer?.play()
                }else{
                    this.audioPlayer?.play()
                }
            }
        }).addDisposableTo(disposeBag)
        
        stop.backgroundColor = bgColor
        stop.rx.tap
        .subscribe(onNext: { [weak self] tap in
            guard let this = self else { return }
            
            if let isPlaying = (this.audioPlayer?.isPlaying) {
                if isPlaying {
                    this.audioPlayer?.stop()
                    this.audioPlayer?.currentTime = 0
                }else{
                    this.audioPlayer?.currentTime = 0
                }
            }
        }).addDisposableTo(disposeBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if audioPlayer != nil {
            audioPlayer?.stop()
            audioPlayer = nil
        }
    }

    
    deinit {
        print("Audio view controller is \(#function)")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
