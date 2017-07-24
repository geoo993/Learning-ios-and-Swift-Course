//
//  WalkthroughViewController.swift
//  TouchID
//
//  Created by Duc Tran on 11/29/15.
//  Copyright © 2015 Developers Academy. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController
{
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    var index = 0               // the current page index
    var headerText = ""
    var imageName = ""
    var descriptionText = ""
    
    override var preferredStatusBarStyle : UIStatusBarStyle
    {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        headerLabel.text = headerText
        descriptionLabel.text = descriptionText
        imageView.image = UIImage(named: imageName)
        pageControl.currentPage = index
        
        // customize the next and start button
        startButton.isHidden = (index == 3) ? false : true
        nextButton.isHidden = (index == 3) ? true : false
        startButton.layer.cornerRadius = 5.0
        startButton.layer.masksToBounds = true
    }

    @IBAction func startClicked(_ sender: AnyObject)
    {
        // we're good with the walk through. 
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "DisplayedWalkthrough")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextClicked(_ sender: AnyObject)
    {
        let pageViewController = self.parent as! PageViewController
        pageViewController.nextPageWithIndex(index)
    }
}

























