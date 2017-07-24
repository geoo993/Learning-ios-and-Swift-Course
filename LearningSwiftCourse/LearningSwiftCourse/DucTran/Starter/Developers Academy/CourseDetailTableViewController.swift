//
//  CourseDetailTableViewController.swift
//  HamburgerMenu
//
//  Created by Duc Tran on 12/24/15.
//  Copyright © 2015 Developers Academy. All rights reserved.
//

// Since in this class, we use a static table view, we don't have to implement data source methods

import UIKit
import SafariServices   // for SFSafariViewController
import AVKit
import AVFoundation

class CourseDetailTableViewController: UITableViewController
{
    var course: Course! // data source
    
    @IBOutlet weak var programTextLabel: UILabel!
    @IBOutlet weak var courseImageView: UIImageView!
    @IBOutlet weak var courseTitleTextLabel: UILabel!
    @IBOutlet weak var courseDescriptionTextLabel: UILabel!
    @IBOutlet weak var watchProgramVideoButton: UIButton!
    @IBOutlet weak var enrollInProgramButton: UIButton!
    @IBOutlet weak var enrollBarButtonItem: UIBarButtonItem!
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Course Info"
        
        self.navigationItem.rightBarButtonItem = enrollBarButtonItem
        
        self.updateUI()
    }
    
    fileprivate func updateUI()
    {
        self.programTextLabel.text = course.program
        self.courseImageView.image = course.image
        self.courseTitleTextLabel.text = course.title
        self.courseDescriptionTextLabel.text = course.description
        self.watchProgramVideoButton.setTitle("Watch \(course.program) video", for: UIControlState())
        self.enrollInProgramButton.setTitle("Enroll in \(course.program)", for: UIControlState())
    }
    
    // MARK: - Target / Action
    
    @IBAction func enrollDidClick(_ sender: AnyObject)
    {
        self.showWebsite(course.programURL)
    }
    
    // import AVKit, AVFoundation
    // ** Play Videos Locally and Externally in iOS
    
    @IBAction func watchVideoDidClick(_ sender: AnyObject)
    {
        //playLocalVideo()
        playExternalVideo()
    }
    
    func playLocalVideo()
    {
//        if let moviePath = Bundle.main.path(forResource: "walkthroughs", ofType: "mov") {
//                let movieURL = URL(fileURLWithPath: moviePath)
//            
//                let player = AVPlayer(url: movieURL)
//                let playerLayer = AVPlayerLayer()
//            
//                playerLayer.player = player
//                playerLayer.frame = self.imgV.bounds
//                playerLayer.backgroundColor = UIColor.clear.cgColor
//                playerLayer.videoGravity = AVLayerVideoGravityResizeAspect
//                self.imgV.layer.addSublayer(playerLayer)
//                player.play()
//            
//        }
//        
        let moviePath = Bundle.main.path(forResource: "walkthroughs", ofType: "mov")
        if let path = moviePath{
            let url = NSURL.fileURL(withPath: path)
            
            //let item = AVPlayerItem(url: url)
            //let player = AVPlayer(playerItem: item)
            let player = AVPlayer(url: url)
            let playerViewController = AVPlayerViewController()
            
            playerViewController.player = player
            self.present(playerViewController, animated: true, completion: { 
                playerViewController.player?.play()
            })
//            avpController.view.frame = videoPreviewLayer.frame
//            self.addChildViewController(avpController)
//            self.view.addSubview(avpController.view)
            
            
            
            
        }
        
    }
    
    let videoURL = "https://s3.eu-west-2.amazonaws.com/inspirationalfilmsscenes/TheWordsParkIntro.mp4"
    
    func playExternalVideo()
    {
        let url = URL(string: videoURL)
        
        let player = AVPlayer(url: url! )
        let playerViewController = AVPlayerViewController()
        
        playerViewController.player = player
        self.present(playerViewController, animated: true, completion: { 
            playerViewController.player?.play()
        })
    }
    
    // ** Play Videos Locally and Externally in iOS


    @IBAction func shareWithFriends(_ sender: AnyObject)
    {
        showActivityController()
    }
    
    func showActivityController()
    {
        if let image = course.image {
            let imagesToShare = [image]
            let activityController = UIActivityViewController(activityItems: imagesToShare, applicationActivities: nil)
            
            // optional
            let excludedActivities = [UIActivityType.postToFlickr, UIActivityType.postToWeibo, UIActivityType.message, UIActivityType.mail, UIActivityType.print, UIActivityType.copyToPasteboard, UIActivityType.assignToContact, UIActivityType.saveToCameraRoll, UIActivityType.addToReadingList, UIActivityType.postToFlickr, UIActivityType.postToVimeo, UIActivityType.postToTencentWeibo]
            activityController.excludedActivityTypes = excludedActivities
            
            
            present(activityController, animated: true, completion: nil)
        }
    }

    
    // MARK: - Show Webpage with SFSafariViewController
    
    func showWebsite(_ URLString: String)
    {
        let webVC = SFSafariViewController(url: URL(string: URLString)!)
        webVC.delegate = self
        
        self.present(webVC, animated: true, completion: nil)
    }
    
    // MARK: - UITableViewDatasource
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        var rowHeight = self.tableView.rowHeight
        
        // in the first section and the first row
        if indexPath.section == 0 && indexPath.row == 0 {
            rowHeight = UITableViewAutomaticDimension
        }
        
        return rowHeight
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}

extension CourseDetailTableViewController : SFSafariViewControllerDelegate
{
    func safariViewControllerDidFinish(_ controller: SFSafariViewController)
    {
        controller.dismiss(animated: true, completion: nil)
    }
}


















