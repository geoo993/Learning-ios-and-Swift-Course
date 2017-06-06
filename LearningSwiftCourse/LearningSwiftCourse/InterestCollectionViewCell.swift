//
//  InterestCollectionViewCell.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 25/05/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

public class InterestCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var interestTitleLabel: UILabel!
    @IBOutlet weak var interestFeaturedImageView: UIImageView!
    
    var interestTitle : String! {
        didSet{
            interestTitleLabel.text = interestTitle
        }
    }
    
    var interestFeatureImage : UIImage! {
        didSet{
            interestFeaturedImageView.image = interestFeatureImage
        }
    }
    
  
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder) 
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
}
