//
//  VideoPlayerViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 23/05/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoPlayerViewController: UIViewController {

    @IBAction func homebutton(_ sender: Any) {
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
    }
    
    let videoURL = "https://s3.eu-west-2.amazonaws.com/inspirationalfilmsscenes/TheWords/TheWords1.mp4"
    let playerViewController = AVPlayerViewController()
    var player: AVPlayer?
    var playerLayer :  AVPlayerLayer?
    var url : URL?
    @IBOutlet weak var videoView: UIView!
    
    @IBAction func playButtonAction(_ sender: UIButton) {
        
        //playLocalVideo()
        //playExternalVideo()
        play()
    }
    
    @IBAction func pauseButtonAction(_ sender: UIButton) {
        pause()
    }
    
    @IBAction func stopButtonAction(_ sender: UIButton) {
        stop()
    }
    
    func useLayer(){
        
        ///part 1
        playerLayer =  AVPlayerLayer(player: player)
        playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLayer?.zPosition = -1
        
        playerLayer?.frame = self.videoView.bounds
        playerLayer?.backgroundColor = UIColor.clear.cgColor
        playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspect
        self.videoView.backgroundColor = UIColor.clear
        //self.videoView.layer.addSublayer(playerLayer!)
        self.videoView.layer.insertSublayer(playerLayer!, at: 0)
    }
    
    func useViewController(){
        
        playerViewController.player = player
        
        ///part 2
        //            self.present(playerViewController, animated: true, completion: { 
        //                playerViewController.player?.play()
        //            })
        
        ///part3
        playerViewController.view.frame = videoView.frame
        self.addChild(playerViewController)
        self.view.addSubview(playerViewController.view)
        
        
    }
    
    func loopObserver(){
        
        /*
         // add observer to watch for video end in order to loop video
         NotificationCenter.default.addObserver(self, selector: #selector(loopVideo), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player)
         
         // if video ends, will restart  
         func playerItemDidReachEnd() {
         player!.seek(to: kCMTimeZero)
         }
         */
        
    }
    
    func playVideo()
    {
       
        self.videoView.alpha = 0.95;
        self.videoView.layer.zPosition = 0;
        
        let defaultBundleID = "co.lexilabs.LearningSwiftCourse"
        let name = "TheWordsParkIntro"
       
        let moviePath = String.getItemPathFromBundle(bundleID: defaultBundleID, itemName: name, type: "mp4")
        
        if let path = moviePath{
            
            url = URL.init(fileURLWithPath: path) 
            
        }else{
            url = URL(string: videoURL)
            
        }
        
        //let item = AVPlayerItem(url: url)
        //let player = AVPlayer(playerItem: item)
        
        player = AVPlayer(url: url!)
        player?.actionAtItemEnd = .none
        //player?.isMuted = true
        
        
        //useLayer()
        useViewController()
        
        
    }
    
    
    
    // maybe add this loop at the end, after viewDidLoad
     func loopVideo() { 
        player?.seek(to: CMTime.zero) 
        player?.play()
    }
    
    func play() {
        if (player?.currentItem != nil) {
            player?.play()
        }
    }
    
    func pause() {
        player?.pause()
    }
    
    func stop() {
        pause()
        rewind()
    }
    func rewind() {
        player?.seek(to: CMTime(seconds: 0, preferredTimescale: 1))
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playVideo()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        playerViewController.view.frame = self.videoView.frame
        playerLayer?.frame = self.videoView.bounds
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
        print("Video Player view controller is \(#function)")
    }
    
}
