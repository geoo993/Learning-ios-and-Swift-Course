//
//  WalkthroughViewController.swift
//  StorySmartiesView
//
//  Created by GEORGE QUENTIN on 09/08/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

public class WalkthroughViewController: UIViewController {

    @IBOutlet weak var imageView : CircularImageView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var pageControl : CHIPageControlAji!
    @IBOutlet weak var skipButton : UIButton!
    @IBOutlet weak var nextButton : UIButton!
    
    public var skipAction = { }
    public var nextAction = { }

    public var numberOfPages = 5
    public var pageIndex = -1
    
    var pageModel : WalkthroughPageModel?
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        guard let pageModel = pageModel else { return }
        titleLabel.text = pageModel.title
        descriptionLabel.text = pageModel.description
        
        imageView.image = UIImage(named: pageModel.imageUrl)
        
        pageControl.numberOfPages = numberOfPages
        pageControl.progress = Double(pageIndex)
        
        if pageIndex >= (numberOfPages - 1) {
            nextButton.setTitle("Continue", for: .normal)
        }else{
            nextButton.setTitle("Next", for: .normal)
        }
         
    }


    @IBAction func skipButtonAction(_ sender : UIButton){
        self.skipAction()
    }
    
    @IBAction func nextButtonAction(_ sender : UIButton){
        self.nextAction()
    }
    
}
