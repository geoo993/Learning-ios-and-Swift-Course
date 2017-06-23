//
//  BBCiPlayerTableviewCollectionViewCell.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 20/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class BBCiPlayerTableviewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageHeadingView : UIImageView!
    @IBOutlet weak var imageHeadingLabel : UILabel!
    @IBOutlet weak var channelLabel : UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    deinit {
        imageHeadingView = nil
        imageHeadingLabel = nil
        channelLabel = nil
        titleLabel = nil
        descriptionLabel = nil
    }
}
